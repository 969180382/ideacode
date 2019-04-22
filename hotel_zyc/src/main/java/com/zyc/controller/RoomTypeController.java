package com.zyc.controller;

import com.zyc.entity.RoomType;
import com.zyc.service.RoomService;
import com.zyc.service.RoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Controller
@RequestMapping("roomType")
@RestController
public class RoomTypeController {
    @Autowired
    private RoomTypeService roomTypeService;
    @RequestMapping("findAll")
    public List<RoomType> findAll(){
        List<RoomType> all = roomTypeService.findAll();
        return all;
    }
}
