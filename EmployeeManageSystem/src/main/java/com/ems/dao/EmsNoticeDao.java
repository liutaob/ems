package com.ems.dao;

import com.ems.bean.EmsNotice;
import com.ems.bean.EmsNoticeQuery;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmsNoticeDao {
    int countByExample(EmsNoticeQuery example);

    int deleteByExample(EmsNoticeQuery example);

    int deleteByPrimaryKey(Long id);

    int insert(EmsNotice record);

    int insertSelective(EmsNotice record);

    List<EmsNotice> selectByExampleWithBLOBs(EmsNoticeQuery example);

    List<EmsNotice> selectByExample(EmsNoticeQuery example);

    EmsNotice selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") EmsNotice record, @Param("example") EmsNoticeQuery example);

    int updateByExampleWithBLOBs(@Param("record") EmsNotice record, @Param("example") EmsNoticeQuery example);

    int updateByExample(@Param("record") EmsNotice record, @Param("example") EmsNoticeQuery example);

    int updateByPrimaryKeySelective(EmsNotice record);

    int updateByPrimaryKeyWithBLOBs(EmsNotice record);

    int updateByPrimaryKey(EmsNotice record);
}