package com.multi.hontrip.mate.controller;

import com.multi.hontrip.mate.dto.MateBoardInsertDTO;
import com.multi.hontrip.mate.service.MateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

@Controller
@RequestMapping("mate")
public class MateController {

    @Autowired
    private MateService mateService;


    /* 동행인게시판 글 작성 get,post 매핑*/
    @GetMapping("insert")
    public String insert() {
        return "mate/mate_board_insert";
    }

    @PostMapping("insert")
    public String insert(@RequestParam("file") MultipartFile file,
                         MateBoardInsertDTO mateBoardInsertDTO,
                         HttpServletRequest request
    ) throws IOException {
        String savedFileName = file.getOriginalFilename();
        mateBoardInsertDTO.setThumbnail(savedFileName);
        String uploadPath = "D:\\hontrip\\src\\main\\webapp\\resources\\upload";
        File target = new File(uploadPath + "/" + savedFileName);
        file.transferTo(target);
        mateService.insert(mateBoardInsertDTO);
        return "redirect:../home.jsp";
    }

}
