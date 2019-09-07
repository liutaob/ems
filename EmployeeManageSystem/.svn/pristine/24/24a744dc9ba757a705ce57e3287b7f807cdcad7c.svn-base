package com.ems.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ems.bean.EmsDept;
import com.ems.bean.EmsJob;
import com.ems.common.model.EmsResult;
import com.ems.service.interf.JobService;
import com.github.pagehelper.PageInfo;

/**
 * 	职位管理Controller
 * @author liut
 * @date 2019年4月3日下午5:35:23
 */
@Controller
public class JobController {
	
	@Autowired
	private JobService jobService;

	/**
	 * 	根据部门获取对应职位列表
	 * @autor liut
	 * @date  2019年4月8日下午2:29:11
	 * @params
	 * @return EmsResult
	 */
	@RequestMapping("/job/findJobsByDept")
	@ResponseBody
	public EmsResult findJobsByDept(HttpServletRequest request) {
		List<EmsJob> list = jobService.findJobsByDept(request);
		//未选择部门
		if(list==null) return EmsResult.build(500, "请选择部门");
		return EmsResult.ok(list);
	}
	
	/**
	 *  	职位查询页
	 * @autor liut
	 * @date  2019年4月8日下午9:26:49
	 * @params
	 * @return String
	 */
	@RequestMapping("job/showJob/{currentPage}")
	public String gotoJobPage(@PathVariable Integer currentPage,Map<String,Object> map) {
		//分页查询职位
		PageInfo<EmsJob> pageInfo = jobService.findJobList(currentPage, 10);
		//数据放入model
		map.put("pageInfo", pageInfo);
		return "/job/job-list";
	}
	
	/**
	 * 	模糊查询职位
	 * @autor liut
	 * @date  2019年4月8日下午10:02:42
	 * @params
	 * @return String
	 */
	@RequestMapping(value= "/job/{currentPage}/findJobByCon",method=RequestMethod.POST)
	public String showEmployeeByCon(@PathVariable Integer currentPage,EmsJob job,Model model) {
		PageInfo<EmsJob> pageInfo = jobService.findJobListByCon(job, currentPage, 10);
		model.addAttribute("pageInfo", pageInfo);
		return "/job/job-list";
	}
	
	/**
	 *	 展示职位修改页面
	 * @autor liut
	 * @date  2019年4月8日下午10:16:27
	 * @params
	 * @return String
	 */
	@RequestMapping(value= {"/job/showUpdateJob"})
	public String gotoDeptUpdatePage(@RequestParam("id") Integer jobId,@RequestParam("pageNum") Integer currentPage,HttpSession session) {
		EmsJob job = jobService.findJobById(jobId);
		//将职位信息和当前页数传递给页面
		session.setAttribute("job", job);
		session.setAttribute("pageNum", currentPage);
		return "/job/showUpdateJob";
	}
	
	/**
	 *	 修改职位信息
	 * @autor liut
	 * @date  2019年4月8日下午10:36:34
	 * @params
	 * @return EmsResult
	 */
	@RequestMapping(value="/job/updateJob",method=RequestMethod.POST)
	@ResponseBody
	public EmsResult updateJob(EmsJob job,HttpSession session) {
		EmsResult result = jobService.updateJob(job,session);
		//同步所有职位
		List<EmsJob> jobList = jobService.findAllJob();
		session.setAttribute("jobList", jobList);
		return result;
	}
	
	/**
	 * 	删除职位
	 * @autor liut
	 * @date  2019年4月8日下午10:44:31
	 * @params
	 * @return EmsResult
	 */
	@RequestMapping(value="/job/deleteJob",method=RequestMethod.POST)
	@ResponseBody
	public EmsResult deleteDept(@RequestParam("jobId")Long jobId,HttpSession session) {
		EmsResult result = jobService.deleteJob(jobId);
		//同步所有职位
		List<EmsJob> jobList = jobService.findAllJob();
		session.setAttribute("jobList", jobList);
		return result;
	}
	
	/**
	 * 	跳转至添加职位页面
	 * @autor liut
	 * @date  2019年4月8日下午10:54:14
	 * @params
	 * @return String
	 */
	@RequestMapping("/job/gotoAddJob")
	public String gotoAddDept() {
		return "/job/showAddJob";
	}
	
	/**
	 * 	添加职位
	 * @autor liut
	 * @date  2019年4月8日下午10:54:41
	 * @params
	 * @return EmsResult
	 */
	@RequestMapping(value="/job/addJob",method=RequestMethod.POST)
	@ResponseBody
	public EmsResult addDept(EmsJob job,HttpSession session) {
		EmsResult result = jobService.addJob(job);
		//同步所有职位
		List<EmsJob> jobList = jobService.findAllJob();
		session.setAttribute("jobList", jobList);
		return result;
	}
}
