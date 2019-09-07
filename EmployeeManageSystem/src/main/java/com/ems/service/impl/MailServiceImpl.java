package com.ems.service.impl;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.bean.EmsEmp;
import com.ems.bean.EmsMail;
import com.ems.bean.EmsMailQuery;
import com.ems.bean.EmsMailQuery.Criteria;
import com.ems.common.model.EmsResult;
import com.ems.dao.EmsMailDao;
import com.ems.service.interf.MailService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 邮件管理
 * @author liut
 * @date 2019年4月12日下午5:18:15
 */
@Service
public class MailServiceImpl implements MailService {

	@Autowired
	private EmsMailDao emsMailDao;
	
	/**
	 * 	发送邮件
	 * @autor liut
	 * @date  2019年4月12日下午8:28:48
	 * @params
	 * @return @see com.ems.service.interf.MailService#sendMail(com.ems.bean.EmsMail)
	 */
	@Override
	public EmsResult sendMail(EmsMail mail,HttpSession session) {
		//获取当前用户
		EmsEmp employee = (EmsEmp) session.getAttribute("USERS_SESSION");
		//补全属性
		mail.setSenderId(employee.getId());
		mail.setTimes(new Date());
		//插入数据库
		emsMailDao.insert(mail);
		return EmsResult.ok();
	}

	/**
	 * 
	 * 	发件箱
	 * @autor liut
	 * @date  2019年4月12日下午8:50:36
	 * @params
	 * @return @see com.ems.service.interf.MailService#showSendMail(int, int, javax.servlet.http.HttpSession)
	 */
	@Override
	public PageInfo<EmsMail> showSendMail(long empId,int curpage, int row) {
		//设置分页参数 查询条件为发件人Id
		PageHelper.startPage(curpage, row);
		EmsMailQuery query = new EmsMailQuery();
		Criteria criteria = query.createCriteria();
		criteria.andSenderIdEqualTo(empId);
		List<EmsMail> list = emsMailDao.selectByExampleWithBLOBs(query);
		return new PageInfo<EmsMail>(list);
	}

	/**
	 * 	收件箱
	 * @autor liut
	 * @date  2019年4月12日下午8:50:36
	 * @params
	 * @return @see com.ems.service.interf.MailService#showReceiveMail(int, int, javax.servlet.http.HttpSession)
	 */
	@Override
	public PageInfo<EmsMail> showReceiveMail(long empId,int curpage, int row) {
		//设置分页参数 查询条件为收件人Id
		PageHelper.startPage(curpage, row);
		EmsMailQuery query = new EmsMailQuery();
		Criteria criteria = query.createCriteria();
		criteria.andReceiverIdEqualTo(empId);
		List<EmsMail> list = emsMailDao.selectByExampleWithBLOBs(query);
		return new PageInfo<EmsMail>(list);
	}

	/**
	 * 	预览邮件
	 * @autor liut
	 * @date  2019年4月12日下午9:12:19
	 * @params
	 * @return @see com.ems.service.interf.MailService#findMailById(java.lang.Long)
	 */
	@Override
	public EmsMail findMailById(Long id) {
		EmsMail mail = emsMailDao.selectByPrimaryKey(id);
		return mail;
	}


}
