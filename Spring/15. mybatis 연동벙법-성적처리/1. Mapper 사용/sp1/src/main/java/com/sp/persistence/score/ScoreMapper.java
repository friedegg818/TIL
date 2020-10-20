package com.sp.persistence.score;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.sp.score.Score;

@Repository("score.scoreMapper")
public interface ScoreMapper {
	public void insertScore(Score dto) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Score> listScore(Map<String, Object> map);
	public Score readScore(String hak);
	public void updateScore(Score dto) throws Exception;
	public void deleteScore(String hak) throws Exception;
}
