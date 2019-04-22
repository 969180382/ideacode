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
public class CheckOut {
    private String id;

    private String status;

    private Date checkoutTime;

    private String destineId;

    private String checkinId;

}