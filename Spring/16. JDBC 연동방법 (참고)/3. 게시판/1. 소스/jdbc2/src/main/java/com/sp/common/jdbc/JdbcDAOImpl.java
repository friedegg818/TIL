package com.sp.common.jdbc;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
/*
  - JdbcTemplate 클래스
    SQL문 실행을 위한 메소드를 제공
    
    JdbcTemplate 클래스 객체를 생성하는 다른방법 - 객체 생성 시 DataSource 객체를 넘겨줌
    private JdbcTemplate jdbcTemplate;
               :
    public void setDao(DataSource dataSource) {
        jdbcTempleat = new JdbcTemplate(dataSource);
    }
    
  - RowMapper
    ResultSet에서 값을 가져와 원하는 타입으로 매핑 할 때 사용 됨
 */

@Repository("jdbcDAO")
public class JdbcDAOImpl extends JdbcDAO {
	@Override
	public void insertData(String sql) throws Exception {
		try {
			// getJdbcTemplate() : JdbcTemplate 객체
			// Statement
			getJdbcTemplate().update(sql);
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void insertData(String sql, Object[] object) throws Exception {
		try {
			// PreparedStatement
			getJdbcTemplate().update(sql, object);
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw e;
		}
	}

	public void updateData(String sql) throws Exception {
		try {
			getJdbcTemplate().update(sql);
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateData(String sql, Object[] object) throws Exception {
		try {
			getJdbcTemplate().update(sql, object);
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw e;
		}
	}

	public void deleteData(String sql) throws Exception {
		try {
			getJdbcTemplate().update(sql);
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void deleteData(String sql, Object[] object) throws Exception {
		try {
			getJdbcTemplate().update(sql, object);
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public <T> List<T> selectList(String sql, RowMapper<T> rowMapper) {
		List<T> list=null;
		
		try {
			list = getJdbcTemplate().query(sql, rowMapper);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public <T> List<T> selectList(String sql, Object[] object, RowMapper<T> rowMapper) {
		List<T> list=null;
		
		try {
			list = getJdbcTemplate().query(sql, object, rowMapper);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public <T> T selectOne(String sql, RowMapper<T> rowMapper) {
		T dto=null;
		
		try {
			dto = getJdbcTemplate().queryForObject(sql, rowMapper);
		} catch (EmptyResultDataAccessException e) {
			// 데이터가 존재하지 않으면 EmptyResultDataAccessException 예외 발생
			return null;
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public <T> T selectOne(String sql, Object[] object, RowMapper<T> rowMapper) {
		T dto=null;
		try {
			dto = getJdbcTemplate().queryForObject(sql, object, rowMapper);
		} catch (EmptyResultDataAccessException e) {
			// 데이터가 존재하지 않으면 EmptyResultDataAccessException 예외 발생
			return null;
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return dto;
	}
}
