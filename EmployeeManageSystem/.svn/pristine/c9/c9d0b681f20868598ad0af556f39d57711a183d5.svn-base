package com.ems.service.interf;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.ems.bean.EmsSalary;
import com.ems.common.model.EmsResult;
import com.github.pagehelper.PageInfo;

/**
 * @author liut
 * @date 2019年4月11日下午9:53:30
 */
public interface SalaryService {

	EmsResult yzIsExitEmployee(HttpServletRequest request);
	
	EmsResult addSalary(EmsSalary salary);
	
	PageInfo<EmsSalary> showSalary(int curpage, int row);
	
	void deleteSalary(List<Long> ids);
	
	void updateSalary(List<Long> ids);
	
	PageInfo<EmsSalary> showSalaryByCon(HttpServletRequest request,int curpage, int row);
}
