package com.ems.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.bean.EmsEmp;
import com.ems.bean.EmsEmpQuery;
import com.ems.bean.EmsJob;
import com.ems.bean.EmsJobQuery;
import com.ems.bean.EmsJobQuery.Criteria;
import com.ems.common.model.EmsResult;
import com.ems.dao.EmsEmpDao;
import com.ems.dao.EmsJobDao;
import com.ems.service.interf.JobService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 *	 职位管理Service
 * @author liut
 * @date 2019年4月3日下午4:18:47
 */
@Service
public class JobServiceImpl implements JobService {
	
	@Autowired
	private EmsJobDao emsJobDao;
	@Autowired
	private EmsEmpDao emsEmpDao;
	
	/**
	 * 	获取所有的职位
	 * @autor liut
	 * @date  2019年4月3日下午4:18:47
	 * @params
	 * @return @see com.ems.service.interf.JobService#findAllJob()
	 */
	@Override
	public List<EmsJob> findAllJob() {
		EmsJobQuery query = new EmsJobQuery();
		List<EmsJob> list = emsJobDao.selectByExample(query);
		return list;
	}

	/**
	 * 	根据部门获取对应职位列表
	 * @autor liut
	 * @date  2019年4月3日下午4:50:26
	 * @params
	 * @return @see com.ems.service.interf.JobService#findJobsByDept(java.lang.Long)
	 */
	@Override
	public List<EmsJob> findJobsByDept(HttpServletRequest request) {
		/**
		 * 校验是否选择了部门
		 */
		String deptId = request.getParameter("deptId");
		if("0".equals(deptId)||deptId==null) {
			return null;
		}
		//获取对应部门下职位列表
		EmsJobQuery query= new EmsJobQuery();
		Criteria criteria= query.createCriteria();
		criteria.andDeptIdEqualTo(Long.parseLong(deptId));
		List<EmsJob> list = emsJobDao.selectByExample(query);
		return list;
	}
	
	/**
	 * 	分页查询职位
	 * @autor liut
	 * @date  2019年4月8日下午9:21:37
	 * @params
	 * @return @see com.ems.service.interf.JobService#findJobList(int, int)
	 */
	@Override
	public PageInfo<EmsJob> findJobList(int curpage, int row) {
		//设置分页参数
		PageHelper.startPage(curpage, row);
		//获取所有职位信息
		EmsJobQuery query = new EmsJobQuery();
		List<EmsJob> list = emsJobDao.selectByExample(query);
		//返回分页职位信息
		return new PageInfo<EmsJob>(list);
	}
	
	/**
	 * 	条件搜索职位
	 * @autor liut
	 * @date  2019年4月8日下午9:54:23
	 * @params
	 * @return @see com.ems.service.interf.JobService#findJobListByCon(com.ems.bean.EmsJob, int, int)
	 */
	@Override
	public PageInfo<EmsJob> findJobListByCon(EmsJob job, int curpage, int row) {
		//设置搜索条件
		EmsJobQuery query = new EmsJobQuery();
		Criteria criteria = query.createCriteria();
		//职位名称
		criteria.andNameLike("%"+job.getName()+"%");
		if(!"0".equals(job.getDeptId().toString())) {
			//部门
			criteria.andDeptIdEqualTo(job.getDeptId());
		}
		//分页参数
		PageHelper.startPage(curpage, row);
		//获取分页结果
		List<EmsJob> list = emsJobDao.selectByExample(query);
		return new PageInfo<EmsJob>(list);
	}

	
	/**
	 * 	根据id获取职位信息
	 * @autor liut
	 * @date  2019年4月8日下午10:18:42
	 * @params
	 * @return @see com.ems.service.interf.JobService#findJobById(long)
	 */
	@Override
	public EmsJob findJobById(long jobId) {
		EmsJob job = emsJobDao.selectByPrimaryKey(jobId);
		return job;
	}
	
	/**
	 * 	更新职位信息
	 * @autor liut
	 * @date  2019年4月3日下午4:50:26
	 * @params
	 * @return @see com.ems.service.interf.JobService#updateJob(com.ems.bean.EmsJob)
	 */
	@Override
	public EmsResult updateJob(EmsJob job,HttpSession session) {
		EmsJob oldJob = (EmsJob) session.getAttribute("job");
		//校验更改后部门名是否已存在
		if(!StringUtils.equals(oldJob.getName(), job.getName())) {
			EmsJobQuery query = new EmsJobQuery();
			Criteria criteria = query.createCriteria();
			criteria.andNameEqualTo(job.getName());
			List<EmsJob> list = emsJobDao.selectByExample(query);
			if(list!=null && list.size() > 0) 
				//职位名已存在
				return EmsResult.build(500, "职位名已存在");
		}
		//更新职位信息
		emsJobDao.updateByPrimaryKey(job);
		return EmsResult.ok();
	}
	
	
	/**
	 * 	删除职位
	 * @autor liut
	 * @date  2019年4月3日下午4:50:26
	 * @params
	 * @return @see com.ems.service.interf.JobService#deleteJob(java.lang.Long)
	 */
	@Override
	public EmsResult deleteJob(Long id) {
		/**
		 * 	先检查该职位上是否有人
		 */
		EmsEmpQuery query = new EmsEmpQuery();
		com.ems.bean.EmsEmpQuery.Criteria criteria = query.createCriteria();
		criteria.andJobIdEqualTo(id);
		List<EmsEmp> list = emsEmpDao.selectByExample(query);
		if(list!=null&&list.size()>0) {
			return EmsResult.build(500, "该职位有人，无法删除！");
			//或者删除该职位所有人
			//emsEmpDao.deleteByExample(query);
		}
		try {
			emsJobDao.deleteByPrimaryKey(id);
		} catch (Exception e) {
			e.printStackTrace();
			return EmsResult.build(500, "删除失败");
		}
		return EmsResult.ok();
	}
	
	/**
	 * @autor liut
	 * @date  2019年4月3日下午4:50:26
	 * @params
	 * @return @see com.ems.service.interf.JobService#addJob(com.ems.bean.EmsJob)
	 */
	@Override
	public EmsResult addJob(EmsJob job) {
		//校验职位名字
		EmsJobQuery query = new EmsJobQuery();
		Criteria criteria = query.createCriteria();
		criteria.andNameEqualTo(job.getName());
		List<EmsJob> list = emsJobDao.selectByExample(query);
		if(list!=null && list.size() > 0)
			return EmsResult.build(500, "职位名字已存在");
		//校验通过 插入数据库
		try {
			//保证插入的ID以1递增   配合不使用扩展类分页查询 手写dao bean类关系	 或页面用jstl标签
//			EmsJobQuery query2 = new EmsJobQuery();
//			List<EmsJob> list2 = emsJobDao.selectByExample(query2);
//			if(list2!=null&&list2.size()!=0)
//				job.setId(list2.get(list2.size()-1).getId()+1);
			emsJobDao.insert(job);
		} catch (Exception e) {
			e.printStackTrace();
			return EmsResult.build(500, "添加职位失败，请检查数据是否正确");
		}
		return EmsResult.ok();
	}


	
	

}
