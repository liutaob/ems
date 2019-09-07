package com.ems.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 	页面展示Controller
 * @author liut
 *
 */
@Controller
public class PageController {
	
	/**
	 * 	默认访问登录页面
	 * @autor liut
	 * @date  2019年3月30日上午12:28:26
	 * @params
	 * @return String
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/")
	public String showIndex(HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException {
		System.out.println(request.getRequestURI());
		System.out.println(request.getRequestURL());
		/**
		 *   获取上次登录失败错误信息 中文解码
		 */
		String errorMsg = request.getParameter("errorMsg");
		errorMsg = StringUtils.isEmpty(errorMsg)?"":URLDecoder.decode(errorMsg, "utf-8");
		request.setAttribute("errorMsg", errorMsg);
		return "login";
	}
	
	/**
	 *  页面切换
	 * @autor liut
	 * @date  2019年3月30日上午12:28:45
	 * @params
	 * @return String
	 */
	@RequestMapping("/{page}")
	public String showPage(@PathVariable String page) {
		return page;
	}
}
