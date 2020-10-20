package com.sp.score;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("score.scoreService")
public class ScoreServiceImpl implements ScoreService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertScore(Score dto) throws Exception {
		try {
			dao.insertData("score.insertScore", dto);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("score.dataCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public List<Score> listScore(Map<String, Object> map) {
		List<Score> list=null;
		
		try {
			list=dao.selectList("score.listScore", map);
		} catch (Exception e) {
		}
		
		return list;
	}

	@Override
	public Score readScore(String hak) {
		Score dto=null;
		try {
			dto=dao.selectOne("score.readScore", hak);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public void updateScore(Score dto) throws Exception {
		try {
			dao.updateData("score.updateScore", dto);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public void deleteScore(String hak) throws Exception {
		try {
			dao.deleteData("score.deleteScore", hak);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public void deleteScoreList(List<String> list) throws Exception {
		try {
			dao.deleteData("score.deleteScoreList", list);
		} catch (Exception e) {
			throw e;
		}
	}
}
