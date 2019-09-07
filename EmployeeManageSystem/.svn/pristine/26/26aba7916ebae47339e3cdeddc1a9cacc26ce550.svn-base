package com.ems.dao;

import com.ems.bean.EmsJob;
import com.ems.bean.EmsJobQuery;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmsJobDao {
    int countByExample(EmsJobQuery example);

    int deleteByExample(EmsJobQuery example);

    int deleteByPrimaryKey(Long id);

    int insert(EmsJob record);

    int insertSelective(EmsJob record);

    List<EmsJob> selectByExample(EmsJobQuery example);

    EmsJob selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") EmsJob record, @Param("example") EmsJobQuery example);

    int updateByExample(@Param("record") EmsJob record, @Param("example") EmsJobQuery example);

    int updateByPrimaryKeySelective(EmsJob record);

    int updateByPrimaryKey(EmsJob record);
}