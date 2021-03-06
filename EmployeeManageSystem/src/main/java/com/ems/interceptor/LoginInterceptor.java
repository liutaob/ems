package com.ems.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.ems.bean.EmsEmp;

/**
 *  登录拦截  拦截器是单例的 线程不安全 可将用户信息存放ThreadLocal中 负载均衡需要session复制 或者直接改作cookie保存
 * @author liut
 * @date 2019年4月9日上午1:21:36
 */
public class LoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("即将进入处理器Controller--------------------》》》》》》》》》》》》》");
		System.out.println("拦截URI："+request.getRequestURI());
		System.out.println("拦截URL："+request.getRequestURL());
		/**
		 * 如果直接访问非登录页面 拦截判断是否登录过  登录过直接放行  刷新页面
		 */
		HttpSession session = request.getSession();
		EmsEmp employee = (EmsEmp) session.getAttribute("USERS_SESSION");
		if (employee != null) {
			UserThreadLocal.setUser(employee);
			//刷新session过期时间
			session.setMaxInactiveInterval(300);
			return true;
		}
		//跳转到登录页面
		response.sendRedirect("/");
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse response, Object arg2, ModelAndView arg3)
			throws Exception {
		//handler执行之后，modelAndView返回之前
		System.out.println("请求已经处理，即将返回视图--------------------》》》》》》》》》》》》》");
		//禁止缓存
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
	}

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// 在ModelAndView返回之后，异常处理
		EmsEmp user = UserThreadLocal.getUser();
		System.out.println("视图已返回--------------------》》》》》》》》》》》》》"+user.getUsername());
	}

}
