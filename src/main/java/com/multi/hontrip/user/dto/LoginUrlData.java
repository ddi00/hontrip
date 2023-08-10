package com.multi.hontrip.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class LoginUrlData {
    private String provider;
    private String loginHref;
    private String imgSrc;
}
