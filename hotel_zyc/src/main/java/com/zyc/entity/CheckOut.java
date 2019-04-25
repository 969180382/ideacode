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
public class CheckOut {
    @Id
    private String id;

    private String status;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date checkoutTime;

    private String destineId;

    private String checkinId;

}