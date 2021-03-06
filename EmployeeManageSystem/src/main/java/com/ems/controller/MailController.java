package com.ems.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ems.bean.EmsMail;
import com.ems.common.model.EmsResult;
import com.ems.service.interf.MailService;
import com.github.pagehelper.PageInfo;

/**
 * 邮件管理Controller
 * @author liut
 * @date 2019年4月12日下午5:18:52
 */
@Controller
public class MailController {
	
	@Autowired
	private MailService mailService;
	
	/**
	 * 跳转到发邮件页面
	 * @autor liut
	 * @date  2019年4月12日下午8:05:27
	 * @params
	 * @return String
	 */
	@RequestMapping("/mail/gotoAddMail")
	public String gotoAddMailPage(Long receiverId,Model model) {
		model.addAttribute("receiverId", receiverId);
		return	"mail/showAddMail";
	}
	
	/**
	 * 发送邮件
	 * @autor liut
	 * @date  2019年4月12日下午8:27:50
	 * @params
	 * @return EmsResult
	 */
	@RequestMapping(value="/mail/addMail",method=RequestMethod.POST)
	@ResponseBody
	public EmsResult sendMail(EmsMail mail,HttpSession session) {
		EmsResult result = mailService.sendMail(mail, session);
		return result;
	}
	
	/**
	 * 查看发件箱
	 * @autor liut
	 * @date  2019年4月12日下午8:57:28
	 * @params
	 * @return String
	 */
	@RequestMapping("mail/showSendMail/{curpage}")
	public String showSendMail(@PathVariable Integer curpage,@RequestParam("userId")Long empId,Model model) {
		PageInfo<EmsMail> pageInfo = mailService.showSendMail(empId, curpage, 5);
		model.addAttribute("pageInfo", pageInfo);
		return "mail/sendMail-list";
	}
	
	/**
	 * 查看收件箱
	 * @autor liut
	 * @date  2019年4月12日下午8:57:28
	 * @params
	 * @return String
	 */
	@RequestMapping("mail/showReceiveMail/{curpage}")
	public String showReceiveMail(@PathVariable Integer curpage,@RequestParam("userId")Long empId,Model model) {
		PageInfo<EmsMail> pageInfo = mailService.showReceiveMail(empId, curpage, 5);
		model.addAttribute("pageInfo", pageInfo);
		return "mail/receiveMail-list";
	}
	
	/**
	 * 预览邮件
	 * @autor liut
	 * @date  2019年4月12日下午5:24:27
	 * @params
	 * @return String
	 */
	 @RequestMapping(value="/mail/previewMail")
	 public String previewNotice(Long id,Model model){
		 EmsMail mail = mailService.findMailById(id);
		 model.addAttribute("mail", mail);
		 return "mail/previewMail";
	}
	 
}
