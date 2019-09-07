package com.ems.dao;

import com.ems.bean.EmsRole;
import com.ems.bean.EmsRoleQuery;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmsRoleDao {
    int countByExample(EmsRoleQuery example);

    int deleteByExample(EmsRoleQuery example);

    int deleteByPrimaryKey(Long roleId);

    int insert(EmsRole record);

    int insertSelective(EmsRole record);

    List<EmsRole> selectByExample(EmsRoleQuery example);

    EmsRole selectByPrimaryKey(Long roleId);

    int updateByExampleSelective(@Param("record") EmsRole record, @Param("example") EmsRoleQuery example);

    int updateByExample(@Param("record") EmsRole record, @Param("example") EmsRoleQuery example);

    int updateByPrimaryKeySelective(EmsRole record);

    int updateByPrimaryKey(EmsRole record);
}