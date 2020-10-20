package com.sp.common.jdbc;

import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

public abstract class JdbcDAO extends JdbcDaoSupport {
	@Autowired
	private BasicDataSource dataSource;
	
	// @PostConstruct 어노테이션은 의존하는 객체를 설정한 이후에 초기화 작업을 수행 할 메서드에서 적용(init() 메소드 역활)
	@PostConstruct
	public void init(){
	     setDataSource(dataSource);
	}
	
	public abstract void insertData(String sql) throws Exception;
	public abstract void insertData(String sql, Object[] object) throws Exception;
	
	public abstract void updateData(String sql) throws Exception;
	public abstract void updateData(String sql, Object[] object) throws Exception;
	
	public abstract void deleteData(String sql) throws Exception;
	public abstract void deleteData(String sql, Object[] object) throws Exception;
	
	public abstract <T> List<T> selectList(String sql, RowMapper<T> rowMapper);
	public abstract <T> List<T> selectList(String sql, Object[] object, RowMapper<T> rowMapper);
	
	public abstract <T> T selectOne(String sql, RowMapper<T> rowMapper);
	public abstract <T> T selectOne(String sql, Object[] object, RowMapper<T> rowMapper);
}
