package com.multi.hontrip.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {

    @GetMapping("/hello")
    public String home(Model model){
        model.addAttribute("title","테스트중");
        return "";
    }
}
