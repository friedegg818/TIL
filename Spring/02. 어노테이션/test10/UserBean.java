package com.test10;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UserBean {
	@Autowired
	private Movie movie;
	@Resource(name="music")
	private Music music;
	
	public void execute() {
		movie.play();
		music.play();
	}
}
