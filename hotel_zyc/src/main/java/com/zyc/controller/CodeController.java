package com.zyc.controller;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;

@Controller
@RequestMapping("code")
public class CodeController {

    @Autowired
    private DefaultKaptcha defaultKaptcha;

    @RequestMapping("showcode")
    @ResponseBody
    public void showCode(HttpServletResponse response, HttpSession session) throws IOException {
        String text = defaultKaptcha.createText();
        session.setAttribute("code",text);
        BufferedImage image = defaultKaptcha.createImage(text);
        ServletOutputStream outputStream = response.getOutputStream();
        ImageIO.write(image,"png",outputStream);
    }
}
