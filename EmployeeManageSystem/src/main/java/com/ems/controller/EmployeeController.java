package com.ems.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ems.bean.EmsEmp;
import com.ems.common.model.EmsResult;
import com.ems.common.util.ValidateCode;
import com.ems.service.interf.EmployeeService;
import com.github.pagehelper.PageInfo;

/**
 * 	员工管理Controller
 * @author liut
 * @date 2019年3月29日下午10:23:43
 */
@Controller
public class EmployeeController {
	private static final Logger logger = LoggerFactory.getLogger(EmployeeController.class);
	@Autowired
	private EmployeeService employeeService;
	
	/**
	 * 	登录
	 * @autor liut
	 * @date  2019年4月7日上午2:12:28
	 * @params
	 * @return EmsResult
	 */
	@RequestMapping(value="/tologin", method=RequestMethod.POST)
	@ResponseBody
	public EmsResult login(String username,String password,String oauthcode,HttpSession session) {
		//登录后将用户保存在session中
		EmsResult result = employeeService.login(username, password, oauthcode, session);
		return result;
	}
	
	/**
	 * 	验证码
	 * @autor liut
	 * @date  2019年4月7日上午2:12:49
	 * @params
	 * @return void
	 */
	@RequestMapping("/yzm")
	// 得到BufferedImage格式的验证码,需要转换JPG 这里需要做一个全局异常处理页面 404或者500
	public static void getyzm(HttpServletRequest req, HttpServletResponse rep) 
			throws IOException {
		// 设置响应的类型格式为图片格式
		rep.setContentType("image/jpeg");
		//禁止图像缓存。
		rep.setHeader("Pragma", "no-cache");
		rep.setHeader("Cache-Control", "no-cache");
		rep.setDateHeader("Expires", 0);
		HttpSession session = req.getSession();
		ValidateCode vCode = new ValidateCode(120,40,5,100);
		session.setAttribute("code", vCode.getCode());
		vCode.write(rep.getOutputStream());
	}
	
	/**
	 * 	注销账号
	 * @autor liut
	 * @date  2019年4月7日上午2:13:02
	 * @params
	 * @return String
	 */
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		EmsEmp currentUser = (EmsEmp) session.getAttribute("USERS_SESSION");
		logger.info(new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss").format(new Date())+"======"+currentUser.getUsername()+"退出系统");
		//清除用户信息
		session.removeAttribute("USERS_SESSION");
		session.removeAttribute("lastLoginName");
		session.removeAttribute("lastLoginPwd");
		//回到登录页面
		return "redirect:/";
	}
	
	
	/**
	 * 	添加员工
	 * @autor liut
	 * @date  2019年4月7日上午2:13:22
	 * @params
	 * @return EmsResult
	 * @throws Exception 
	 */
	@RequestMapping("/employee/addEmployee")
	@ResponseBody
	public EmsResult register(EmsEmp employee,HttpServletRequest request) throws Exception {
		EmsResult result = employeeService.register(employee,request);
		return result;
	}
	
	
	/**
	 * 	分页展示添加员工页面
	 * @autor liut
	 * @date  2019年4月3日下午3:36:45
	 * @params
	 * @return String
	 */
	@RequestMapping("/empoloyee/gotoAddEmployee")
	public String gotoAddEmployee() {
		return "employee/showAddEmployee";
	}
	
	/**
	 * 	跳转员工查询页面
	 * @autor liut
	 * @date  2019年4月3日下午3:39:35
	 * @params
	 * @return String
	 */
	@RequestMapping("/employee/showEmployee/{currentPage}")
	public String showEmployee(@PathVariable Integer currentPage,Model model) {
		//分页查询员工	数据放入model	扩展的bean类分页	扩展类暂时可作废
		//或者建立类关系表关系  或者${deptList[employee.deptId-1].deptName}
		PageInfo<EmsEmp> pageInfo = employeeService.findAllEmployee(currentPage, 10);
		model.addAttribute("pageInfo", pageInfo);
		return "employee/employee-list";
	}
	
	/**
	 * 	删除员工
	 * @autor liut
	 * @date  2019年4月7日上午12:44:20
	 * @params
	 * @return void
	 */
	@RequestMapping(value="/employee/deleteEmployee")
	public String deleteEmployee(@RequestParam("ids") List<Long> ids,Integer currentPage) {
		employeeService.deleteEmployee(ids);
		return "redirect:/employee/showEmployee/"+currentPage;
	}
	
	/**
	 * 	条件查询员工
	 * @autor liut
	 * @date  2019年4月7日上午3:09:17
	 * @params
	 * @return String
	 */
	@RequestMapping(value= "/employee/{currentPage}/findEmployeeByCon",method=RequestMethod.POST)
	public String showEmployeeByCon(@PathVariable Integer currentPage,HttpServletRequest request) {
		PageInfo<EmsEmp> pageInfo = employeeService.findEmployeesByCon(currentPage, 10, request);
		request.setAttribute("pageInfo", pageInfo);
		return "employee/employee-list";
	}
	
	/**
	 * 	跳转员工信息修改页
	 * @autor liut
	 * @date  2019年4月7日上午3:10:34
	 * @params
	 * @return String
	 */
	@RequestMapping(value="/employee/showUpdateEmployee")
	public String gotoUpdateEmployee(@RequestParam("id") Integer employeeId,@RequestParam("pageNum") Integer currentPage,HttpSession session) {
		//根据员工id查出员工并查出部门、职位
		EmsEmp employee= employeeService.findEmployeeByIdWithDeptAndJob(employeeId);
		//将员工信息和当前页数传递给页面
		session.setAttribute("employee", employee);
		session.setAttribute("pageNum", currentPage);
		return "/employee/showUpdateEmployee";
	}
	
	/**
	 * 	修改员工信息
	 * @autor liut
	 * @date  2019年4月8日上午1:15:31
	 * @params
	 * @return String
	 */
	@RequestMapping(value="/employee/updateEmployee",method=RequestMethod.POST)
	@ResponseBody
	public EmsResult updateEmployee(EmsEmp employee,HttpSession session) {
		EmsResult result = employeeService.updateEmployee(employee,session);
		return result;
	}
	
	
	
}
