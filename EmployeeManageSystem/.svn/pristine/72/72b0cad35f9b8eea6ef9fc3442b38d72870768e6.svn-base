package com.ems.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ems.bean.EmsSalary;
import com.ems.common.model.EmsResult;
import com.ems.service.interf.SalaryService;
import com.github.pagehelper.PageInfo;

/**
 * 工资管理Controller
 * @author liut
 * @date 2019年4月11日下午9:54:38
 */
@Controller
public class SalaryController {
	
	@Autowired
	private SalaryService salaryService;
	
	/**
	 *  跳转发放工资页面
	 * @autor liut
	 * @date  2019年4月11日下午10:09:14
	 * @params
	 * @return String
	 */
	@RequestMapping("/salary/showAddSalary")
	public String gotoReleaseSalaryPage() {
		return "/salary/releaseSalary";
	}
	
	/**
	 * 发放工资验证员工是否存在
	 * @autor liut
	 * @date  2019年4月11日下午10:50:02
	 * @params
	 * @return EmsResult
	 */
	@RequestMapping(value="/employee/yz",method=RequestMethod.POST)
	@ResponseBody
	public EmsResult yzIsExitEmployee(HttpServletRequest request) {
		EmsResult result = salaryService.yzIsExitEmployee(request);
		return result;
	}
	
	/**
	 *  发放工资
	 * @autor liut
	 * @date  2019年4月11日下午11:24:14
	 * @params
	 * @return EmsResult
	 */
	@RequestMapping(value="/salary/addSalary",method=RequestMethod.POST)
	@ResponseBody
	public EmsResult addSalary(EmsSalary salary) {
		EmsResult result = salaryService.addSalary(salary);
		return result;
	}
	
	/**
	 *  工资发放记录查询页
	 * @autor liut
	 * @date  2019年4月8日下午9:26:49
	 * @params
	 * @return String
	 */
	@RequestMapping("/salary/showSalary/{currentPage}")
	public String gotoJobPage(@PathVariable Integer currentPage,Map<String,Object> map) {
		//分页查询工资发放记录
		PageInfo<EmsSalary> pageInfo = salaryService.showSalary(currentPage, 10);
		//数据放入model
		map.put("pageInfo", pageInfo);
		return "/salary/salary-list";
	}
	
	/**
	 * 删除工资发放记录
	 * @autor liut
	 * @date  2019年4月7日上午12:44:20
	 * @params
	 * @return void
	 */
	@RequestMapping(value="/salary/deleteSalary")
	public String deleteSalary(@RequestParam("ids") List<Long> ids,Integer currentPage) {
		salaryService.deleteSalary(ids);
		return "redirect:/salary/showSalary/"+currentPage;
	}
	
	
	/**
	 * 一键发工资
	 * @autor liut
	 * @date  2019年4月12日上午1:53:43
	 * @params
	 * @return String
	 */
	@RequestMapping(value="/salary/updateSalary")
	public String updateSalary(@RequestParam("ids") List<Long> ids,Integer currentPage) {
		salaryService.updateSalary(ids);
		return "redirect:/salary/showSalary/"+currentPage;
	}
	
	/**
	 * 条件查询工资记录
	 * @autor liut
	 * @date  2019年4月12日上午1:59:39
	 * @params
	 * @return String
	 */
	@RequestMapping(value= "/salary/{currentPage}/findSalaryByCon",method=RequestMethod.POST)
	public String showEmployeeByCon(@PathVariable Integer currentPage,HttpServletRequest request) {
		PageInfo<EmsSalary> pageInfo = salaryService.showSalaryByCon(request,currentPage, 10);
		request.setAttribute("pageInfo", pageInfo);
		return "/salary/salary-list";
	}
	
}
