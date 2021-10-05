package com.gudi.main.dtoAll;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@ToString
@Setter
@Getter
public class CommentDTO {
    private int cmNum;
    private String id;
    private String division;
    private String content;
    private String dates;
    private String delCheck;
    private int divisionNum;
    private int boardNum;
    private String title;
    private String contentId;
    private String facltnm;
    private String nnmadr;
    private String prkplceNm;
    private int prkNum;
}
