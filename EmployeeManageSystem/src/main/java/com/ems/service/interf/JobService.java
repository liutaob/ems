package com.ems.service.interf;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ems.bean.EmsJob;
import com.ems.common.model.EmsResult;
import com.github.pagehelper.PageInfo;

/**
 * @author liut
 * @date 2019年4月3日下午4:18:04
 */
public interface JobService {

	List<EmsJob> findAllJob();

	List<EmsJob> findJobsByDept(HttpServletRequest request);
	
	PageInfo<EmsJob> findJobList(int curpage, int row);
	
	PageInfo<EmsJob> findJobListByCon(EmsJob job,int curpage,int row);
	
	EmsJob findJobById(long jobId);
	
	EmsResult updateJob(EmsJob job,HttpSession session);
	
	EmsResult addJob(EmsJob job);

	EmsResult deleteJob(Long id);
}
