package com.zyc.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Id;
import javax.persistence.Transient;
import java.util.Date;
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Scheduled {
    @Id
    private String id;

    private String type;

    private String number;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date scheduledTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date checkinTime;

    private String scheduler;

    private String phone;

    private String idCard;

    private String sex;

    private String status;

    private String mode;

    private Double deposit;

    private Double price;
    @Transient
    private Room room;
    @Transient
    private RoomType roomType;

}