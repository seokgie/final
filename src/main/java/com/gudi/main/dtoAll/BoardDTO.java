package com.gudi.main.dtoAll;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class BoardDTO {
    private int boardNum;
    private String id;
    private String content;
    private String title;
    private String dates;
    private String boardHit;
    private String delCheck;
    private int division;

}
