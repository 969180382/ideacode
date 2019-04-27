package com.zyc.dao;

import com.zyc.entity.CheckIn;

import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;


public interface CheckInMapper extends Mapper<CheckIn> {
    List<CheckIn> search(@Param("name") String name , @Param("idCard") String idCard, @Param("phone") String phone);
}