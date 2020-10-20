package com.sp.blog;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("blog.blogController")
public class BlogController {
	@Autowired
	private BlogService service;
	
	@RequestMapping(value="/blog")
	public String blogList(Model model) {
		List<Blog> list = service.listBlog();
		model.addAttribute("list", list);
		
		return "blog/blog";
	}
	
	// @PathVariable : URI 템플릿을 이용하여 REST 방식의 처리를 지원
	// REST 방식 : URI를 알면 http 프로토콜만으로 접근 가능한 서비스 
	@RequestMapping(value="/blog/{idx}/main")	// 동적인 주소 처리 ($ 표시 안붙임)
	public String blogMain(
			@PathVariable long idx,
			Model model
			) {
		
		Blog dto = service.readBlog(idx);
		
		model.addAttribute("dto", dto);
		
		return "blog/main";
	}
}
