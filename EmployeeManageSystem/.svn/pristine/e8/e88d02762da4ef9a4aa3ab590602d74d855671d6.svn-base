package com.ems.service.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ems.bean.EmsEmp;
import com.ems.bean.EmsRole;
import com.ems.bean.EmsRoleQuery;
import com.ems.bean.EmsRoleQuery.Criteria;
import com.ems.dao.EmsRoleDao;
import com.ems.service.interf.RoleService;

/**
 * 	角色等级用户身份Service
 * @author liut
 * @date 2019年4月8日下午1:53:17
 */
@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private EmsRoleDao emsRoleDao;
	
	/**
	 * 	获取所有角色等级
	 * @autor liut
	 * @date  2019年4月8日下午1:53:17
	 * @params
	 * @return @see com.ems.service.interf.RoleService#findAllRole()
	 */
	@Override
	public List<EmsRole> findAllRole() {
		//获取所有角色
		EmsRoleQuery query = new EmsRoleQuery();
		List<EmsRole> list = emsRoleDao.selectByExample(query);
		return list;
	}

	/**
	 * 	获取当前登录用户角色等级一下的角色集合
	 * @autor liut
	 * @date  2019年4月8日下午11:55:44
	 * @params
	 * @return @see com.ems.service.interf.RoleService#findRoleListById(long)
	 */
	@Override
	public List<EmsRole> findLowerRoleList(HttpSession session) {
		//获取当前登录用户
		EmsEmp employee = (EmsEmp) session.getAttribute("USERS_SESSION");
		//设置查询条件为角色等级小于当前登录用户角色等级
		EmsRoleQuery query = new EmsRoleQuery();
		Criteria criteria = query.createCriteria();
		criteria.andRoleIdGreaterThan(employee.getRoleId());
		//查询角色数据库
		List<EmsRole> list = emsRoleDao.selectByExample(query);
		return list;
	}

}
