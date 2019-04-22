package com.zyc.service.impl;

import com.zyc.dao.AdminMapper;
import com.zyc.entity.Admin;
import com.zyc.service.AdminService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {
    @Resource
    private AdminMapper adminMapper;
    @Resource
    private HttpSession session;
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Map<String,String> login(Admin admin) {
        Admin admin1 = adminMapper.selectOne(admin);
        Map<String,String> map = new HashMap<>();
        if(admin1==null){
            map.put("code","500");
        }else{
            map.put("code","200");
            session.setAttribute("admin",admin1);
        }
        return map;
    }
}
