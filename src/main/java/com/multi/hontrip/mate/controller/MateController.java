package com.multi.hontrip.mate.controller;

import com.multi.hontrip.mate.dto.LocationDTO;
import com.multi.hontrip.mate.dto.MateBoardInsertDTO;
import com.multi.hontrip.mate.dto.MateBoardListDTO;
import com.multi.hontrip.mate.dto.PageDTO;
import com.multi.hontrip.mate.service.MateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("mate")
public class MateController {

    @Autowired
    private MateService mateService;


    /* 동행인게시판 글 작성 get, post 매핑*/
    @GetMapping("insert")
    public String insert() {
        return "mate/mate_board_insert";
    }

    @RequestMapping("bbs_list")
    public void list(PageDTO pageDTO, Model model) {
        //start, end지점 구하기
        pageDTO.setStartEnd(pageDTO.getPage());
        //게시물 리스트 가져오기
        List<MateBoardListDTO> list = mateService.list(pageDTO);
        //게시물 개수 가져오기
        int count = mateService.count();
        System.out.println("all count >> " + count);
        //페이지 수 게산
        //1page당 5개의 게시물을 넣는 경우
        int pages = mateService.pages(count);
        model.addAttribute("list", list);
        model.addAttribute("count", count);
        model.addAttribute("pages", pages);

        //지역 리스트 가져오기
        List<LocationDTO> location = mateService.location();
        model.addAttribute("location", location);
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


    /* 동행인 상세 게시글  get, post 매핑*/
    @GetMapping("{id}")
    public String selectOne(@PathVariable("id") int id, Model model) {
        MateBoardInsertDTO mateBoardInsertDTO = mateService.selectOne(id);
        model.addAttribute("dto", mateBoardInsertDTO);
        return "mate/mate_board_selectOne";
    }


//    @RequestMapping("bbs_one")
//    public void one(int id, Model model) {
//        BbsDTO dto = bbsDAO.one(id);
//        List<ReplyDTO> list = replyDAO.list(id);
//        model.addAttribute("dto", dto);
//        model.addAttribute("list", list);
}
