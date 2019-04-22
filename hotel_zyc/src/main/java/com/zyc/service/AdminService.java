package com.zyc.service;


import com.zyc.entity.Admin;

import java.util.Map;

public interface AdminService {
    Map<String,String> login(Admin admin);
}
