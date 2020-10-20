package com.sp.score;

import java.util.List;
import java.util.Map;

public interface ScoreService {
	public int insertScore(Score dto) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Score> listScore(Map<String, Object> map);
	public Score readScore(String hak);
	public int updateScore(Score dto) throws Exception;
	public int deleteScore(String hak) throws Exception;
	public int deleteListScore(List<String> haks) throws Exception; 
	
	public List<Score> listAllScore();
}
