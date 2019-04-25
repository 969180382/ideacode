package com.zyc;

import com.zyc.dao.CheckInMapper;
import com.zyc.dao.RoomTypeMapper;
import com.zyc.dao.ScheduledMapper;
import com.zyc.entity.CheckIn;
import com.zyc.entity.RoomType;
import com.zyc.entity.Scheduled;
import com.zyc.service.ScheduledService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class HotelZycApplicationTests {
    @Resource
    private RoomTypeMapper roomTypeMapper;
    @Resource
    private CheckInMapper checkInMapper;
    @Resource
    private ScheduledMapper scheduledMapper;
    @Autowired
    private ScheduledService scheduledService;
    @Test
    public void contextLoads() {
        /*RoomType roomType1 = new RoomType();
        roomType1.setId("4");
        RoomType roomType = roomTypeMapper.selectOne(roomType1);
        System.out.println(roomType);*/
        /*CheckIn checkIn = new CheckIn();
        checkIn.setId("1");
        checkIn.setMode("333");
        checkInMapper.insert(checkIn);*/
        /*List<Scheduled> search = scheduledMapper.search("", "", "小灰灰", "", "", "","");
        System.out.println(search);*/
        Scheduled scheduled = scheduledService.findOneById("2a217dff-5f3e-41e1-811c-5726b09a6a2a");
        System.out.println(scheduled);
    }

}
