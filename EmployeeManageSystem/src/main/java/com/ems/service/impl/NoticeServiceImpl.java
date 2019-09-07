package com.ems.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.bean.EmsEmp;
import com.ems.bean.EmsNotice;
import com.ems.bean.EmsNoticeQuery;
import com.ems.bean.EmsNoticeQuery.Criteria;
import com.ems.common.util.IDUtils;
import com.ems.dao.EmsNoticeDao;
import com.ems.service.interf.NoticeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 	公告管理
 * @author liut
 * @date 2019年4月12日下午2:29:55
 */
@Service
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	private EmsNoticeDao emsNoticeDao;
	
	/**
	 * 	添加公告
	 * @autor liut
	 * @date  2019年4月12日下午2:46:12
	 * @params
	 * @return @see com.ems.service.interf.NoticeService#addNotice(com.ems.bean.EmsNotice)
	 */
	@Override
	public void addNotice(EmsNotice notice,HttpSession session) {
		//补全属性
		//利用时间戳+随机数生成公告ID
		long noticeId = IDUtils.genId();
		notice.setId(noticeId);
		//获取发布人
		EmsEmp employee = (EmsEmp) session.getAttribute("USERS_SESSION");
		notice.setEmpId(employee.getId());
		//发布时间
		notice.setCreated(new Date());
		//插入公告数据库
		emsNoticeDao.insert(notice);
	}

	/**
	 * 分页查询新闻公告
	 * @autor liut
	 * @date  2019年4月12日下午3:07:41
	 * @params
	 * @return @see com.ems.service.interf.NoticeService#showNotice(int, int)
	 */
	@Override
	public PageInfo<EmsNotice> showNotice(int curpage, int row,HttpSession session) {
		//设置分页参数
		PageHelper.startPage(curpage, row);
		//获取当前登录用户
		EmsEmp employee  = (EmsEmp) session.getAttribute("USERS_SESSION");
		EmsNoticeQuery query= new EmsNoticeQuery();
		//若是管理员展示所有公告 若是普通用户只展示所在部门和全体人员公告
		if(employee.getRoleId()==3) {
			Criteria criteria = query.createCriteria();
			List<Long> idList = new ArrayList<>();
			idList.add(employee.getDeptId());
			idList.add((long) 0);
			criteria.andDeptIdIn(idList);
		}
		//查询数据库
		List<EmsNotice> list = emsNoticeDao.selectByExampleWithBLOBs(query);
		//返回分页结果
		return new PageInfo<EmsNotice>(list);
	}

	/**
	 * 	模糊查询公告
	 * @autor liut
	 * @date  2019年4月12日下午3:40:53
	 * @params
	 * @return @see com.ems.service.interf.NoticeService#showNoticeByCon(com.ems.bean.EmsNotice, int, int)
	 */
	@Override
	public PageInfo<EmsNotice> showNoticeByCon(EmsNotice notice, int curpage, int row,HttpSession session) {
		//设置分页参数
		PageHelper.startPage(curpage, row);
		//获取当前登录用户
		EmsEmp employee  = (EmsEmp) session.getAttribute("USERS_SESSION");
		//设置查询条件
		EmsNoticeQuery query = new EmsNoticeQuery();
		Criteria criteria = query.createCriteria();
		criteria.andNoticeTitleLike("%"+notice.getNoticeTitle()+"%");
		if(employee.getRoleId()==3) {
			//若是普通用户只能查看本部门和全体人员
			List<Long> idList = new ArrayList<>();
			idList.add(employee.getDeptId());
			idList.add((long) 0);
			criteria.andDeptIdIn(idList);
		}else {
			//管理员可查看所有部门
			if(!"0".equals(notice.getDeptId().toString())){
				criteria.andDeptIdEqualTo(notice.getDeptId());
			}
		}
		List<EmsNotice> list = emsNoticeDao.selectByExampleWithBLOBs(query);
		return new PageInfo<EmsNotice>(list);
	}

	/**
	 * 	删除公告
	 * @autor liut
	 * @date  2019年4月12日下午4:07:43
	 * @params
	 * @return @see com.ems.service.interf.NoticeService#deleteSalary(java.util.List)
	 */
	@Override
	public void deleteNotice(List<Long> ids) {
		//设置查询条件
		EmsNoticeQuery query = new EmsNoticeQuery();
		Criteria criteria = query.createCriteria();
		criteria.andIdIn(ids);
		//删除数据库
		emsNoticeDao.deleteByExample(query);
	}

	/**
	 * 	根据公告id预览公告
	 * @autor liut
	 * @date  2019年4月12日下午5:25:29
	 * @params
	 * @return @see com.ems.service.interf.NoticeService#findNoticeById(java.lang.Long)
	 */
	@Override
	public EmsNotice findNoticeById(Long id) {
		EmsNotice notice = emsNoticeDao.selectByPrimaryKey(id);
		return notice;
	}

}
