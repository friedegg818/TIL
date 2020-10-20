package com.sp.bbs;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.sp.common.jdbc.JdbcDAO;

@Service("bbs.boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	private JdbcDAO  dao;
	
	@Override
	public void insertBoard(Board board) throws Exception {
		String sql;
		
		try{
		    sql = "INSERT INTO bbs ";
	        sql += "(num, name, pwd, subject, content, ipAddr, hitCount, created)  VALUES "; 
	        sql += "(bbs_seq.NEXTVAL, ?, ?, ?, ?, ?, 0, SYSDATE)";
	        
	        Object [] object = new Object[] {
	        		board.getName(),
	        		board.getPwd(),
	        		board.getSubject(),
	        		board.getContent(),
	        		board.getIpAddr()
			};
		    
			dao.insertData(sql, object);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list=null;
		
		StringBuffer sb=new StringBuffer();
		try{
			String condition=(String)map.get("condition");
			String keyword=(String)map.get("keyword");
			int offset=(Integer)map.get("offset");
			int rows=(Integer)map.get("rows");
			
			sb.append(" SELECT num, name, subject, hitCount, ");
			sb.append("     TO_CHAR(created, 'YYYY-MM-DD') created ");
			sb.append(" FROM bbs ");
			sb.append(" WHERE " + condition + " LIKE '%'|| ? || '%' ");
			sb.append("	ORDER BY num DESC ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

		    RowMapper<Board> rowMapper =  new RowMapper<Board>() {
				public Board mapRow(ResultSet rs, int rowNum) throws SQLException {
					Board dto = new Board();
					dto.setNum(rs.getInt("num"));
					dto.setName(rs.getString("name"));
					dto.setSubject(rs.getString("subject"));
					dto.setCreated(rs.getString("created"));
					dto.setHitCount(rs.getInt("hitCount"));
					return dto;
				}
			};
			
	        Object [] object = new Object[] {
	        		keyword,
	        		offset,
	        		rows
			};
			
			list = dao.selectList(sb.toString(), object, rowMapper);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		String sql;
		try{
			String condition=(String)map.get("condition");
			String keyword=(String)map.get("keyword");
			
	        sql = "SELECT COUNT(*) FROM bbs WHERE " + condition + " LIKE '%' || ? || '%'";
	        
	        RowMapper<Integer> rowMapper =  new RowMapper<Integer>() {
				public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
					int cnt=rs.getInt(1);
					return cnt;
				}
			};
			
	        Object [] object = new Object[] {
	        		keyword
			};
	        
	        result = dao.selectOne(sql, object, rowMapper);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public Board readBoard(int num) {
		Board board=null;
		
		String sql;
		try{
			sql = "SELECT num, name, pwd, subject, content, ipAddr, hitCount, created FROM bbs "; 
	        sql += " WHERE num = ? ";
	        
	        Object [] object = new Object[] {
	        		num
			};
	        
	        RowMapper<Board> rowMapper =  new RowMapper<Board>() {
				public Board mapRow(ResultSet rs, int rowNum) throws SQLException {
					Board dto = new Board();
					
					dto.setNum(rs.getInt("num"));
					dto.setSubject(rs.getString("subject"));
					dto.setPwd(rs.getString("pwd"));
					dto.setName(rs.getString("name"));
					dto.setContent(rs.getString("content"));
					dto.setCreated(rs.getString("created"));
					dto.setHitCount(rs.getInt("hitCount"));
					dto.setIpAddr(rs.getString("ipAddr"));
					
					return dto;
				}
			};
			
	        board = dao.selectOne(sql, object, rowMapper);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return board;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		String sql;

		try{
			sql = "UPDATE bbs SET hitCount=hitCount+1 WHERE num = " +num;
			dao.updateData(sql);

		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Board preReadBoard(Map<String, Object> map) {
		Board board=null;
		
		StringBuffer sb=new StringBuffer();
		try{
			String condition=(String)map.get("condition");
			String keyword=(String)map.get("keyword");
			int num=(Integer)map.get("num");
			
			sb.append(" SELECT num, subject FROM bbs "); 
			sb.append(" WHERE ("+condition+" LIKE '%' || ? || '%') "); 
			sb.append("       AND (num > ?) ");
			sb.append(" ORDER BY num ASC ");
			sb.append(" FETCH FIRST 1 ROWS ONLY ");

		    RowMapper<Board> rowMapper =  new RowMapper<Board>() {
				public Board mapRow(ResultSet rs, int rowNum) throws SQLException {
					Board dto = new Board();
					dto.setNum(rs.getInt("num"));
					dto.setSubject(rs.getString("subject"));
					return dto;
				}
			};
			
	        Object [] object = new Object[] {
	        		keyword,
	        		num
			};
	        
			board = dao.selectOne(sb.toString(), object, rowMapper);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return board;
	}
	
	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		Board board=null;
		
		StringBuffer sb=new StringBuffer();
		try{
			String condition=(String)map.get("condition");
			String keyword=(String)map.get("keyword");
			int num=(Integer)map.get("num");
			
			sb.append(" SELECT num, subject FROM bbs "); 
			sb.append(" WHERE ("+condition+" LIKE '%' || ? || '%') "); 
			sb.append("       AND (num < ?) ");
			sb.append(" ORDER BY num DESC ");
			sb.append(" FETCH FIRST 1 ROWS ONLY ");

		    RowMapper<Board> rowMapper =  new RowMapper<Board>() {
				public Board mapRow(ResultSet rs, int rowNum) throws SQLException {
					Board dto = new Board();
					dto.setNum(rs.getInt("num"));
					dto.setSubject(rs.getString("subject"));
					return dto;
				}
			};
			
	        Object [] object = new Object[] {
	        		keyword,
	        		num
			};
	        
			board = dao.selectOne(sb.toString(), object, rowMapper);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return board;
	}

	@Override
	public void updateBoard(Board board) throws Exception {
		String sql;

		try{
	        sql = "UPDATE bbs SET name=?, pwd=?,  subject=?, content=? "; 
	        sql += "            WHERE num = ? ";
	        Object [] object = new Object[] {
	        		board.getName(),
	        		board.getPwd(),
	        		board.getSubject(),
	        		board.getContent(),
	        		board.getNum()
			};
	        
	        dao.updateData(sql, object);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteBoard(int num) throws Exception {
		String sql;

		try{
			sql = "DELETE FROM bbs WHERE num = " + num;
			dao.deleteData(sql);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
