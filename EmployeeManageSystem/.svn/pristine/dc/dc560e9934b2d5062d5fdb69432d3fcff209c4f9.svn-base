package com.ems.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ems.bean.EmsNotice;
import com.ems.service.interf.NoticeService;
import com.github.pagehelper.PageInfo;

/**
 * 	公告管理Controller
 * @author liut
 * @date 2019年4月12日下午2:30:43
 */
@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	/**
	 * 跳转发布公告页面
	 * @autor liut
	 * @date  2019年4月12日下午2:32:12
	 * @params
	 * @return String
	 */
	@RequestMapping("/notice/showAddNotice")
	public String gotoAddNoticePage() {
		return "notice/showAddNotice";
	}
	
	/**
	 *  发布公告
	 * @autor liut
	 * @date  2019年4月12日下午2:45:20
	 * @params
	 * @return String
	 */
	@RequestMapping("/notice/addNotice")
	public String addNotice(EmsNotice notice,HttpSession session) {
		noticeService.addNotice(notice, session);
		return "redirect:/notice/showAddNotice";
	}
	
	/**
	 *  分页展示新闻公告
	 * @autor liut
	 * @date  2019年4月12日下午3:11:35
	 * @params
	 * @return String
	 */
	@RequestMapping("/notice/showNotice/{currentPage}")
	public String showNotice(@PathVariable Integer currentPage,Model model,HttpSession session) {
		PageInfo<EmsNotice> pageInfo = noticeService.showNotice(currentPage, 5,session);
		model.addAttribute("pageInfo", pageInfo);
		return "/notice/notice-list";
	}
	
	/**
	 * 	模糊查询公告
	 * @autor liut
	 * @date  2019年4月8日下午10:02:42
	 * @params
	 * @return String
	 */
	@RequestMapping(value= "/notice/{currentPage}/findNoticeByCon",method=RequestMethod.POST)
	public String showNoticeByCon(@PathVariable Integer currentPage,EmsNotice notice,Model model,HttpSession session) {
		PageInfo<EmsNotice> pageInfo = noticeService.showNoticeByCon(notice, currentPage, 5,session);
		model.addAttribute("pageInfo", pageInfo);
		return "/notice/notice-list";
	}
	
	/**
	 * 删除公告
	 * @autor liut
	 * @date  2019年4月12日下午4:12:24
	 * @params
	 * @return String
	 */
	@RequestMapping(value="/notice/deleteNotice")
	public String deleteNotice(@RequestParam("ids") List<Long> ids,Integer currentPage) {
		noticeService.deleteNotice(ids);
		return "redirect:/notice/showNotice/"+currentPage;
	}
	
	/**
	 * 预览公告
	 * @autor liut
	 * @date  2019年4月12日下午5:24:27
	 * @params
	 * @return String
	 */
	 @RequestMapping(value="/notice/previewNotice")
	 public String previewNotice(Long id,Model model){
		EmsNotice notice = noticeService.findNoticeById(id);
		model.addAttribute("notice", notice);
		return "notice/previewNotice";
	}
}
