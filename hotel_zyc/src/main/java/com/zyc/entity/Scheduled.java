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
public class Scheduled {
    private String id;

    private String type;

    private String number;

    private Date scheduledTime;

    private Date checkinTime;

    private String scheduler;

    private String phone;

    private String idCard;

    private String sex;

    private String status;

    private String mode;

    private Double deposit;

    private Double price;

}