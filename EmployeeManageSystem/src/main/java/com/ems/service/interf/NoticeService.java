package com.ems.service.interf;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.ems.bean.EmsNotice;
import com.github.pagehelper.PageInfo;

/**
 * @author liut
 * @date 2019年4月12日下午2:29:10
 */
public interface NoticeService {
	
	void addNotice(EmsNotice notice,HttpSession session);
	
	PageInfo<EmsNotice> showNotice(int curpage, int row,HttpSession session);
	
	PageInfo<EmsNotice> showNoticeByCon(EmsNotice notice,int curpage,int row,HttpSession session);
	
	void deleteNotice(List<Long> ids);
	
	EmsNotice findNoticeById(Long id);
}
