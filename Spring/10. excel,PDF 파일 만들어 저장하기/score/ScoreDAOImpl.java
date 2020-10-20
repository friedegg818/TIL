package com.sp.score;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository("score.scoreDAO")
public class ScoreDAOImpl implements ScoreDAO {
	/*@Autowired*/
	@Resource(name="sqlSession")		/* SqlSessionTemplete bean id가 이름  */
	private SqlSession sqlSession;
	
	@Override
	public int insertScore(Score dto) throws Exception {
		int result = 0;
		try {
			result = sqlSession.insert("score.insertScore", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e; 			
		} 
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			// selectOne : SELECT 실행 후 1개의 행만 반환 받는 경우 
			result = sqlSession.selectOne("score.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return result;
	}

	@Override
	public <T> List<T> listScore(Map<String, Object> map) {
		List<T> list = null; 
		
		try {
			list = sqlSession.selectList("score.listScore", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Score readScore(String hak) {
		Score dto = null; 
		try {
			dto = sqlSession.selectOne("score.readScore", hak);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int updateScore(Score dto) throws Exception {
		int result = 0;
		
		try {
			result = sqlSession.update("score.updateScore", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
		return result;
	}

	@Override
	public int deleteScore(String hak) throws Exception {
		int result = 0;
		
		try {
			result = sqlSession.delete("score.deleteScore", hak);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
		return result;		
	}

	@Override
	public int deleteListScore(List<String> list) throws Exception {
		int result = 0;
		
		try {
			result = sqlSession.delete("score.deleteListScore", list);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
		return result;	
	}

	@Override
	public <T> List<T> listAllScore() {
		List<T> list = null;
		try {
			list = sqlSession.selectList("score.listAllScore");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
