package com.gudi.main.dtoAll;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class MemberDTO {
    private String id;
    private String pw;
    private String nickName;
    private String email;
    private String admin;
    private String delCheck;
    private String reason;
    private String status;
}
