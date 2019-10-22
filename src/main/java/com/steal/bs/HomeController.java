package com.steal.bs;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.steal.bs.chatting.ChatBiz;
import com.steal.bs.chatting.ChatDto;
import com.steal.bs.chatting.ChatMemberDto;
import com.steal.bs.model.ChattingDto;



@Controller
public class HomeController {

	@Autowired
	ChatBiz chatBiz;
	
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
	public String tiles(Model model, HttpSession session, @ModelAttribute ChatDto dto) {
		
		ChatDto checkdto = chatBiz.checkRoom(dto.getName());
		
		ChattingDto logindto = new ChattingDto();
		
		if(checkdto == null) {
			chatBiz.createChatRoom(dto);
			logindto.setMain_id(dto.getMaster());
			logindto.setAuthority("0");
			model.addAttribute("login", logindto);
			session.setAttribute("login", logindto);
			session.setAttribute("dto", dto);
			chatBiz.addRoomMember(new ChatMemberDto(0, dto.getMaster(),dto.getName(),""));
		} else {
			logindto.setMain_id(dto.getUser1());
			logindto.setAuthority("1");
			model.addAttribute("login", logindto);
			session.setAttribute("login", logindto);
			chatBiz.addRoomMember(new ChatMemberDto(0, dto.getUser1(),dto.getName(),""));
		}
		
		model.addAttribute("room", dto.getName());
		
		return "redirect:/chat.do";
		
	}
	
}
