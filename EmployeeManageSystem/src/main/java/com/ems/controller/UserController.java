package com.ems.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ems.bean.EmsEmp;
import com.ems.common.model.EmsResult;
import com.ems.service.interf.EmployeeService;

/**
 * 	账号管理Controller
 * @author liut
 * @date 2019年4月8日上午2:38:10
 */
@Controller
public class UserController {

	@Autowired
	private EmployeeService employeeService;
	
	/**
	 * 	跳转账号管理页面
	 * @autor liut
	 * @date  2019年4月8日下午9:08:54
	 * @params
	 * @return String
	 */
	@RequestMapping("/user/gotoUserAccount")
	public String gotoUserAccount() {
		return "/employee/userAccount";
	}
	
	/**
	 * 	修改密码或找回密码
	 * @autor liut
	 * @date  2019年4月8日下午9:09:26
	 * @params
	 * @return EmsResult
	 * @throws Exception 
	 */
	@RequestMapping(value="/user/updateUserAccount",method=RequestMethod.POST)
	@ResponseBody
	public EmsResult updateUserAccount(HttpServletRequest request) throws Exception {
		//获取当前登录的用户
		HttpSession session = request.getSession();
		EmsEmp employee = (EmsEmp) session.getAttribute("USERS_SESSION");
		EmsResult result=null;
		//管理员
		if(employee.getRoleId()<3) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			result = employeeService.resetPassword(username, password);
		}else {
		//普通用户
			String oldpwd = request.getParameter("oldpwd");
			String password = request.getParameter("password");
			result = employeeService.updatePassword(oldpwd, password, session);
		}
		return result;
	}
}
