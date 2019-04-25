package com.zyc.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Id;
import java.util.Date;
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class RoomType {
    @Id
    private String id;

    private String type;

    private Double priceDay;

    private Double priceHour;

    private Double deposit;

    private String installation;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;

    private String remark;

    private Integer count;

    private Integer remaining;

}