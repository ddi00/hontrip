package com.multi.hontrip.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("user")
public class UserController {
    public void home(){
        System.out.println("userHome");
    }
}
