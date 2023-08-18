package com.multi.hontrip.mate.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.multi.hontrip.mate.dto.*;
import com.multi.hontrip.mate.service.MateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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

    @GetMapping("/bbs_list")
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

    /* 동행인게시판 글 작성 get 매핑*/
    @GetMapping("/insert")
    public String insert() {
        return "/mate/mate_board_insert";
    }

    /* 동행인게시판 글 작성 post 매핑*/
    @PostMapping("/insert")
    public String insert(@RequestParam("file") MultipartFile file,
                         MateBoardInsertDTO mateBoardInsertDTO,
                         HttpServletRequest request
    ) throws IOException {
        String savedFileName = file.getOriginalFilename();
        mateBoardInsertDTO.setThumbnail(savedFileName);
        String uploadPath = "D:\\hontrip\\src\\main\\webapp\\resources\\upload";
        File target = new File(uploadPath + "/" + savedFileName);
        file.transferTo(target);
        System.out.println(mateBoardInsertDTO);
        mateService.insert(mateBoardInsertDTO);
        return "redirect:/mate/" + mateBoardInsertDTO.getId();
    }


    /* 동행인 상세 게시글  get 매핑*/
    @GetMapping("/{id}")
    public String selectOne(@PathVariable("id") long id, Model model) {
        MateBoardInsertDTO mateBoardInsertDTO = mateService.selectOne(id);
        System.out.println(mateBoardInsertDTO);
        model.addAttribute("dto", mateBoardInsertDTO);
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

    @DeleteMapping("/delete/{id}")
    @ResponseBody
    public int deleteMateBoard(@PathVariable("id") long id) {
        return mateService.deleteMateBoard(id);
    }

    @PostMapping("/editpage")
    public String updateMateBoard(MateBoardInsertDTO mateBoardInsertDTO, Model model) {
        model.addAttribute("dto", mateBoardInsertDTO);
        return "/mate/mate_board_update";
    }


    @PostMapping("/edit")
    public String updateMateBoard(
            @RequestParam(value = "file", required = false) MultipartFile file,
            MateBoardInsertDTO mateBoardInsertDTO) throws IOException {
        if (file != null && !file.isEmpty()) {
            String savedFileName = file.getOriginalFilename();
            mateBoardInsertDTO.setThumbnail(savedFileName);
            String uploadPath = "D:\\hontrip\\src\\main\\webapp\\resources\\upload";
            File target = new File(uploadPath + "/" + savedFileName);
            file.transferTo(target);
        }
        mateService.updateMateBoard(mateBoardInsertDTO);
        return "redirect:/mate/" + mateBoardInsertDTO.getId();
    }


    //return값이 필요한 이유 -> ajax에서 불렀을때 리턴값이 없으면 404뜸
    @PostMapping("insertMatchingAlarm")
    @ResponseBody
    public int insertMatchingAlarm(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        return mateService.insertMatchingAlarm(mateMatchingAlarmDTO);
    }


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
