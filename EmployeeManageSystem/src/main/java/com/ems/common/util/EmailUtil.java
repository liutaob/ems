package com.ems.common.util;

import java.io.File;
import java.io.InputStream;
import java.util.Properties;

import javax.mail.internet.MimeMessage;

import org.apache.commons.lang3.StringUtils;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

/**
 * 	发邮件工具类
 * @author liut
 * @date 2019年5月27日下午12:05:53
 */
public class EmailUtil {
	
	public static void sendMail(JavaMailSender javaMailSender, String toEmailAdress, String subject,
			String text, Boolean type, String location) throws Exception {
		System.out.println("正在发送邮件....");
		// 创建邮件对象
		MimeMessage mMessage = javaMailSender.createMimeMessage();
		MimeMessageHelper helper;
		Properties prop = new Properties();
		// 从配置文件中拿到发件人邮箱地址
		prop.load(EmailUtil.class.getResourceAsStream("/resource/mail.properties"));
		String from = prop.get("mail.smtp.username") + "";
		helper = new MimeMessageHelper(mMessage, true, "UTF-8");
		// 发件人邮箱
		helper.setFrom(from);
		// 收件人邮箱
		helper.setTo(toEmailAdress);
		// 邮件的主题也就是邮件的标题
		helper.setSubject(subject);
		// 邮件的文本内容，true表示文本以html格式打开
		helper.setText(text, type);
		//附件
		if(StringUtils.isNotEmpty(location)) {
			helper.addAttachment("一枚图片.jpg", new File(location));
		}
		//发送邮件
		javaMailSender.send(mMessage);
		System.out.println("邮件发送完毕。。。");
	}

}
