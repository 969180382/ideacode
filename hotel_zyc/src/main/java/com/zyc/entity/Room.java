package com.zyc.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Id;
import javax.persistence.Transient;
import java.util.Date;
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Room {
    @Id
    private String id;

    private String type;

    private String number;

    private String floor;

    private String status;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;

    private String remark;

    private String roomtypeId;
    @Transient
    private RoomType roomType;

}