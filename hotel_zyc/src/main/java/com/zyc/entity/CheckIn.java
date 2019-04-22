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
public class CheckIn {
    private String id;

    private String name;

    private String idCard;

    private Date checkinTime;

    private String checkinYear;

    private String checkinMonth;

    private Date updateTime;

    private String remark;

}