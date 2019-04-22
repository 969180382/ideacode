package com.zyc.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class RoomType {
    private String id;

    private String type;

    private Double priceDay;

    private Double priceHour;

    private Double deposit;

    private String installation;

    private Date updateTime;

    private String remark;

    private Integer count;

    private Integer remaining;

}