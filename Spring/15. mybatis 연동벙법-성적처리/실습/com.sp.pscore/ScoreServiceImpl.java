package com.sp.pscore;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("pscore.scoreService")
public class ScoreServiceImpl implements ScoreService {
	@Autowired
	CommonDAO dao;

	@Override
	public void insertScore(Score dto) throws Exception {
		try {
			// 프로시저는 Sqlsession의 update() 메소드로 실행하며 태그도 <update> 태그를 사용한다.
			dao.callUpdateProcedure("pscore.insertScore", dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}		
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result=0;
		
		try {
			dao.callSelectOneProcedureMap("pscore.dataCount", map);
			result = (Integer)map.get("result");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Score> listScore(Map<String, Object> map) throws Exception {
		List<Score> list = null;
		
		try {
			dao.callSelectListProcedureMap("pscore.listScore", map);
			list = (List<Score>)map.get("result");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Score readScore(Map<String, Object> map) throws Exception {
		Score dto = null;
		
		try {
			dao.callSelectListProcedureMap("pscore.readScore", map);
			List<Score> list = (List<Score>)map.get("result");
			if(list!=null && list.size()>=1) {
				dto = (Score)list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return dto;
	}

	@Override
	public void updateScore(Score dto) throws Exception {
		try {
			dao.callUpdateProcedure("pscore.updateScore", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}

	@Override
	public void deleteScore(String hak) throws Exception {
		try {
			dao.callUpdateProcedure("pscore.deleteScore", hak);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
