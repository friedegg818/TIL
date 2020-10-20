package com.sp.blog;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

@Service("service.blogService")
public class BlogServiceImpl implements BlogService {
	private List<Blog> list = null;
	
	public BlogServiceImpl() {
		list = new ArrayList<Blog>();
		
		list.add(new Blog(1001L, "박지송아", "자바를 부셔버리자", "프로그래밍"));
		list.add(new Blog(1002L, "정혜화", "스프링 정복", "프로그래밍"));
		list.add(new Blog(1003L, "정우진", "오라클 독학", "데이터베이스"));
		list.add(new Blog(1004L, "이다혜", "HTML 배워봐요", "WEB"));
		list.add(new Blog(1005L, "박성하", "자바스크립트 따라하기", "WEB"));
	}
	
	@Override
	public List<Blog> listBlog() {	
		return list;
	}

	@Override
	public Blog readBlog(long idx) {
		Blog dto = null;
		
		for(Blog b : list) {
			if(b.getUserIdx()==idx) {
				return b;
			}
		}
		
		return dto;
	}

}
