package com.sp.score;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.persistence.score.ScoreMapper;

@Service("score.scoreService")
public class ScoreServiceImpl implements ScoreService {
	@Autowired
	private ScoreMapper mapper;
	
	@Override
	public void insertScore(Score dto) throws Exception {
		try {
			mapper.insertScore(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=mapper.dataCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public List<Score> listScore(Map<String, Object> map) {
		List<Score> list=null;
		try {
			list=mapper.listScore(map);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void updateScore(Score dto) throws Exception {
		try {
			mapper.updateScore(dto);	
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public void deleteScore(String hak) throws Exception{
		try {
			mapper.deleteScore(hak);	
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public Score readScore(String hak) {
		Score dto=null;
		try {
			dto=mapper.readScore(hak);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

}
