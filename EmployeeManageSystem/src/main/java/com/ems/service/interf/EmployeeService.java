package com.ems.service.interf;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ems.bean.EmsEmp;
import com.ems.common.model.EmsResult;
import com.github.pagehelper.PageInfo;

/**
 * @author liut
 * @date 2019年3月29日下午10:20:15
 */
public interface EmployeeService {
	
	EmsResult register(EmsEmp employee,HttpServletRequest request) throws Exception;
	
	EmsResult login(String username, String password, String oauthcode, HttpSession session);
	
	PageInfo<EmsEmp> findAllEmployee(int curpage, int row);
	
	void deleteEmployee(List<Long> ids);
	
	PageInfo<EmsEmp> findEmployeesByCon(int curpage,int row,HttpServletRequest request);
	
	EmsEmp findEmployeeByIdWithDeptAndJob(long employeeId);
	
	EmsResult updateEmployee(EmsEmp employee, HttpSession session);
	
	EmsResult updatePassword(String oldPassword,String newPassword, HttpSession session) throws Exception;
	
	EmsResult resetPassword(String username,String password) throws Exception;
	
}
