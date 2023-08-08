package com.multi.hontrip.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

@Controller
public class UserController {

    public void home(Model model){
        model.addAttribute("title","테스트중");
        System.out.println("user");
    }
}
