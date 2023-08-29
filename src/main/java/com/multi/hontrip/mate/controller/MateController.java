package com.multi.hontrip.mate.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.mate.dto.*;
import com.multi.hontrip.mate.service.MateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("mate")
public class MateController {

    @Autowired
    private MateService mateService;

    // 게시판 목록 가져오기
    @GetMapping("/bbs_list")
    public String list(MatePageDTO matePageDTO, Model model, HttpSession session) {
        //페이징 변수들 계산하기
        MatePageDTO pagedDTO = mateService.paging(matePageDTO);
        //게시물 리스트 가져오기
        List<MateBoardListDTO> list = mateService.list(pagedDTO);
        //지역 리스트 가져오기
        List<LocationDTO> location = mateService.location();

        model.addAttribute("location", location);

        model.addAttribute("list", list);

        model.addAttribute("pageDTO", pagedDTO);
        return "/mate/bbs_list";
    }

    //페이징 처리
    @GetMapping("/pagination")
    @ResponseBody
    public Map<String, Object> pageList(MatePageDTO matePageDTO, HttpSession session) {
        //페이징 변수들 계산하기
        MatePageDTO pagedDTO = mateService.paging(matePageDTO);
        //게시물 리스트 가져오기
        List<MateBoardListDTO> list = mateService.list(pagedDTO);

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pageDTO", pagedDTO);
        return map;
    }

    @RequestMapping("/region_search")
    @ResponseBody
    public Map<String, Object> regionList(MatePageDTO matePageDTO, HttpSession session) {
        //페이징 변수들 계산하기
        MatePageDTO pagedDTO = mateService.paging(matePageDTO);
        //게시물 리스트 가져오기
        List<MateBoardListDTO> list = mateService.regionList(pagedDTO);

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pageDTO", pagedDTO);
        return map;
    }

    //댓글 insert
    @RequestMapping("comment_insert")
    @ResponseBody
    @RequiredSessionCheck
    public Map<String,Object> insert(MateCommentDTO mateCommentDTO, HttpSession httpSession) {
        int result = mateService.commentInsert(mateCommentDTO);
        //게시물 상세의 댓글 리스트 가져오기
        List<MateCommentDTO> list = mateService.commentList(mateCommentDTO.getMateBoardId());
        //게시물 상세의 답글 리스트 가져오기
        List<MateCommentDTO> reCommentList = mateService.reCommentList(list);
        //게시물 상세의 댓글 개수 카운트 하기
        int commentListCount = mateService.commentCount(mateCommentDTO.getMateBoardId());

        Map<String,Object> map=new HashMap<>();
        map.put("commentListCount", commentListCount);
        map.put("list", list);
        map.put("reCommentList", reCommentList);
        return map;
    }

    //댓글 delete
    @RequestMapping("comment_edit")
    @ResponseBody
    @RequiredSessionCheck
    public Map<String,Object> edit(MateCommentDTO mateCommentDTO) {
        mateService.commentEdit(mateCommentDTO);
        //게시물 상세의 댓글 리스트 가져오기
        List<MateCommentDTO> list = mateService.commentList(mateCommentDTO.getMateBoardId());
        //게시물 상세의 답글 리스트 가져오기
        List<MateCommentDTO> reCommentList = mateService.reCommentList(list);
        //게시물 상세의 댓글 개수 카운트 하기
        int commentListCount = mateService.commentCount(mateCommentDTO.getMateBoardId());

        Map<String,Object> map=new HashMap<>();
        map.put("commentListCount", commentListCount);
        map.put("list", list);
        map.put("reCommentList", reCommentList);
        return map;
    }

    @RequestMapping("comment_delete")
    @ResponseBody
    @RequiredSessionCheck
    public Map<String,Object> delete(MateCommentDTO mateCommentDTO) {
        mateService.commentDelete(mateCommentDTO);
        //게시물 상세의 댓글 리스트 가져오기
        List<MateCommentDTO> list = mateService.commentList(mateCommentDTO.getMateBoardId());
        //게시물 상세의 답글 리스트 가져오기
        List<MateCommentDTO> reCommentList = mateService.reCommentList(list);
        //게시물 상세의 댓글 개수 카운트 하기
        int commentListCount = mateService.commentCount(mateCommentDTO.getMateBoardId());

        Map<String,Object> map=new HashMap<>();
        map.put("commentListCount", commentListCount);
        map.put("list", list);
        map.put("reCommentList", reCommentList);
        return map;
    }

    @RequestMapping("reply_insert")
    @ResponseBody
    @RequiredSessionCheck
    public Map<String,Object> reply(MateCommentDTO mateCommentDTO) {
        int result = mateService.replyInsert(mateCommentDTO);
        //게시물 상세의 댓글 리스트 가져오기
        List<MateCommentDTO> list = mateService.commentList(mateCommentDTO.getMateBoardId());
        //게시물 상세의 답글 리스트 가져오기
        List<MateCommentDTO> reCommentList = mateService.reCommentList(list);
        //게시물 상세의 댓글 개수 카운트 하기
        int commentListCount = mateService.commentCount(mateCommentDTO.getMateBoardId());

        Map<String,Object> map=new HashMap<>();
        map.put("commentListCount", commentListCount);
        map.put("list", list);
        map.put("reCommentList", reCommentList);
        return map;
    }

    /* 동행인게시판 글 작성 get 매핑*/
    @GetMapping("/insert")
    @RequiredSessionCheck
    public String insert(HttpSession session) {
        return "/mate/mate_board_insert";
    }

    /* 동행인게시판 글 작성 post 매핑*/
    @PostMapping("/insert")
    @ResponseBody
    public long insert(@RequestParam("file") MultipartFile file,
                       MateBoardInsertDTO mateBoardInsertDTO,
                       HttpServletRequest request, RedirectAttributes redirectAttributes
    ) {
        mateService.insert(file, mateBoardInsertDTO);
        redirectAttributes.addAttribute("id", mateBoardInsertDTO.getId());
        return mateBoardInsertDTO.getId();
    }


    /* 동행인 상세 게시글  get 매핑*/
    @GetMapping("/{id}")
    public String selectOne(@PathVariable("id") long id, Model model, HttpSession session) {
        MateBoardSelectOneDTO mateBoardSelectOneDTO = mateService.selectOne(id);
        //게시물 상세의 댓글 리스트 가져오기
        List<MateCommentDTO> list = mateService.commentList(id);
        //게시물 상세의 답글 리스트 가져오기
        List<MateCommentDTO> reCommentList = mateService.reCommentList(list);
        //게시물 상세의 댓글 개수 카운트 하기
        int commentListCount = mateService.commentCount(id);

        model.addAttribute("commentListCount", commentListCount);
        model.addAttribute("list", list);
        model.addAttribute("reCommentList", reCommentList);
        model.addAttribute("dto", mateBoardSelectOneDTO);
        return "/mate/mate_board_selectOne";
    }

    /*produces="text/plain;charset=UTF-8" <- Gson().toJson(user) 할때 한글이 깨지는 현상을 방지하기 위해*/
    /* 동행인 신청자의 조건 부합 여부를 확인하기 위해 -> 신청자의 성별과 연령대를 불러오는 메서드 */
    @RequestMapping(value = "findUserGenderAge", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String findUserGenderAgeById(@RequestParam("id") long id) {
        UserGenderAgeDTO userGenderAgeDTO = mateService.findUserGenderAgeById(id);
        JsonObject user = new JsonObject();
        user.addProperty("id", userGenderAgeDTO.getId());
        user.addProperty("gender", userGenderAgeDTO.getGender().getGenderStr());
        user.addProperty("ageRange", userGenderAgeDTO.getAgeRange().getAgeRangeStr());
        return new Gson().toJson(user);
    }

    /*동행 상세게시판 삭제*/
    @DeleteMapping("/delete/{id}")
    @ResponseBody
    public int deleteMateBoard(@PathVariable("id") long id) {
        return mateService.deleteMateBoard(id);
    }

    /*동행 게시판 수정페이지 이동*/
    @PostMapping("/editpage")
    public String updateMateBoard(MateBoardInsertDTO mateBoardInsertDTO, Model model) {
        model.addAttribute("dto", mateBoardInsertDTO);
        return "/mate/mate_board_update";
    }


    /*동행 게시판 수정사항 반영*/
    @PostMapping("/edit")
    public String updateMateBoard(
            @RequestParam(value = "file", required = false) MultipartFile file,
            MateBoardInsertDTO mateBoardInsertDTO) throws IOException {
        if (file != null && !file.isEmpty()) {
            String savedFileName = file.getOriginalFilename();
            mateBoardInsertDTO.setThumbnail(savedFileName);
            String uploadPath = "D:\\hontrip\\src\\main\\webapp\\resources\\img\\mateImg";
            File target = new File(uploadPath + "/" + savedFileName);
            file.transferTo(target);
        }
        mateService.updateMateBoard(mateBoardInsertDTO);
        return "redirect:/mate/" + mateBoardInsertDTO.getId();
    }


    /* 동행 신청자의 신청 여부를 확인*/
    @GetMapping("checkApply")
    @ResponseBody
    public int checkApply(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        int num = mateService.checkApply(mateMatchingAlarmDTO);
        return mateService.checkApply(mateMatchingAlarmDTO);
    }


//    @RequestMapping("bbs_one")
//    public void one(int id, Model model) {
//        BbsDTO dto = bbsDAO.one(id);
//        List<ReplyDTO> list = replyDAO.list(id);
//        model.addAttribute("dto", dto);
//        model.addAttribute("list", list);
}
