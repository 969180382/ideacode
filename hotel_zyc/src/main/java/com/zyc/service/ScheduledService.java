package com.zyc.service;

import com.zyc.entity.Scheduled;

import java.util.Map;

public interface ScheduledService {
    void add(Scheduled scheduled);

    Map<String,Object> search(Integer page,Integer rows,String type, String number, String name, String phone, String idCard, String mode,String status);

    Scheduled findOneById(String id);

    void update(Scheduled scheduled);
    void delete(String id);
}
