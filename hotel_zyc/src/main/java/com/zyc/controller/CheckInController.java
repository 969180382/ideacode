package com.zyc.controller;

import com.zyc.entity.Room;
import com.zyc.entity.CheckIn;
import com.zyc.entity.Scheduled;
import com.zyc.service.CheckInService;
import com.zyc.service.RoomService;
import com.zyc.service.CheckInService;
import com.zyc.service.ScheduledService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.SQLOutput;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@Controller
@RequestMapping("checkIn")
@RestController
public class CheckInController {
    @Autowired
    private CheckInService checkInService;
    @Autowired
    private RoomService roomService;
    @Autowired
    private ScheduledService scheduledService;
    //房间页面添加入住
    @RequestMapping("add")
    public void add(CheckIn checkIn){
        checkIn.setId(UUID.randomUUID().toString());
        checkIn.setCheckinTime(new Date());
        String[] strNow = new SimpleDateFormat("yyyy-MM-dd").format(new Date()).split("-");
        String year = strNow[0];
        String month =strNow[1];
        checkIn.setCheckinYear(year);
        checkIn.setCheckinMonth(month);
        checkIn.setUpdateTime(new Date());
        Room roomAndType = roomService.findRoomAndType(checkIn.getRoomId());
        if(checkIn.getPrice()==null){
            checkIn.setPrice(roomAndType.getRoomType().getPriceDay());
        }else {
            double v = checkIn.getPrice() * roomAndType.getRoomType().getPriceHour();
            checkIn.setPrice(v);
        }
        checkInService.add(checkIn);
        //修改房间状态
        Room room = new Room();
        room.setId(checkIn.getRoomId());
        room.setStatus("已入住");
        roomService.update(room);
    }
    //预定页面添加入住
    @RequestMapping("add1")
    public void add1(String id){
        //添加入住记录
        Scheduled scheduled = scheduledService.findOneById(id);
        CheckIn checkIn = new CheckIn();
        checkIn.setId(UUID.randomUUID().toString());
        checkIn.setName(scheduled.getScheduler());
        checkIn.setIdCard(scheduled.getIdCard());
        checkIn.setCheckinTime(new Date());
        String[] strNow = new SimpleDateFormat("yyyy-MM-dd").format(new Date()).split("-");
        String year = strNow[0];
        String month =strNow[1];
        checkIn.setCheckinYear(year);
        checkIn.setCheckinMonth(month);
        checkIn.setUpdateTime(new Date());
        checkIn.setSex(scheduled.getSex());
        checkIn.setMode(scheduled.getMode());
        checkIn.setPrice(scheduled.getPrice());
        checkIn.setPhone(scheduled.getPhone());
        checkIn.setRoomId(scheduled.getNumber());
        checkInService.add1(checkIn);
        //修改房间状态
        Room room = new Room();
        room.setId(scheduled.getNumber());
        room.setStatus("已入住");
        roomService.update(room);
        //修改预定状态
        scheduled.setStatus("已入住");
        scheduledService.update(scheduled);
    }
}
