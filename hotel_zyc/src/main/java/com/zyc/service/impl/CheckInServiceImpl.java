package com.zyc.service.impl;

import com.zyc.dao.CheckInMapper;
import com.zyc.entity.CheckIn;
import com.zyc.service.CheckInService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class CheckInServiceImpl implements CheckInService {
    @Resource
    private CheckInMapper checkInMapper;
    @Override
    public void add(CheckIn checkIn) {
        checkInMapper.insert(checkIn);
    }

    @Override
    public void add1(CheckIn checkIn) {
        checkInMapper.insert(checkIn);
    }
}
