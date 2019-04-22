package com.zyc;

import com.zyc.dao.RoomTypeMapper;
import com.zyc.entity.RoomType;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;

@RunWith(SpringRunner.class)
@SpringBootTest
public class HotelZycApplicationTests {
    @Resource
    private RoomTypeMapper roomTypeMapper;
    @Test
    public void contextLoads() {
        RoomType roomType1 = new RoomType();
        roomType1.setId("4");
        RoomType roomType = roomTypeMapper.selectOne(roomType1);
        System.out.println(roomType);
    }

}
