package com.ems.service.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.bean.EmsDept;
import com.ems.bean.EmsDeptQuery;
import com.ems.bean.EmsDeptQuery.Criteria;
import com.ems.bean.EmsEmp;
import com.ems.bean.EmsEmpQuery;
import com.ems.common.model.EmsResult;
import com.ems.dao.EmsDeptDao;
import com.ems.dao.EmsEmpDao;
import com.ems.service.interf.DeptService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 	部门管理Service
 * @author liut
 * @date 2019年4月3日下午4:14:46
 */
@Service
public class DeptServiceImpl implements DeptService {

	@Autowired
	private EmsDeptDao emsDeptDao;
	@Autowired
	private EmsEmpDao emsEmpDao;
	
	/**
	 * 	获取所有的部门集合
	 * @autor liut
	 * @date  2019年4月3日下午4:14:47
	 * @params
	 * @return @see com.ems.service.interf.DeptService#findAllDept()
	 */
	@Override
	public List<EmsDept> findAllDept() {
		EmsDeptQuery query = new EmsDeptQuery();
		List<EmsDept> list = emsDeptDao.selectByExample(query);
		return list;
	}

	/**
	 * 	分页获取部门集合
	 * @autor liut
	 * @date  2019年4月8日下午3:10:02
	 * @params
	 * @return @see com.ems.service.interf.DeptService#findDeptList(int, int)
	 */
	@Override
	public PageInfo<EmsDept> findDeptList(int curpage, int row) {
		//设置分页参数
		PageHelper.startPage(curpage, row);
		//获取所有部门集合
		EmsDeptQuery query = new EmsDeptQuery();
		List<EmsDept> list = emsDeptDao.selectByExample(query);
		//返回分页部门集合
		return new PageInfo<EmsDept>(list);
	}
	
	/**
	 * 	根据部门id获取部门信息
	 * @autor liut
	 * @date  2019年4月8日下午3:32:31
	 * @params
	 * @return @see com.ems.service.interf.DeptService#findDeptById(long)
	 */
	@Override
	public EmsDept findDeptById(long deptId) {
		EmsDept dept = emsDeptDao.selectByPrimaryKey(deptId);
		return dept;
	}
	
	/**
	 *  修改部门信息
	 * @autor liut
	 * @date  2019年4月3日下午4:50:17
	 * @params
	 * @return @see com.ems.service.interf.DeptService#updateDept(com.ems.bean.EmsDept)
	 */
	@Override
	public EmsResult updateDept(EmsDept dept,HttpSession session) {
		EmsDept oldDept = (EmsDept) session.getAttribute("department");
		//校验更改后部门名是否已存在
		if(!StringUtils.equals(oldDept.getDeptName(), dept.getDeptName())) {
			EmsDeptQuery query = new EmsDeptQuery();
			Criteria criteria = query.createCriteria();
			criteria.andDeptNameEqualTo(dept.getDeptName());
			List<EmsDept> list = emsDeptDao.selectByExample(query);
			if(list!=null && list.size() > 0) 
				//数据库中部门名已存在
				return EmsResult.build(500, "部门名已存在");
		}
		//更新部门信息
		emsDeptDao.updateByPrimaryKey(dept);
		return EmsResult.ok();
	}
	
	/**
	 * 	新增部门
	 * @autor liut
	 * @date  2019年4月3日下午4:50:17
	 * @params
	 * @return @see com.ems.service.interf.DeptService#addDept(com.ems.bean.EmsDept)
	 */
	@Override
	public EmsResult addDept(EmsDept dept) {
		//校验部门名字
		EmsDeptQuery query = new EmsDeptQuery();
		Criteria criteria = query.createCriteria();
		criteria.andDeptNameEqualTo(dept.getDeptName());
		List<EmsDept> list = emsDeptDao.selectByExample(query);
		if(list!=null && list.size() > 0)
			return EmsResult.build(500, "部门名字已存在");
		//校验通过 插入数据库
		try {
			//保证插入的ID以1递增   配合不使用扩展类分页查询 手写dao bean类关系	 或页面用jstl标签
//			EmsDeptQuery query2 = new EmsDeptQuery();
//			List<EmsDept> list2 = emsDeptDao.selectByExample(query2);
//			if(list2!=null&&list2.size()!=0)
//				dept.setId(list2.get(list2.size()-1).getId()+1);
			emsDeptDao.insert(dept);
		} catch (Exception e) {
			e.printStackTrace();
			return EmsResult.build(500, "新增部门失败，请检查数据是否正确");
		}
		return EmsResult.ok();
	}

	

	/**
	 * 	删除部门
	 * @autor liut
	 * @date  2019年4月3日下午4:50:17
	 * @params
	 * @return @see com.ems.service.interf.DeptService#deleteDept(java.lang.Long)
	 */
	@Override
	public EmsResult deleteDept(Long id) {
		/**
		 * 	先检查该部门是否有人
		 */
		EmsEmpQuery query = new EmsEmpQuery();
		com.ems.bean.EmsEmpQuery.Criteria criteria = query.createCriteria();
		criteria.andDeptIdEqualTo(id);
		List<EmsEmp> list = emsEmpDao.selectByExample(query);
		if(list!=null&&list.size()>0) {
			return EmsResult.build(500, "部门还有人，无法删除！");
			//或者删除该部门所有人
			//emsEmpDao.deleteByExample(query);
		}
		try {
			emsDeptDao.deleteByPrimaryKey(id);
		} catch (Exception e) {
			e.printStackTrace();
			return EmsResult.build(500, "删除失败");
		}
		return EmsResult.ok();
	}

	/**
	 * 	根据部门名模糊查询部门
	 * @autor liut
	 * @date  2019年4月8日下午6:18:09
	 * @params
	 * @return @see com.ems.service.interf.DeptService#findDeptsByCon(int, int, java.lang.String)
	 */
	@Override
	public PageInfo<EmsDept> findDeptsByCon(int curpage, int row, String deptName) {
		PageHelper.startPage(curpage, row);
		//设置部门名字为查询条件
		EmsDeptQuery query = new EmsDeptQuery();
		Criteria criteria = query.createCriteria();
		criteria.andDeptNameLike("%"+deptName+"%");
		List<EmsDept> list = emsDeptDao.selectByExample(query);
		//返回分页部门
		return new PageInfo<EmsDept>(list);
	}

	


}
