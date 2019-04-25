package com.zyc.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Id;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Admin {
    @Id
    private String id;

    private String username;

    private String password;

}