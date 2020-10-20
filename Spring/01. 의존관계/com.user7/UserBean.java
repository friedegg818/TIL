package com.user7;

public class UserBean {
	private Movie movie;
	private Music music;
	
	public void setMovie(Movie movie) {
		this.movie = movie;
	}
	public void setMusic(Music music) {
		this.music = music;
	}
	
	public void execute() {
		movie.play();
		music.play();
	}
}
