package com.multi.hontrip;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import com.multi.hontrip.plan.dto.SpotDTO;
import com.multi.hontrip.plan.dto.SpotInfoDTO;
import com.multi.hontrip.plan.service.SpotService;
import com.multi.hontrip.record.dto.PostInfoDTO;
import com.multi.hontrip.record.service.RecordService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequiredArgsConstructor
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	private final RecordService recordService;
	private final SpotService spotService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		// 기록
		List<PostInfoDTO> topList = recordService.likeTopTen();
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);


		model.addAttribute("topList", topList);
		model.addAttribute("serverTime", formattedDate );

		// 여행지
		List<SpotInfoDTO> topSpotList = spotService.listTopTenSpot();
		model.addAttribute("topSpotList", topSpotList);

		return "home";
	}
	
}
