package com.sp.score;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

public abstract class ScoreDAO extends JdbcDaoSupport{
	@Autowired
	private BasicDataSource dataSource;
	
	// @PostConstruct 어노테이션은 의존하는 객체를 설정한 이후에 초기화 작업을 수행 할 메서드에서 적용(init() 메소드 역활)
	@PostConstruct
	public void init(){
	     setDataSource(dataSource);
	}

	public abstract void insertScore(Score dto) throws Exception;
	public abstract int dataCount();
	public abstract List<Score> listScore(Map<String, Object> map);
	public abstract Score readScore(String hak);
	public abstract void updateScore(Score dto) throws Exception;
	public abstract void deleteScore(String hak) throws Exception;
}
