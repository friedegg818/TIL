package com.sp.note;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("note.noteController")
@RequestMapping("/note/*")
public class NoteController {
	@Autowired
	private NoteService service;
	
	@GetMapping("request")
	public String form(Model model) {
		List<Note> list = service.listFriend();
		
		model.addAttribute("listFriend", list);
		
		return "note/note";
	}
	
	@PostMapping("request")
	public String submit(Note dto, Model model) {
		
		String s;		
		
		s = "받는사람 : ";
		for(String id : dto.getReceiver()) {
			s += id + " ";
		}
		s += "<br>내용 : <br>";
		s += dto.getMsg().replaceAll("\n", "<br>");	
		
		model.addAttribute("result", s);
		
		return "note/view";
	}

}

