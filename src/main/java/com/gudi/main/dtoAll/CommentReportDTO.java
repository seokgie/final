package com.gudi.main.dtoAll;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class CommentReportDTO {
    private int cmReportNum;
    private int cmNum;
    private String reporter;
    private String id;
    private String dates;
    private String status;
    private String reason;
    private String content;
}
