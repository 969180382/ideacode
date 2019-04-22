package com.zyc.service;

import com.zyc.entity.RoomType;

import java.util.List;

public interface RoomTypeService {
    List<RoomType> findAll();
    RoomType findOne(String id);
}
