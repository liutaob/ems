package com.ems.dao;

import com.ems.bean.EmsEmp;
import com.ems.bean.EmsEmpQuery;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmsEmpDao {
    int countByExample(EmsEmpQuery example);

    int deleteByExample(EmsEmpQuery example);

    int deleteByPrimaryKey(Long id);

    int insert(EmsEmp record);

    int insertSelective(EmsEmp record);

    List<EmsEmp> selectByExample(EmsEmpQuery example);

    EmsEmp selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") EmsEmp record, @Param("example") EmsEmpQuery example);

    int updateByExample(@Param("record") EmsEmp record, @Param("example") EmsEmpQuery example);

    int updateByPrimaryKeySelective(EmsEmp record);

    int updateByPrimaryKey(EmsEmp record);
}