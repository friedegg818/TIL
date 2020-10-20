package com.sp.score;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("score.scoreService")
public class ScoreServiceImpl implements ScoreService {
	@Autowired
	private ScoreDAO scoreDAO;
	
	@Override
	public int insertScore(Score dto) throws Exception {
		
		int result = 0;
		try {
			result = scoreDAO.insertScore(dto);
		} catch (Exception e) {
			throw e;
		}		
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {		
		return scoreDAO.dataCount(map);
	}

	@Override
	public List<Score> listScore(Map<String, Object> map) {
		return scoreDAO.listScore(map);
	}

	@Override
	public Score readScore(String hak) {	
		return scoreDAO.readScore(hak);
	}

	@Override
	public int updateScore(Score dto) throws Exception {
		int result = 0;
		try {
			result = scoreDAO.updateScore(dto);
		} catch (Exception e) {
			throw e;
		}
		
		return result;
	}

	@Override
	public int deleteScore(String hak) throws Exception {
		int result = 0; 
		try {
			result = scoreDAO.deleteScore(hak);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	public int deleteListScore(List<String> haks) throws Exception {
		int result = 0; 
		try {
			result = scoreDAO.deleteListScore(haks);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}
}
