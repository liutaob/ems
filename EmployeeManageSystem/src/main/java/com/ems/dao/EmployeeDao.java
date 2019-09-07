package com.ems.dao;

import java.util.List;

import com.ems.bean.EmsEmpQuery;
import com.ems.common.model.Employee;

/**
 * 扩展的员工接口
 * @author liut
 * @date 2019年4月6日下午10:25:52
 */
public interface EmployeeDao {

	List<Employee> findAllEmployee();
	
	
//	Employee findEmployeeById(int id);
}
