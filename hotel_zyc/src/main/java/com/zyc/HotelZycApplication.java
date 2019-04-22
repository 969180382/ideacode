package com.zyc;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import tk.mybatis.spring.annotation.MapperScan;

@SpringBootApplication
@MapperScan(basePackages = "com.zyc.dao")
public class HotelZycApplication {

    public static void main(String[] args) {
        SpringApplication.run(HotelZycApplication.class, args);
    }

}
