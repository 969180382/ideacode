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
public class Income {
    private String id;

    private String remark;

    private String idCard;

    private String name;

    private Double price;

    private Date consumptionTime;

    private String consumptionYear;

    private String consumptionMonth;

}