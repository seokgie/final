package com.gudi.main.dtoAll;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class ReserveDTO {
    private int reserveNum;
    private String contentId;
    private String id;
    private String manCount;
    private String carNum;
    private String phone;
    private String reserveDate;
    private String delCheck;
    private String reserveName;
}