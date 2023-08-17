package com.multi.hontrip.mate.controller;

import com.multi.hontrip.mate.dto.*;
import com.multi.hontrip.mate.service.MateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("mate")
public class MateController {

    @Autowired
    private MateService mateService;

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