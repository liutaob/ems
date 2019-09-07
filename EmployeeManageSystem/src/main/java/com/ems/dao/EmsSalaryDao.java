package com.ems.dao;

import com.ems.bean.EmsSalary;
import com.ems.bean.EmsSalaryQuery;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmsSalaryDao {
    int countByExample(EmsSalaryQuery example);

    int deleteByExample(EmsSalaryQuery example);

    int deleteByPrimaryKey(Long id);

    int insert(EmsSalary record);

    int insertSelective(EmsSalary record);

    List<EmsSalary> selectByExample(EmsSalaryQuery example);

    EmsSalary selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") EmsSalary record, @Param("example") EmsSalaryQuery example);

    int updateByExample(@Param("record") EmsSalary record, @Param("example") EmsSalaryQuery example);

    int updateByPrimaryKeySelective(EmsSalary record);

    int updateByPrimaryKey(EmsSalary record);
}