package com.gudi.main.dtoAll;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class PhotoDTO {
    private int photoNum;
    private String id;
    private String division;
    private String newFileName;
    private String oriFileName;
    private String date;
    private String divisionNum;
}
