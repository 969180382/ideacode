package com.zyc.controller;

import com.zyc.entity.Room;
import com.zyc.entity.Scheduled;
import com.zyc.service.RoomService;
import com.zyc.service.ScheduledService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("scheduled")
@RestController
public class ScheduledController {
    @Autowired
    private ScheduledService scheduledService;
    @Autowired
    private RoomService roomService;
    @RequestMapping("add")
    public void add(Scheduled scheduled){
        scheduled.setId(UUID.randomUUID().toString());
        scheduled.setScheduledTime(new Date());
        scheduled.setStatus("预定成功");
        Room roomAndType = roomService.findRoomAndType(scheduled.getNumber());
        if(scheduled.getPrice()==null){
            scheduled.setPrice(roomAndType.getRoomType().getPriceDay());
        }else {
            double v = scheduled.getPrice() * roomAndType.getRoomType().getPriceHour();
            scheduled.setPrice(v);
        }
        scheduledService.add(scheduled);
        //修改房间状态
        Room room = new Room();
        room.setId(scheduled.getNumber());
        room.setStatus("已预定");
        roomService.update(room);
    }
    @RequestMapping("findAll")
    public Map<String,Object> findAll(Integer page, Integer rows,String searchField,String searchString){
        String type = null;
        String number = null;
        String name = null;
        String phone = null;
        String idCard = null;
        String mode = null;
        String status = null;
        if("roomType.type".equals(searchField)){
            type=searchString;
        }else if("room.number".equals(searchField)){
            number=searchString;
        }else if("scheduler".equals(searchField)){
            name=searchString;
        } else if("phone".equals(searchField)){
            phone=searchString;
        } else if("idCard".equals(searchField)){
            idCard=searchString;
        } else if("status".equals(searchField)){
            status=searchString;
        } else{
            mode=searchString;
        }
        Map<String, Object> map = scheduledService.search(page, rows,type,number,name,phone,idCard,mode,status);
        return map;
    }
    @RequestMapping("cancel")
    public void cancel(String id){
        //修改预定状态
        Scheduled scheduled = scheduledService.findOneById(id);
        scheduled.setStatus("已取消");
        scheduledService.update(scheduled);
        //修改房间状态
        Room room = roomService.findById(scheduled.getNumber());
        room.setStatus("空闲房");
        roomService.update(room);
    }
}
