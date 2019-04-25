package com.zyc.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyc.dao.ScheduledMapper;
import com.zyc.entity.Scheduled;
import com.zyc.service.ScheduledService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class ScheduledServiceImpl implements ScheduledService {
    @Resource
    private ScheduledMapper scheduledMapper;
    @Override
    public void add(Scheduled scheduled) {
        scheduledMapper.insert(scheduled);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Map<String,Object> search(Integer page, Integer rows, String type, String number, String name, String phone, String idCard, String mode,String status) {
        HashMap<String, Object> result = new HashMap<>();
        //开启分页插件
        PageHelper.startPage(page,rows);
        List<Scheduled> scheduleds = scheduledMapper.search(type,number,name,phone,idCard,mode,status);
        PageInfo<Scheduled> pageInfo=new PageInfo<>(scheduleds);
        result.put("page",page);
        long totals = pageInfo.getTotal();
        result.put("total",pageInfo.getPages());
        result.put("records",totals);
        result.put("rows",scheduleds);
        return result;
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Scheduled findOneById(String id) {
        Scheduled scheduled = scheduledMapper.selectByPrimaryKey(id);
        return scheduled;
    }

    @Override
    public void update(Scheduled scheduled) {
        scheduledMapper.updateByPrimaryKeySelective(scheduled);
    }
}
