package com.ems.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ems.bean.EmsEmp;
import com.ems.bean.EmsEmpQuery;
import com.ems.bean.EmsEmpQuery.Criteria;
import com.ems.bean.EmsSalary;
import com.ems.bean.EmsSalaryQuery;
import com.ems.common.jedis.JedisClient;
import com.ems.common.model.EmsResult;
import com.ems.dao.EmsEmpDao;
import com.ems.dao.EmsSalaryDao;
import com.ems.service.interf.SalaryService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 	工资管理Service
 * @author liut
 * @date 2019年4月11日下午9:53:47
 */
@Service
public class SalaryServiceImpl implements SalaryService{
	
	@Autowired
	private EmsSalaryDao emsSalaryDao;
	@Autowired
	private EmsEmpDao emsEmpDao;
	@Autowired
	private JedisClient jedisClient;
	@Value("${SALARY_ID_GEN_KEY}")
	private String SALARY_ID_GEN_KEY;
	@Value("${SALARY_ID_BEGIN_VALUE}")
	private String SALARY_ID_BEGIN_VALUE;
	
	/**
	 * 	验证是否存在此员工
	 * @autor liut
	 * @date  2019年4月11日下午10:53:40
	 * @params
	 * @return @see com.ems.service.interf.SalaryService#yzIsExitEmployee(org.springframework.http.HttpRequest)
	 */
	@Override
	public EmsResult yzIsExitEmployee(HttpServletRequest request) {
		//获取页面传递参数
		String empName = request.getParameter("empId");
		//根据输入的员工名验证员工是否存在
		EmsEmpQuery query = new EmsEmpQuery();
		Criteria criteria = query.createCriteria();
		criteria.andUsernameEqualTo(empName);
		List<EmsEmp> list = emsEmpDao.selectByExample(query);
		if(list.size() > 0 && list != null) {
			//存在则将员工Id响应回页面
			EmsEmp emp = list.get(0);
			return EmsResult.ok(emp);
		}
		//不存在
		return EmsResult.build(500, "查无此人");
	}

	/**
	 * 	新增工资单号
	 * @autor liut
	 * @date  2019年4月11日下午11:25:46
	 * @params
	 * @return @see com.ems.service.interf.SalaryService#addSalary(com.ems.bean.EmsSalary)
	 */
	@Override
	public EmsResult addSalary(EmsSalary salary) {
		//生成工资单号,使用redis的incr生成
		if (!jedisClient.exists(SALARY_ID_GEN_KEY)) {
			//设置初始值
			jedisClient.set(SALARY_ID_GEN_KEY, SALARY_ID_BEGIN_VALUE);
		}
		String salaryIdStr = jedisClient.incr(SALARY_ID_GEN_KEY).toString();
		Long salaryId = Long.parseLong(salaryIdStr);
		/**
		 * 补全属性并插入数据库
		 */
		salary.setId(salaryId);
		salary.setCreated(new Date());
		salary.setUpdated(new Date());
		emsSalaryDao.insert(salary);
		return EmsResult.ok();
	}

	/**
	 * 	分页查询工资发放记录
	 * @autor liut
	 * @date  2019年4月12日上午12:04:32
	 * @params
	 * @return @see com.ems.service.interf.SalaryService#showSalary(int, int)
	 */
	@Override
	public PageInfo<EmsSalary> showSalary(int curpage, int row) {
		PageHelper.startPage(curpage, row);
		EmsSalaryQuery query = new EmsSalaryQuery();
		List<EmsSalary> list = emsSalaryDao.selectByExample(query);
		return new PageInfo<EmsSalary>(list);
	}

	/**
	 * @autor liut
	 * @date  2019年4月12日上午12:04:32
	 * @params
	 * @return @see com.ems.service.interf.SalaryService#showSalaryByCon(com.ems.bean.EmsSalary, int, int)
	 */
	@Override
	public PageInfo<EmsSalary> showSalaryByCon(HttpServletRequest request, int curpage, int row) {
		//获取查询条件
		String empName = request.getParameter("empName");
		String status = request.getParameter("status");
		EmsEmpQuery query = new EmsEmpQuery();
		Criteria criteria = query.createCriteria();
		criteria.andUsernameLike("%"+empName+"%");
		List<EmsEmp> empList = emsEmpDao.selectByExample(query);
		List<Long> empIdList = new ArrayList<>();
		for (EmsEmp emsEmp : empList) {
			empIdList.add(emsEmp.getId());
		}
		//设置分页参数
		PageHelper.startPage(curpage, row);
		EmsSalaryQuery query2 = new EmsSalaryQuery();
		com.ems.bean.EmsSalaryQuery.Criteria criteria2 = query2.createCriteria();
		criteria2.andEmpIdIn(empIdList);
		if(!"0".equals(status)) {
			criteria2.andStatusEqualTo(Integer.parseInt(status));
		}
		//模糊查询
		List<EmsSalary> list = emsSalaryDao.selectByExample(query2);
		return new PageInfo<EmsSalary>(list);
	}

	/**
	 * 	删除工资记录
	 * @autor liut
	 * @date  2019年4月12日上午1:34:34
	 * @params
	 * @return @see com.ems.service.interf.SalaryService#deleteSalary(java.util.List)
	 */
	@Override
	public void deleteSalary(List<Long> ids) {
		//设置id的范围为查询条件
		EmsSalaryQuery query = new EmsSalaryQuery();
		com.ems.bean.EmsSalaryQuery.Criteria criteria = query.createCriteria();
		criteria.andIdIn(ids);
		//删除数据库
		emsSalaryDao.deleteByExample(query);
	}

	/**
	 * 	修改工资状态
	 * @autor liut
	 * @date  2019年4月12日上午1:39:01
	 * @params
	 * @return @see com.ems.service.interf.SalaryService#updateSalary(java.util.List)
	 */
	@Override
	public void updateSalary(List<Long> ids) {
		for (Long id : ids) {
			EmsSalary salary = emsSalaryDao.selectByPrimaryKey(id);
			if(salary.getStatus()==2) {
				//更新数据库
				salary.setUpdated(new Date());
				salary.setStatus(1);
				emsSalaryDao.updateByPrimaryKey(salary);
			}
		}
	}

}
