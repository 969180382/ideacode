package com.zyc.controller;

import com.zyc.entity.Room;
import com.zyc.entity.RoomType;
import com.zyc.service.RoomService;
import com.zyc.service.RoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.Map;
import java.util.UUID;

@Controller
@RestController
@RequestMapping("room")
public class RoomController {
    @Autowired
    private RoomService roomService;
    @Autowired
    private RoomTypeService roomTypeService;
    //分页展示所有&&条件查询
    @RequestMapping("findAll")
    public Map<String,Object> findByPage(Integer page, Integer rows,String searchField,String searchString){
        String type = null;
        String number = null;
        String status = null;
        if("type".equals(searchField)){
            type=searchString;
        }else if("number".equals(searchField)){
            number=searchString;
        }else {
            status=searchString;
        }
        Map<String, Object> map = roomService.findByPage(page, rows,type,number,status);
        return map;
    }
    //房间添加
    @RequestMapping("addRoom")
    public void addRoom(Room room){
        RoomType r = roomTypeService.findOne(room.getRoomtypeId());
        String type = r.getType();
        room.setType(type);
        room.setId(UUID.randomUUID().toString());
        room.setStatus("空闲房");
        room.setUpdateTime(new Date());
        roomService.addRoom(room);
    }
    //查询房间详细信息
    @RequestMapping("findRoomAndType")
    public Room findRoomAndType(String id){
        Room room = roomService.findRoomAndType(id);
        return room;
    }
    //修改房间信息
    @RequestMapping("updateRoom")
    public void updateRoom(Room room){
        RoomType r = roomTypeService.findOne(room.getRoomtypeId());
        String type = r.getType();
        room.setType(type);
        roomService.update(room);
    }
    //删除房间
    @RequestMapping("delete")
    public void delete(String id){
        roomService.delete(id);
    }
}
