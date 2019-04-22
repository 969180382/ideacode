package com.zyc.dao;

import com.zyc.entity.Room;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;


public interface RoomMapper extends Mapper<Room> {

    List<Room> search(@Param("type") String type ,@Param("number") String number,@Param("status") String status);
}