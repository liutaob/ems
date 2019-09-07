package com.ems.dao;

import com.ems.bean.EmsMail;
import com.ems.bean.EmsMailQuery;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmsMailDao {
    int countByExample(EmsMailQuery example);

    int deleteByExample(EmsMailQuery example);

    int deleteByPrimaryKey(Long id);

    int insert(EmsMail record);

    int insertSelective(EmsMail record);

    List<EmsMail> selectByExampleWithBLOBs(EmsMailQuery example);

    List<EmsMail> selectByExample(EmsMailQuery example);

    EmsMail selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") EmsMail record, @Param("example") EmsMailQuery example);

    int updateByExampleWithBLOBs(@Param("record") EmsMail record, @Param("example") EmsMailQuery example);

    int updateByExample(@Param("record") EmsMail record, @Param("example") EmsMailQuery example);

    int updateByPrimaryKeySelective(EmsMail record);

    int updateByPrimaryKeyWithBLOBs(EmsMail record);

    int updateByPrimaryKey(EmsMail record);
}