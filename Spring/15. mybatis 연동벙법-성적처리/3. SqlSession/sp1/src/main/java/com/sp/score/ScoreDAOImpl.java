package com.sp.score;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("scoreDAO")
public class ScoreDAOImpl implements ScoreDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertScore(Score dto) throws Exception {
		try {
			sqlSession.insert("score.insertScore", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
			
			throw e;
		} finally {
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
    	int result = 0;
    	
		try {
			result = ((Integer)sqlSession.selectOne("score.dataCount", map)).intValue();
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
		}
		return result;
	}
	
	@Override
	public <T> List<T> listScore(Map<String, Object> map) {
		List<T> list=null;
		try {
			   list = sqlSession.selectList("score.listScore", map);	
		} catch (Exception e) {
			System.out.println(e.toString());
		}
			
		return list;
	}

	@Override
	public Score readScore(String hak) {
		Score dto=null;
		try {
			dto = (Score) sqlSession.selectOne("score.readScore", hak);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public void updateScore(Score dto) throws Exception {
		try {
	   	    sqlSession.update("score.updateScore", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
			
			throw e;
		}
	}

	@Override
	public void deleteScore(String hak) throws Exception {
		try {
			sqlSession.delete("score.deleteScore", hak);
		} catch (Exception e) {
			throw e;
		}
	}
}
