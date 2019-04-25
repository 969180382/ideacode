package com.zyc.dao;

import com.zyc.entity.Scheduled;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface ScheduledMapper extends Mapper<Scheduled> {
    List<Scheduled> search(@Param("type") String type ,
                           @Param("number") String number ,
                           @Param("name") String name ,
                           @Param("phone") String phone ,
                           @Param("idCard") String idCard,
                           @Param("mode") String mode,
                           @Param("status") String status);
}