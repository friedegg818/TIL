package com.sp.score;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

/*
- JdbcTemplate 클래스
  SQL문 실행을 위한 메소드를 제공
  
- RowMapper
  ResultSet에서 값을 가져와 원하는 타입으로 매핑 할 때 사용 됨
*/

@Repository("score.scoreDAO")
public class ScoreDAOImpl implements ScoreDAO {
	
	@Override
	public void insertScore(Score dto) throws Exception {

	}

	@Override
	public int dataCount() {
    	int result = 0;

		return result;			
	}
	
	@Override
	public List<Score> listScore(Map<String, Object> map) {
		List<Score> list=null;
			
		return list;
	}

	@Override
	public Score readScore(String hak) {
		Score dto=null;

		return dto;
	}

	@Override
	public void updateScore(Score dto) throws Exception {

	}

	@Override
	public void deleteScore(String hak) throws Exception {

	}

}
