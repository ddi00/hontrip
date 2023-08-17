package com.multi.hontrip.mate.controller;

import com.multi.hontrip.mate.dto.LocationDTO;
import com.multi.hontrip.mate.dto.MateBoardInsertDTO;
import com.multi.hontrip.mate.dto.MateBoardListDTO;
import com.multi.hontrip.mate.dto.PageDTO;
import com.multi.hontrip.mate.dto.*;
import com.multi.hontrip.mate.service.MateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    @RequestMapping(value = {"bbs_list"})
    public void list(PageDTO pageDTO, Model model, HttpSession session) {
        //페이징 변수들 계산하기
        PageDTO pagedDTO = mateService.paging(pageDTO);
        //게시물 리스트 가져오기
        List<MateBoardListDTO> list = mateService.list(pagedDTO);
        //지역 리스트 가져오기
        List<LocationDTO> location = mateService.location();

        session.setAttribute("user_id", 1L);
        session.setAttribute("nickname", "Alice");
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


        model.addAttribute("list", list);

        model.addAttribute("pageDTO", pagedDTO);
    }

    @RequestMapping("pagination")
    public @ResponseBody Map<String,Object> pageList(PageDTO pageDTO, Model model, HttpSession session) {
        //페이징 변수들 계산하기
        PageDTO pagedDTO = mateService.paging(pageDTO);
        //게시물 리스트 가져오기
        List<MateBoardListDTO> list = mateService.list(pagedDTO);

        model.addAttribute("list", list);
        session.setAttribute("pageDTO", pagedDTO);
        System.out.println(pagedDTO.getRealEnd());

        Map<String,Object> map=new HashMap<>();
        map.put("list", list);
        map.put("pageDTO", pagedDTO);
        return map;
    }
        @RequestMapping("bbs_one")
    public void one(long mateBoardId, Model model) {
        //게시물 상세 가져오기
        MateBoardListDTO mateBoardListDTO = mateService.one(mateBoardId);
        //게시물 상세의 댓글 리스트 가져오기
        List<MateCommentDTO> list = mateService.commentList(mateBoardId);
        model.addAttribute("one", mateBoardListDTO);
        model.addAttribute("list", list);
    }


    /* 동행인 상세 게시글  get, post 매핑*/
    @GetMapping("{id}")
    public String selectOne(@PathVariable("id") int id, Model model) {
        MateBoardInsertDTO mateBoardInsertDTO = mateService.selectOne(id);
        model.addAttribute("dto", mateBoardInsertDTO);
        return "mate/mate_board_selectOne";
    }


    @RequestMapping("comment_insert")
    @ResponseBody
    public Map<String,Object> insert(MateCommentDTO mateCommentDTO, Model model) {
        int result = mateService.commentInsert(mateCommentDTO);
        List<MateCommentDTO> list = mateService.commentList(mateCommentDTO.getMateBoardId());
        Map<String,Object> map=new HashMap<>();
        map.put("list", list);

        return map;
    }
}
