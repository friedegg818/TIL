package com.sp.score;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

/*
- JdbcTemplate 클래스
  SQL문 실행을 위한 메소드를 제공

- JdbcDaoSupport
  Spring JDBC 는 데이터베이스와의 Connection을 관리하기 위하여 DataSource 만을 사용하고 있으면 쿼리를 실행하는 방법으로 JdbcTemplate 과 SQLObject 두 가지 방식을 지원하고 있다. 

   단순히 JdbcTemplate SQLObject 만을 이용해서 데이터를 가공하는 것은 가능하다.
   하지만 DAO 패턴을 적용하기 위해 모든 DAO클래스에서 공통적으로 필요한 속성과 기능들을 포함하고 있는 Base 클래스로 JdbcDaoSupport를 지원하고 있다. 
   즉 JdbcDaoSupport는 DateSource를 관리할 뿐 아니라 jdbcTemplate클래스에 접근 가능하도록 지원하고 있다. 
  
- RowMapper
  ResultSet에서 값을 가져와 원하는 타입으로 매핑 할 때 사용 됨
*/

@Repository("dao.scoreDAO")
public class ScoreDAOImpl extends ScoreDAO {
	@Override
	public void insertScore(Score dto) throws Exception {
    	String sql="";
		try {
		    sql = "INSERT INTO score ";
	        sql += "(hak, name, birth, kor, eng, mat)  VALUES "; 
	        sql += "(?, ?, ?, ?, ?, ?)";
	        
	        Object [] object = new Object[] {
	        		dto.getHak(),
	        		dto.getName(),
	        		dto.getBirth(),
	        		dto.getKor(),
	        		dto.getEng(),
	        		dto.getMat(),
			};
			
			// PreparedStatement
			getJdbcTemplate().update(sql, object);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount() {
    	int result = 0;
		String sql="";
		
		try {
			sql="SELECT COUNT(*) FROM score ";
			RowMapper<Object> rowMapper =  new RowMapper<Object>() {
				public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
					int cnt=rs.getInt(1);
					return cnt;
				}
			};
			result = (Integer)getJdbcTemplate().queryForObject(sql, rowMapper);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;			
	}
	
	@Override
	public List<Score> listScore(Map<String, Object> map) {
		List<Score> list=null;
		String sql="";
		
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
			
			list = getJdbcTemplate().query(sql, object, rowMapper);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return list;
	}

	@Override
	public Score readScore(String hak) {
		Score dto=null;
		String sql="";
		
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
			dto = getJdbcTemplate().queryForObject(sql, object, rowMapper);
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
	        getJdbcTemplate().update(sql, object);
	    } catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteScore(String hak) throws Exception {
		String sql="";

		try {
			sql = "DELETE FROM score WHERE hak = ?";
	        Object [] object = new Object[] {
	        		hak
			};

	         // PreparedStatement
			getJdbcTemplate().update(sql, object);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
