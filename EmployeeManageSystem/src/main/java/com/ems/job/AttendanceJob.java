package com.ems.job;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;

import com.ems.bean.EmsEmp;
import com.ems.bean.EmsEmpQuery;
import com.ems.common.util.EmailUtil;
import com.ems.dao.EmsEmpDao;
import com.ems.service.impl.EmployeeServiceImpl;

/**
 * 	定时器任务
 * @author liut
 * @date 2019年5月3日上午10:46:44
 */
public class AttendanceJob {
	private static final Logger logger = LoggerFactory.getLogger(AttendanceJob.class);
	@Autowired
	private JavaMailSender javaMailSender;
	@Autowired
	private EmsEmpDao emsEmpDao;
	
	//每日打卡提醒 每天上午十点
	public void excuteJob() throws Exception {
		//给该员工邮箱发个邮件通知
		List<EmsEmp> list = emsEmpDao.selectByExample(new EmsEmpQuery());
		for (EmsEmp emsEmp : list) {
			//网页内容
			String text = "<p style=\"color: red;\">你好！"+ emsEmp.getUsername() +"别忘记打卡哟<br>"
					+ "<p>详情：</p>"+"公司管理系统网址：(https://www.iliutao.com)"
					+"<a style=‘color: red;’ href='https://www.iliutao.com'>点击进入阿里巴巴管理系统（安全连接0.0）</a><br/>"
					+"<hr/>本邮件为系统自动发送";
			new Thread() {
				public void run() {
					try {
						EmailUtil.sendMail(javaMailSender, emsEmp.getEmail(), "每日打卡提醒", text, true, null);
					} catch (Exception e) {
						e.printStackTrace();
						logger.error(e.getMessage()+e.getStackTrace());
					}
				}
			}.start();
			System.out.println("每日打卡提醒邮件已经发送...");
		}
	}
	
}
