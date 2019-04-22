package com.zyc.service.impl;

import com.zyc.dao.RoomTypeMapper;
import com.zyc.entity.RoomType;
import com.zyc.service.RoomTypeService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class RoomTypeServiceImpl implements RoomTypeService {
    @Resource
    private RoomTypeMapper roomTypeMapper;

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<RoomType> findAll() {
        List<RoomType> roomTypes = roomTypeMapper.selectAll();
        return roomTypes;
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public RoomType findOne(String id) {
        RoomType roomType1 = new RoomType();
        roomType1.setId(id);
        RoomType roomType = roomTypeMapper.selectOne(roomType1);
        return roomType;
    }
}
