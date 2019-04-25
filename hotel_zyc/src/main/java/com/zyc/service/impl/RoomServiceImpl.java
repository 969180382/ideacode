package com.zyc.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyc.dao.RoomMapper;
import com.zyc.entity.Room;
import com.zyc.service.RoomService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class RoomServiceImpl implements RoomService {
    @Resource
    private RoomMapper roomMapper;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Map<String, Object> findByPage(Integer page, Integer rows,String type,String number,String status) {
        HashMap<String, Object> result = new HashMap<>();
        //开启分页插件
        PageHelper.startPage(page,rows);
        List<Room> rooms = roomMapper.search(type,number,status);
        PageInfo<Room> pageInfo=new PageInfo<>(rooms);
        result.put("page",page);
        long totals = pageInfo.getTotal();
        result.put("total",pageInfo.getPages());
        result.put("records",totals);
        result.put("rows",rooms);
        return result;
    }

    @Override
    public void addRoom(Room room) {
        roomMapper.insert(room);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Room findRoomAndType(String id) {
        Room room = roomMapper.selectRoomAndType(id);
        return room;
    }

    @Override
    public void update(Room room) {
        roomMapper.updateByPrimaryKeySelective(room);
    }

    @Override
    public void delete(String id) {
        roomMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Room findById(String id) {
        Room room = roomMapper.selectByPrimaryKey(id);
        return room;
    }
}
