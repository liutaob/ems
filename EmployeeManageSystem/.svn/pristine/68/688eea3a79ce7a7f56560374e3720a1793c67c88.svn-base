package com.ems.service.interf;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.ems.bean.EmsMail;
import com.ems.common.model.EmsResult;
import com.github.pagehelper.PageInfo;

/**
 * @author liut
 * @date 2019年4月12日下午5:17:56
 */
public interface MailService {
	
	EmsResult sendMail(EmsMail mail,HttpSession session);
	
	PageInfo<EmsMail> showSendMail(long empId,int curpage,int row);
	
	PageInfo<EmsMail> showReceiveMail(long empId,int curpage,int row);
	
	EmsMail findMailById(Long id);
	
} 
