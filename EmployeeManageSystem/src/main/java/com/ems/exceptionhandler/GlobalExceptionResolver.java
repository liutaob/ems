package com.ems.exceptionhandler;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/**
 * 全局处理异常
 * @author liut
 * @date 2019年3月3日下午8:36:59
 */
@ControllerAdvice
public class GlobalExceptionResolver{
	
	private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionResolver.class);
	
	@ExceptionHandler(value = Exception.class)
	public ModelAndView resolveException(Exception e) {
		logger.info("进入全局异常处理器。。");
		//控制台打印异常
		e.printStackTrace();
		//向日志文件中写入异常
		logger.error("系统发生异常",e);
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isNoneBlank(e.getMessage())) {
			mv.addObject("message",e.getMessage());
		}else {
			mv.addObject("message","服务器错误，请联系管理员");
		}
		mv.setViewName("/error/exception");
		//展示错误页面
		return mv;
	}

}
