package com.ems.dao;

import com.ems.bean.EmsDept;
import com.ems.bean.EmsDeptQuery;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmsDeptDao {
    int countByExample(EmsDeptQuery example);

    int deleteByExample(EmsDeptQuery example);

    int deleteByPrimaryKey(Long id);

    int insert(EmsDept record);

    int insertSelective(EmsDept record);

    List<EmsDept> selectByExample(EmsDeptQuery example);

    EmsDept selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") EmsDept record, @Param("example") EmsDeptQuery example);

    int updateByExample(@Param("record") EmsDept record, @Param("example") EmsDeptQuery example);

    int updateByPrimaryKeySelective(EmsDept record);

    int updateByPrimaryKey(EmsDept record);
}