package com.sp.score;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("score.scoreService")
public class ScoreServiceImpl implements ScoreService {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertScore(Score dto) throws Exception {
		try {
			ScoreDAO dao = sqlSession.getMapper(ScoreDAO.class);
			dao.insertScore(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			ScoreDAO dao = sqlSession.getMapper(ScoreDAO.class);
			result=dao.dataCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public List<Score> listScore(Map<String, Object> map) {
		List<Score> list=null;
		try {
			ScoreDAO dao = sqlSession.getMapper(ScoreDAO.class);
			list=dao.listScore(map);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void updateScore(Score dto) throws Exception {
		try {
			ScoreDAO dao = sqlSession.getMapper(ScoreDAO.class);
			dao.updateScore(dto);	
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteScore(String hak) throws Exception {
		try {
			ScoreDAO dao = sqlSession.getMapper(ScoreDAO.class);
			dao.deleteScore(hak);	
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Score readScore(String hak) {
		Score dto=null;
		try {
			ScoreDAO dao = sqlSession.getMapper(ScoreDAO.class);
			dto=dao.readScore(hak);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
}
