package com.zyc.service;

import com.zyc.entity.Room;

import java.util.Map;

public interface RoomService {
    Map<String,Object> findByPage(Integer page, Integer rows,String type,String number,String status);
    void addRoom(Room room);
    Room findRoomAndType(String id);
    void update(Room room);
    void delete(String id);
    Room findById(String id);
}
