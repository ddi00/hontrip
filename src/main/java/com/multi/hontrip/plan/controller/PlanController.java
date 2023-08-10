package com.multi.hontrip.plan.controller;


import com.multi.hontrip.plan.dto.PlanDTO;
import com.multi.hontrip.plan.service.PlanService;
import com.multi.hontrip.plan.utils.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/plan")
public class PlanController {

    @Autowired
    PlanService planService;

    /*@RequestMapping("/plan_form") // 여행일정 insert
    public String showPlanForm(@ModelAttribute("planDTO") PlanDTO planDTO) {
        return "plan/plan_form";
    }
    @RequestMapping(value = "/insert_plan", method = RequestMethod.POST)
    public String insert(HttpServletRequest request) {
        // request.getParameter()를 사용하여 폼 데이터 가져오기
        Long userId = 1L;
        String title = request.getParameter("title");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String memo = request.getParameter("memo");

        // 가져온 문자열로 Date 객체로 변환
        Date startDate = null;
        Date endDate = null;
        try {
            startDate = DateUtil.parseDate(startDateStr);
            endDate = DateUtil.parseDate(endDateStr);
        } catch (ParseException e) {
            // 날짜 파싱에 실패할 경우 예외 처리
            e.printStackTrace();
            // 실패 처리 방법에 따라 구현
        }

        // 가져온 데이터로 PlanDTO 생성
        PlanDTO planDTO = new PlanDTO();
        planDTO.setUserId(userId); // 사용자 ID 설정 (실제로는 세션 등에서 가져와야 함)
        planDTO.setTitle(title);
        planDTO.setStartDate(startDate);
        planDTO.setEndDate(endDate);
        planDTO.setMemo(memo);

        // 데이터베이스에 저장
        planService.insert(planDTO);

        // 리다이렉션
        return "redirect:/plan/plan_list";
    }*/

    @RequestMapping("/plan_form") // 여행일정 insert 폼을 보여줌
    public String showPlanForm(@ModelAttribute("planDTO") PlanDTO planDTO) {
        return "plan/plan_form"; // "resources/templates/plan/plan_form.html" 템플릿 파일을 사용
    }

    @RequestMapping(value = "/insert_plan", method = RequestMethod.POST)
    public String insert(@ModelAttribute("planDTO") PlanDTO planDTO) {
        // 사용자 ID 설정 (실제로는 세션 등에서 가져와야 함)
        planDTO.setUserId(1L);

        // 데이터베이스에 저장
        planService.insert(planDTO);

        // 리다이렉션하여 일정 목록 페이지로 이동
        return "redirect:/plan/plan_list";
    }


// 업데이트
@RequestMapping(value= "/plan_update", method = RequestMethod.GET)
public String getUpdate(PlanDTO plan, Model model) {
    model.addAttribute("plan", planService.one(plan.getId()));
    return "plan/plan_edit";
}

    @RequestMapping(value= "/plan_update", method = RequestMethod.POST)
    public String update(PlanDTO plan) {
        planService.update(plan);
        System.out.println("Plan updated successfully!");
        return "redirect:/plan/plan_list";
    }

    @RequestMapping("/plan_delete")
    public String delete(PlanDTO plan) {
        planService.delete(plan.getId());
        System.out.println("Plan deleted successfully!");
        return "redirect:/plan/plan_list";
    }

    @RequestMapping("/plan_one")
    public void one(Long id, Model model) {
        PlanDTO plan = planService.one(id);
        model.addAttribute("plan", plan);
    }

    @RequestMapping("/plan_list")
    public void list(Model model) {
        List<PlanDTO> list = planService.list();
        model.addAttribute("list", list);
    }
}
