package com.zyc.controller;

import com.zyc.entity.Admin;
import com.zyc.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Autowired
    private AdminService adminService;
    @RequestMapping("checkCode")
    @ResponseBody
    public String checkCode(HttpSession session,String code){
        String code1 = (String) session.getAttribute("code");
        if(code.equals(code1)){
            return "true";
        }else{
            return "false";
        }
    }
    @RequestMapping("login")
    @ResponseBody
    public Map<String,String> login(Admin admin){
        admin.setId("1");
        Map<String, String> login = adminService.login(admin);
        return login;
    }
    @RequestMapping("safeOut")
    public String safeOut(HttpSession session){
        session.removeAttribute("admin");
        return "redirect:/login.jsp";
    }
}
