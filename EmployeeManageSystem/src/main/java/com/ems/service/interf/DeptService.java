package com.ems.service.interf;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.ems.bean.EmsDept;
import com.ems.common.model.EmsResult;
import com.github.pagehelper.PageInfo;

/**
 * @author liut
 * @date 2019年4月3日下午4:13:00
 */
public interface DeptService {
	
	List<EmsDept> findAllDept();
	
	PageInfo<EmsDept> findDeptList(int curpage, int row);
	
	EmsDept findDeptById(long deptId);
	
	EmsResult updateDept(EmsDept dept,HttpSession session);
	
	EmsResult addDept(EmsDept dept);
	
	EmsResult deleteDept(Long id);
	
	PageInfo<EmsDept> findDeptsByCon(int curpage,int row,String deptName);
}
