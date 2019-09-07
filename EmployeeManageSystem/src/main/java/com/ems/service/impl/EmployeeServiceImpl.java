package com.ems.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import com.ems.bean.EmsDept;
import com.ems.bean.EmsEmp;
import com.ems.bean.EmsEmpQuery;
import com.ems.bean.EmsEmpQuery.Criteria;
import com.ems.bean.EmsJob;
import com.ems.bean.EmsRole;
import com.ems.common.model.EmsResult;
import com.ems.common.util.EmailUtil;
import com.ems.dao.EmsDeptDao;
import com.ems.dao.EmsEmpDao;
import com.ems.dao.EmsJobDao;
import com.ems.dao.EmsRoleDao;
import com.ems.service.interf.DeptService;
import com.ems.service.interf.EmployeeService;
import com.ems.service.interf.JobService;
import com.ems.service.interf.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 	员工管理Service
 * @author liut
 * @date 2019年3月29日下午10:22:42
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	private static final Logger logger = LoggerFactory.getLogger(EmployeeServiceImpl.class);

	@Autowired
	private EmsEmpDao emsEmpDao;
	@Autowired
	private EmsDeptDao emsDeptDao;
	@Autowired
	private EmsJobDao emsJobDao;
	@Autowired
	private EmsRoleDao emsRoleDao;
	@Autowired
	private DeptService deptService;
	@Autowired
	private JobService jobService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private JavaMailSender javaMailSender;
//	@Autowired
//	private EmployeeDao employeeDao;
	
	
	/**
	 * 	添加新员工
	 * @autor liut
	 * @date  2019年3月29日下午10:22:42
	 * @params
	 * @return @see com.ems.service.interf.EmployeeService#register(com.ems.bean.EmsEmp)
	 * @throws xception 
	 */
	@Override
	public EmsResult register(EmsEmp employee,HttpServletRequest request) throws Exception{
		/**
		 * 校验新增员工
		 */
		String roleId = request.getParameter("roleId");
		String deptId = request.getParameter("deptId");
		if("0".equals(roleId)) {
			return EmsResult.build(500, "请选择角色等级");
		}
		if("0".equals(deptId)) {
			return EmsResult.build(500, "请选择部门");
		}
		EmsResult result = checkData(employee);
		System.out.println(employee.getUsername()+"校验通过******可以注册---");
		if(!(boolean) result.getData()) {
			//校验不通过 有重复异常 直接返回错误信息
			return result;
		}
		//手机号作为默认密码 MD5加密存储
		String password = DigestUtils.md5DigestAsHex(employee.getPhone().getBytes());
		/**
		 * 补全属性 插入数据库 返回结果
		 */
		employee.setPassword(password);
		employee.setCreated(new Date());
		employee.setUpdated(new Date());
		emsEmpDao.insert(employee);
		/**
		 * 给新入职员工发个邮件 提醒密码和修改密码
		 */
		//网页内容
		String text = "<p>"+employee.getUsername()+"，你好！<br>我是"+((EmsEmp)request.getSession().getAttribute("USERS_SESSION")).getUsername()+"欢迎加入阿里巴巴开发部门，期待你的到来！</p><br/>"
				+ "<p style=\"color: red;\">温馨提示：</p>"+"公司管理系统网址：(https://www.iliutao.com)"
				+"<a style=‘color: red;’ href='https://www.iliutao.com'>点击进入阿里巴巴管理系统</a><br/>"
				+"账号："+employee.getUsername()+"<br>密码：您的手机号"+employee.getPhone()+
				"<br><span style=‘color: red;’>请及时更改密码！<span><hr/>本邮件为系统自动发送";
		//linux下编译后图片路径/root/ems-tomcat/webapps/ROOT/WEB-INF/classes/images/mayun.jpg
		//windows下src/main/resources/images/mayun.jpg
		//docker	/usr/local/docker_tomcat/webapps/ROOT/WEB-INF/classes/images/mayun.jpg
		//	/usr/local/apache-tomcat-9.0.22/webapps/ROOT/WEB-INF/classes/images/mayun.jpg
		new Thread() {
			public void run() {
				try {
					EmailUtil.sendMail(javaMailSender, employee.getEmail(), employee.getUsername()+"欢迎加入阿里巴巴",
							text, true, "/usr/local/docker_tomcat/webapps/ROOT/WEB-INF/classes/images/mayun.jpg");
				} catch (Exception e) {
					e.printStackTrace();
					logger.error("入职邮件出异常了-》》》"+e.getMessage()+e.getStackTrace());
				}
			}
		}.start();
		System.out.println("入职邮件已经发送。");
		return EmsResult.ok();
	}
	
	/**
	 * 	用户登录 记得用一下cookie
	 * @autor liut
	 * @date  2019年3月30日上午12:32:13
	 * @params
	 * @return @see com.ems.service.interf.EmployeeService#login(com.ems.bean.EmsEmp)
	 */
	@Override
	public EmsResult login(String username,String password,String oauthcode,HttpSession session) {
		logger.info(new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss").format(new Date())+"======"+username+"正在尝试登录。。。");
		/**
		 * 用户名为条件查询员工
		 */
		EmsEmpQuery query = new EmsEmpQuery();
		Criteria criteria = query.createCriteria();
		criteria.andUsernameEqualTo(username);
		List<EmsEmp> list = emsEmpDao.selectByExample(query);
		if (list == null || list.size() == 0) {
			//返回登录失败
			return EmsResult.build(500, "用户名不正确");
		}
		EmsEmp employee = list.get(0);
		//密码要进行md5加密然后再校验
		if (!DigestUtils.md5DigestAsHex(password.getBytes()).equals(employee.getPassword())) {
			//记录输入的用户名
			session.setAttribute("lastLoginName", employee.getUsername());
			//返回登录失败
			return EmsResult.build(500, "密码错误");
		}
		String sessionCode = (String) session.getAttribute("code");
		//验证验证码
		if(!StringUtils.equalsIgnoreCase(sessionCode, oauthcode)) {
			//记录输入的用户名
			session.setAttribute("lastLoginName", employee.getUsername());
			return EmsResult.build(500, "验证码未通过");
		}
		logger.info(new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss").format(new Date())+"======"+username+"登录成功！");
		//存入session 展示个人信息包括部门、职位、角色
		session.setAttribute("USERS_SESSION", employee);
		EmsDept dept = emsDeptDao.selectByPrimaryKey(employee.getDeptId());
		session.setAttribute("DEPT_SESSION", dept);
		EmsJob job = emsJobDao.selectByPrimaryKey(employee.getJobId());
		session.setAttribute("JOB_SESSION", job);
		EmsRole role = emsRoleDao.selectByPrimaryKey(employee.getRoleId());
		session.setAttribute("ROLE_SESSION", role);
		//查出所有部门
		List<EmsDept> deptList = deptService.findAllDept();
		session.setAttribute("deptList", deptList);
		//查出所有职位
		List<EmsJob> jobList = jobService.findAllJob();
		session.setAttribute("jobList", jobList);
		//查出低于当前用户角色等级角色集合
		List<EmsRole> roleList = roleService.findLowerRoleList(session);
		session.setAttribute("roleList", roleList);
		//工资管理、新闻发布人	获取所有员工信息
		EmsEmpQuery query2 = new EmsEmpQuery();
		List<EmsEmp> empList = emsEmpDao.selectByExample(query2);
		session.setAttribute("empList", empList);
		//session过期时间30分钟
		session.setMaxInactiveInterval(1800);
		return EmsResult.ok();
	}

	/**
	 * 检查用户名、手机、邮箱是否重复
	 * @autor liut
	 * @date  2019年4月3日下午6:45:56
	 * @params
	 * @return EmsResult
	 */
	private EmsResult checkData(EmsEmp employee) {
		/**
		 * 设置用户名为查询条件
		 */
		EmsEmpQuery query = new EmsEmpQuery();
		Criteria criteria = query.createCriteria();
		criteria.andUsernameEqualTo(employee.getUsername());
		List<EmsEmp> list = emsEmpDao.selectByExample(query);
		if(list!=null && list.size() > 0) {
			//数据库中用户名已存在，返回false给出提示信息
			return EmsResult.build(500, "用户名已存在", false);
		}
		/**
		 * 设置邮箱为查询条件
		 */
		EmsEmpQuery query2 = new EmsEmpQuery();
		Criteria criteria2 = query2.createCriteria();
		criteria2.andEmailEqualTo(employee.getEmail());
		List<EmsEmp> list2 = emsEmpDao.selectByExample(query2);
		if(list2!=null && list2.size() > 0) 
			//数据库中邮箱已存在，返回false给出提示信息
			return EmsResult.build(500, "邮箱已存在", false);
		/**
		 * 设置手机号为查询条件
		 */
		EmsEmpQuery query3 = new EmsEmpQuery();
		Criteria criteria3 = query3.createCriteria();
		criteria3.andPhoneEqualTo(employee.getPhone());
		List<EmsEmp> list3 = emsEmpDao.selectByExample(query3);
		if(list3!=null && list3.size() > 0) 
			//数据库中手机号已存在，返回false给出提示信息
			return EmsResult.build(500, "手机号已存在", false);
		//校验通过
		return EmsResult.ok(true);
	}

	/**
	 * 修改密码 普通角色
	 * @autor liut
	 * @date  2019年4月3日下午7:58:03
	 * @params
	 * @return @see com.ems.service.interf.EmployeeService#updatePassword(java.lang.String, java.lang.String)
	 * @throws Exception 
	 */
	@Override
	public EmsResult updatePassword(String oldPassword, String newPassword, HttpSession session) throws Exception {
		//从session中获取当前登录员工信息 考虑使用redis+cookie
		EmsEmp employee = (EmsEmp) session.getAttribute("USERS_SESSION");
		if(employee == null) return EmsResult.build(500, "用户信息已过期，请重新登录");
		//校验原密码
		if(!StringUtils.equals(DigestUtils.md5DigestAsHex(oldPassword.getBytes()), employee.getPassword())) 
			return EmsResult.build(500, "密码错误，请重新输入");
		//MD5加密存储
		employee.setPassword(DigestUtils.md5DigestAsHex(newPassword.getBytes()));
		//更新员工密码
		emsEmpDao.updateByPrimaryKey(employee);
		//给该员工邮箱发个邮件通知
		//网页内容
		String text = "<p style=\"color: red;\">"+employee.getUsername()+"，你好！<br>您的密码修改成功：（"+newPassword+"）请确认是否是本人操作，若不是请及时联系管理员！</p><br/>"
				+ "<p>详情：</p>"+"公司管理系统网址：(https://www.iliutao.com)"
				+"<a style=‘color: red;’ href='https://www.iliutao.com'>点击进入阿里巴巴管理系统</a><br/>"
				+"<hr/>本邮件为系统自动发送";
		new Thread() {
			public void run() {
				try {
					EmailUtil.sendMail(javaMailSender, employee.getEmail(), employee.getUsername()+"修改密码成功", text, true, null);
				} catch (Exception e) {
					e.printStackTrace();
					logger.error("修改密码出异常了--》》》"+e.getMessage()+e.getStackTrace());
				}
			}
		}.start();
		System.out.println("密码修改邮件已经发送");
		return EmsResult.ok();
	}

	/**
	 * 重置密码 管理员专有 直接管理员才有按钮调用
	 * @autor liut
	 * @date  2019年4月3日下午7:58:03
	 * @params
	 * @return @see com.ems.service.interf.EmployeeService#resetPassword()
	 * @throws Exception 
	 */
	@Override
	public EmsResult resetPassword(String username,String password) throws Exception {
		/**
		 * 查找是否存在此员工
		 */
		EmsEmpQuery query = new EmsEmpQuery();
		Criteria criteria = query.createCriteria();
		criteria.andUsernameEqualTo(username);
		List<EmsEmp> list = emsEmpDao.selectByExample(query);
		if(list.size()==0||list==null) {
			return EmsResult.build(500, "不存在此员工");
		}
		/**
		 * 重置密码为新密码 MD5加密
		 */
		EmsEmp employee = list.get(0);
		employee.setPassword(DigestUtils.md5DigestAsHex(password.getBytes()));
		emsEmpDao.updateByPrimaryKey(employee);
		//给该员工邮箱发个邮件通知
		//网页内容
		String text = "<p style=\"color: red;\">"+employee.getUsername()+"你好！您的密码已重置，新密码为："+password+"<br>"
				+ "<p>详情：</p>"+"公司管理系统网址：（https://www.iliutao.com）"
				+"<a style=‘color: red;’ href='https://www.iliutao.com'>点击进入阿里巴巴管理系统</a><br/>"
				+"<hr/>本邮件为系统自动发送";
		new Thread() {
			public void run() {
				try {
					EmailUtil.sendMail(javaMailSender, employee.getEmail(), employee.getUsername()+"找回密码成功！", text, 
							true, null);
				} catch (Exception e) {
					e.printStackTrace();
					logger.error("找回密码出异常了-》》》"+e.getMessage()+e.getStackTrace());
				}
			}
		}.start();
		System.out.println("密码重置邮件已经发送");
		return EmsResult.ok();
	}

	/**
	 *  分页展示员工信息
	 * @autor liut
	 * @date  2019年4月6日下午8:33:47
	 * @params
	 * @return @see com.ems.service.interf.EmployeeService#findAllEmployee(int, int)
	 */
	@Override
	public PageInfo<EmsEmp> findAllEmployee(int curpage, int row) {
		//设置分页参数
		PageHelper.startPage(curpage, row);
		//利用扩展的员工类将职位、部门查出	暂时先作废 ${employee.deptName}参考淘淘 或者考虑类关系
//		List<Employee> list = employeeDao.findAllEmployee();
//		PageInfo<Employee> pageInfo = new PageInfo<Employee>(list);
		//先采用这种方式
		//查出所有员工	内存分页
		EmsEmpQuery query = new EmsEmpQuery();
		List<EmsEmp> list = emsEmpDao.selectByExample(query);
		return new PageInfo<EmsEmp>(list);
	}

	/**
	 * 	批量删除员工	换post方法不管用？
	 * @autor liut
	 * @date  2019年4月6日下午11:41:57
	 * @params
	 * @return @see com.ems.service.interf.EmployeeService#deleteEmployee(java.util.List)
	 */
	@Override
	public void deleteEmployee(List<Long> ids) {
		//设置id的范围为查询条件
		EmsEmpQuery query = new EmsEmpQuery();
		Criteria criteria = query.createCriteria();
		criteria.andIdIn(ids);
		//删除员工
		emsEmpDao.deleteByExample(query);
	}

	/**
	 * 	条件查询员工
	 * @autor liut
	 * @date  2019年4月7日上午2:21:12
	 * @params
	 * @return @see com.ems.service.interf.EmployeeService#findEmployeesByCon(int, int, javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public PageInfo<EmsEmp> findEmployeesByCon(int curpage, int row, HttpServletRequest request) {
		//获取查询参数	为null替换为""
		String username = request.getParameter("username");
		if(StringUtils.isEmpty(username)) username="";
		String gender = request.getParameter("gender");
		String deptId = request.getParameter("empDept");
		String jobId = request.getParameter("empJob");
		/**
		 * 创建查询条件
		 */
		EmsEmpQuery query = new EmsEmpQuery();
		Criteria criteria = query.createCriteria();
		criteria.andUsernameLike("%"+username+"%");
		if(!"0".equals(gender)) {
			criteria.andGenderEqualTo(gender);
		}
		if(!"0".equals(deptId)) {
			criteria.andDeptIdEqualTo(Long.parseLong(deptId));
		}
		if(!"0".equals(jobId)) {
			criteria.andJobIdEqualTo(Long.parseLong(jobId));
		}
		//设置分页参数
		PageHelper.startPage(curpage, row);
		//模糊查询
		List<EmsEmp> list = emsEmpDao.selectByExample(query);
		return new PageInfo<EmsEmp>(list);
	}

	/**
	 * 	根据员工id查询员工信息 用扩展员工类把部门和职位也查出来?暂时不用扩展类或类关系
	 * @autor liut
	 * @date  2019年4月7日下午12:05:24
	 * @params
	 * @return @see com.ems.service.interf.EmployeeService#findEmployeeByIdWithDeptAndJob(long)
	 */
	@Override
	public EmsEmp findEmployeeByIdWithDeptAndJob(long employeeId) {
		//根据员工id查出员工
		EmsEmp emp = emsEmpDao.selectByPrimaryKey(employeeId);
		return emp;
	}

	/**
	 * 修改员工信息
	 * @autor liut
	 * @date  2019年4月8日上午1:17:27
	 * @params
	 * @return @see com.ems.service.interf.EmployeeService#updateEmployee(long)
	 */
	@Override
	public EmsResult updateEmployee(EmsEmp employee, HttpSession session) {
		//获取要更改的员工
		EmsEmp oldEmployee = (EmsEmp) session.getAttribute("employee");
		//校验更改后用户名是否已存在
		if(!StringUtils.equals(oldEmployee.getUsername(), employee.getUsername())) {
			EmsEmpQuery query = new EmsEmpQuery();
			Criteria criteria = query.createCriteria();
			criteria.andUsernameEqualTo(employee.getUsername());
			List<EmsEmp> list = emsEmpDao.selectByExample(query);
			if(list!=null && list.size() > 0) 
				//数据库中用户名已存在
				return EmsResult.build(500, "用户名已存在");
		}
		//校验更改后手机号是否已存在
		if(!StringUtils.equals(oldEmployee.getPhone(), employee.getPhone())) {
			EmsEmpQuery query2 = new EmsEmpQuery();
			Criteria criteria2 = query2.createCriteria();
			criteria2.andPhoneEqualTo(employee.getPhone());
			List<EmsEmp> list2 = emsEmpDao.selectByExample(query2);
			if(list2!=null && list2.size() > 0) 
				//数据库中手机号已存在
				return EmsResult.build(500, "手机号已存在");
		}
		//校验更改后邮箱号是否已存在
		if(!StringUtils.equals(oldEmployee.getEmail(), employee.getEmail())) {
			EmsEmpQuery query3 = new EmsEmpQuery();
			Criteria criteria3 = query3.createCriteria();
			criteria3.andEmailEqualTo(employee.getEmail());
			List<EmsEmp> list3 = emsEmpDao.selectByExample(query3);
			if(list3!=null && list3.size() > 0) 
				//数据库中邮箱号已存在
				return EmsResult.build(500, "邮箱号已存在");
		}
		//更新员工信息
		employee.setCreated(oldEmployee.getCreated());
		employee.setPassword(oldEmployee.getPassword());
		employee.setRoleId(employee.getRoleId());
		employee.setUpdated(new Date());
		emsEmpDao.updateByPrimaryKey(employee);
		//更新全部员工信息
		EmsEmpQuery query = new EmsEmpQuery();
		List<EmsEmp> empList = emsEmpDao.selectByExample(query);
		session.setAttribute("empList", empList);
		return EmsResult.ok();
	}

}
