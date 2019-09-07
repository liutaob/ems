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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ems.bean.EmsDept;
import com.ems.common.model.EmsResult;
import com.ems.service.interf.DeptService;
import com.github.pagehelper.PageInfo;

/**
 *	 部门管理Controller
 * @author liut
 * @date 2019年4月8日下午3:02:06
 */
@Controller
public class DeptController {

	@Autowired
	private DeptService deptService;
	
	/**
	 * 	跳转部门查询页面
	 * @autor liut
	 * @date  2019年4月8日下午3:08:05
	 * @params
	 * @return ModelAndView
	 */
	@RequestMapping("/dept/showDept/{currentPage}")
	public ModelAndView gotoDeptPage(@PathVariable Integer currentPage) {
		//分页查询部门
		PageInfo<EmsDept> pageInfo = deptService.findDeptList(currentPage, 10);
		//将数据放入model 返回视图
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/dept/dept-list");
		mv.addObject("pageInfo", pageInfo);
		return mv;
	}
	
	/**
	 * 	展示部门修改页面
	 * @autor liut
	 * @date  2019年4月8日下午5:51:51
	 * @params
	 * @return String
	 */
	@RequestMapping(value= {"/dept/showUpdateDept"})
	public String gotoDeptUpdatePage(@RequestParam("id") Integer deptId,@RequestParam("pageNum") Integer currentPage,HttpSession session) {
		EmsDept dept = deptService.findDeptById(deptId);
		//将部门信息和当前页数传递给页面
		session.setAttribute("department", dept);
		session.setAttribute("pageNum", currentPage);
		return "/dept/showUpdateDept";
	}
	
	/***
	 * 	修改部门信息
	 * @autor liut
	 * @date  2019年4月8日下午3:44:37
	 * @params
	 * @return EmsResult
	 */
	@RequestMapping(value="/dept/updateDept",method=RequestMethod.POST)
	@ResponseBody
	public EmsResult updateDept(EmsDept dept,HttpSession session) {
		EmsResult result = deptService.updateDept(dept,session);
		//同步所有部门
		List<EmsDept> deptList = deptService.findAllDept();
		session.setAttribute("deptList", deptList);
		return result;
	}
	
	/**
	 *  	删除部门
	 * @autor liut
	 * @date  2019年4月8日下午5:35:47
	 * @params
	 * @return EmsResult
	 */
	@RequestMapping(value="/dept/deleteDept",method=RequestMethod.POST)
	@ResponseBody
	public EmsResult deleteDept(@RequestParam("deptId")Long deptId,HttpSession session) {
		EmsResult result = deptService.deleteDept(deptId);
		//同步所有部门
		List<EmsDept> deptList = deptService.findAllDept();
		session.setAttribute("deptList", deptList);
		return result;
	}
	
	/**
	 * 	跳转至部门新增页面
	 * @autor liut
	 * @date  2019年4月8日下午5:40:02
	 * @params
	 * @return String
	 */
	@RequestMapping("/dept/gotoAddDept")
	public String gotoAddDept() {
		return "/dept/showAddDept";
	}
	
	/**
	 *  	新增部门
	 * @autor liut
	 * @date  2019年4月8日下午5:35:47
	 * @params
	 * @return EmsResult
	 */
	@RequestMapping(value="/dept/addDept",method=RequestMethod.POST)
	@ResponseBody
	public EmsResult addDept(EmsDept dept,HttpSession session) {
		EmsResult result = deptService.addDept(dept);
		//同步所有部门
		List<EmsDept> deptList = deptService.findAllDept();
		session.setAttribute("deptList", deptList);
		return result;
	}
	
	/**
	 * 	模糊查询部门
	 * @autor liut
	 * @date  2019年4月8日下午6:15:42
	 * @params
	 * @return String
	 */
	@RequestMapping(value= "/dept/{currentPage}/findDeptByCon",method=RequestMethod.POST)
	public String showEmployeeByCon(@PathVariable Integer currentPage,String deptName,Model model) {
		PageInfo<EmsDept> pageInfo = deptService.findDeptsByCon(currentPage, 10, deptName);
		model.addAttribute("pageInfo", pageInfo);
		return "/dept/dept-list";
	}
	
}
