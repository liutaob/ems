package com.ems.interceptor;

import com.ems.bean.EmsEmp;

/**
 * 	用户线程
 * @author liut
 * @date 2019年4月9日上午1:04:03
 */
public class UserThreadLocal {
	
	private static ThreadLocal<EmsEmp> local = new ThreadLocal<EmsEmp>();
	
	public static void setUser(EmsEmp user) {
		local.set(user);
	}
	
	public static EmsEmp getUser() {
		return local.get();
	}
}
