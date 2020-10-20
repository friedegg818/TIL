package com.sp.score;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

/*
- JdbcTemplate 클래스
  SQL문 실행을 위한 메소드를 제공
  
- RowMapper
  ResultSet에서 값을 가져와 원하는 타입으로 매핑 할 때 사용 됨
*/

@Repository("score.scoreDAO")
public class ScoreDAOImpl implements ScoreDAO {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public void insertScore(Score dto) throws Exception {
    	String sql;
		try {
		    sql = "INSERT INTO score ";
	        sql += "(hak, name, birth, kor, eng, mat)  VALUES (?, ?, ?, ?, ?, ?)";
	        
	        Object [] object = new Object[] {
	        		dto.getHak(),
	        		dto.getName(),
	        		dto.getBirth(),
	        		dto.getKor(),
	        		dto.getEng(),
	        		dto.getMat(),
			};
			
			// PreparedStatement
			jdbcTemplate.update(sql, object);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount() {
    	int result = 0;
		String sql;
		
		try {
			sql="SELECT COUNT(*) FROM score ";
			RowMapper<Object> rowMapper =  new RowMapper<Object>() {
				public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
					int cnt=rs.getInt(1);
					return cnt;
				}
			};
			result = (Integer)jdbcTemplate.queryForObject(sql, rowMapper);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;			
	}
	
	@Override
	public List<Score> listScore(Map<String, Object> map) {
		List<Score> list=null;
		String sql;
		
		try {
			sql="SELECT hak, name, TO_CHAR(birth, 'YYYY-MM-DD') birth,";
			sql+="   kor, eng, mat, kor+eng+mat tot, ";
			sql+="   (kor+eng+mat)/3 ave ";
			sql+="  FROM score";
			sql+="  ORDER BY hak ASC";
			sql+="  OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			Object [] object = new Object[] {
	        		map.get("offset"),
	        		map.get("rows")
			};
			
			RowMapper<Score> rowMapper =  new RowMapper<Score>() {
				@Override
				public Score mapRow(ResultSet rs, int rowNum) throws SQLException {
					Score dto = new Score();
					dto.setHak(rs.getString("hak"));
					dto.setName(rs.getString("name"));
					dto.setBirth(rs.getString("birth"));
					dto.setKor(rs.getInt("kor"));
					dto.setEng(rs.getInt("eng"));
					dto.setMat(rs.getInt("mat"));
					dto.setTot(rs.getInt("tot"));
					dto.setAve(rs.getInt("ave"));
					return dto;
				}
			};
			
			list = jdbcTemplate.query(sql, object, rowMapper);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return list;
	}

	@Override
	public Score readScore(String hak) {
		Score dto=null;
		String sql;
		
		try {
			sql="SELECT hak, name, TO_CHAR(birth, 'YYYY-MM-DD') birth, kor, eng, mat FROM score ";
			sql+=" WHERE hak=?";
			
	        Object [] object = new Object[] {
	        		hak
			};
			
			RowMapper<Score> rowMapper =  new RowMapper<Score>() {
				public Score mapRow(ResultSet rs, int rowNum) throws SQLException {
					Score dto = new Score();
					dto.setHak(rs.getString("hak"));
					dto.setName(rs.getString("name"));
					dto.setBirth(rs.getString("birth"));
					dto.setKor(rs.getInt("kor"));
					dto.setEng(rs.getInt("eng"));
					dto.setMat(rs.getInt("mat"));
					return dto;
				}
			};
			
			// PreparedStatement
			dto = jdbcTemplate.queryForObject(sql, object, rowMapper);
		} catch (EmptyResultDataAccessException e) {
			// 데이터가 존재하지 않으면 EmptyResultDataAccessException 예외 발생
			return null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateScore(Score dto) throws Exception {
		String sql;
		
		try {
	        sql = "UPDATE score SET name=?, birth=?, kor=?, eng=?, mat=? "; 
	        sql += "          WHERE hak = ? ";
	        Object [] object = new Object[] {
	        		dto.getName(),
	        		dto.getBirth(),
	        		dto.getKor(),
	        		dto.getEng(),
	        		dto.getMat(),
	        		dto.getHak()
			};
	        
  	         // PreparedStatement
	        jdbcTemplate.update(sql, object);
	    } catch (Exception e) {
	    	e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteScore(String hak) throws Exception {
		String sql;

		try {
			sql = "DELETE FROM score WHERE hak = ?";
	        Object [] object = new Object[] {
	        		hak
			};

	         // PreparedStatement
			jdbcTemplate.update(sql, object);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
