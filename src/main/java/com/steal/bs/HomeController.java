package com.steal.bs;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.steal.bs.model.ChattingDto;


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "chat.tiles", method = RequestMethod.GET)
	public String tiles(Model model, HttpSession session, @RequestParam("id") String id) {
		
		ChattingDto dto = new ChattingDto();
		
		if(id.equals("zongyeng")) {
			id="admin";
		}
	
		dto.setMain_id(id);
		model.addAttribute("login", dto);
		session.setAttribute("login", dto);
		
		return "forward:/chat.do";
		
	}
	
}
