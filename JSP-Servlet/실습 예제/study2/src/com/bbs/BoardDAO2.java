package com.bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

// ORACLE 11g 방식
public class BoardDAO2 {
	private Connection conn = DBConn.getConnection();

	public int insertBoard(BoardDTO dto) throws Exception {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO bbs(num, name, pwd, subject, content, ipAddr) VALUES (bbs_seq.NEXTVAL,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getIpAddr());

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}

		return result;
	}

	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*),0) FROM bbs";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1); // 첫번째 컬럼의 값
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		return result;
	}

	public List<BoardDTO> listBoard(int start, int end) {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append(" SELECT * FROM(");
			sb.append("  SELECT ROWNUM rnum, tb.*FROM (");
			sb.append("    SELECT num, name, subject, hitCount,");
			sb.append("       TO_CHAR(created, 'YYYY-MM-DD') created");
			sb.append("    FROM bbs");
			sb.append("    ORDER BY num DESC");
			sb.append("  )tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2,  start);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}

		return list;
	}
	
	// 검색 모드에서 전체의 개수 구하기
    public int dataCount(String condition, String keyword) {
        int result=0;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        String sql;

        try {
        	if(condition.equalsIgnoreCase("created")) {
        		keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
        		sql="SELECT NVL(COUNT(*), 0) FROM bbs WHERE TO_CHAR(created, 'YYYYMMDD') = ?  ";
        	} else if(condition.equalsIgnoreCase("name")) {
        		sql="SELECT NVL(COUNT(*), 0) FROM bbs WHERE INSTR(name, ? ) = 1 ";
        	} else {
        		sql="SELECT NVL(COUNT(*), 0) FROM bbs WHERE INSTR(" + condition + ", ? ) >= 1 ";
        	}
        	
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, keyword);

            rs=pstmt.executeQuery();

            if(rs.next())
                result=rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {
				try	{
					rs.close();
				}catch (Exception e2){
				}
			}
			if(pstmt!=null) {
				try	{
					pstmt.close();
				}catch (Exception e2){
				}
			}
		}

        return result;
    }

    // 검색에서 리스트
    public List<BoardDTO> listBoard(int start, int end, String condition, String keyword) {
        List<BoardDTO> list=new ArrayList<BoardDTO>();

        PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuilder sb = new StringBuilder();

        try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("        SELECT num, name, subject, hitCount");
			sb.append("            ,TO_CHAR(created, 'YYYY-MM-DD') created");
			sb.append("         FROM bbs");
			if(condition.equalsIgnoreCase("created"))
				sb.append("           WHERE TO_CHAR(created, 'YYYY-MM-DD') = ? ");
			else if(condition.equalsIgnoreCase("name"))
				sb.append("           WHERE INSTR(name, ?) = 1 ");
			else
				sb.append("           WHERE INSTR(" + condition + ", ?) >= 1 ");
			sb.append("	       ORDER BY num DESC");
			sb.append("    ) tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");
            
			pstmt=conn.prepareStatement(sb.toString());
            
			pstmt.setString(1, keyword);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
            
            rs=pstmt.executeQuery();
            
            while(rs.next()) {
                BoardDTO dto=new BoardDTO();
                dto.setNum(rs.getInt("num"));
                dto.setName(rs.getString("name"));
                dto.setSubject(rs.getString("subject"));
                dto.setHitCount(rs.getInt("hitCount"));
                dto.setCreated(rs.getString("created"));
            
                list.add(dto);
            }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {
				try	{
					rs.close();
				}catch (Exception e2){
				}
			}
			if(pstmt!=null) {
				try	{
					pstmt.close();
				}catch (Exception e2){
				}
			}
		}

        return list;
    }
    
    // 글보기
    public BoardDTO readBoard(int num) {
        BoardDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql = "SELECT num, subject, name, content, pwd, hitCount, created, ipAddr FROM bbs WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPwd(rs.getString("pwd"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				dto.setIpAddr(rs.getString("ipAddr"));
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}

        return dto;
    }
    
    // 조회수
	public int updateHitCount(int num) throws Exception {
		int result=0;
		PreparedStatement pstmt=null;
		String sql;

		try {
			sql = "UPDATE bbs SET hitCount=hitCount+1 WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return result;
	}

    // 이전글
    public BoardDTO preReadBoard(int num, String condition, String keyword) {
        BoardDTO dto=null;

        PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuilder sb = new StringBuilder();

        try {
            if(keyword!=null && keyword.length() != 0) {		// 검색 한 경우
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT num, subject FROM bbs ");
                if(condition.equalsIgnoreCase("created"))
                	sb.append("     WHERE (TO_CHAR(created, 'YYYY-MM-DD') = ?) ");
    			else if(condition.equalsIgnoreCase("name"))
    				sb.append("      WHERE (INSTR(name, ?) = 1) ");
    			else
    				sb.append("      WHERE (INSTR(" + condition + ", ?) >= 1) ");
                sb.append("         AND (num > ? ) ");
                sb.append("         ORDER BY num ASC ");
                sb.append("      ) tb WHERE ROWNUM=1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setString(1, keyword);
                pstmt.setInt(2, num);
			} else {											// 일반 			
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT num, subject FROM bbs ");
                sb.append("     WHERE num > ? ");
                sb.append("         ORDER BY num ASC ");
                sb.append("      ) tb WHERE ROWNUM=1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setInt(1, num);
			}

            rs=pstmt.executeQuery();

            if(rs.next()) {
                dto=new BoardDTO();
                dto.setNum(rs.getInt("num"));
                dto.setSubject(rs.getString("subject"));
            }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {
				try	{
					rs.close();
				}catch (Exception e2){
				}
			}
			if(pstmt!=null) {
				try	{
					pstmt.close();
				}catch (Exception e2){
				}
			}
		}
    
        return dto;
    }

    // 다음글
    public BoardDTO nextReadBoard(int num, String condition, String keyword) {
        BoardDTO dto=null;

        PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuilder sb = new StringBuilder();

        try {
            if(keyword!=null && keyword.length() != 0) {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT num, subject FROM bbs ");
                if(condition.equalsIgnoreCase("created"))
                	sb.append("     WHERE (TO_CHAR(created, 'YYYY-MM-DD') = ?) ");
    			else if(condition.equalsIgnoreCase("name"))
    				sb.append("     WHERE (INSTR(name, ?) = 1) ");
    			else
    				sb.append("     WHERE (INSTR(" + condition + ", ?) >= 1) ");
                sb.append("         AND (num < ? ) ");
                sb.append("         ORDER BY num DESC ");
                sb.append("      ) tb WHERE ROWNUM=1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setString(1, keyword);
                pstmt.setInt(2, num);
			} else {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT num, subject FROM bbs ");
                sb.append("     WHERE num < ? ");
                sb.append("         ORDER BY num DESC ");
                sb.append("      ) tb WHERE ROWNUM=1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setInt(1, num);
            }

            rs=pstmt.executeQuery();

            if(rs.next()) {
                dto=new BoardDTO();
                dto.setNum(rs.getInt("num"));
                dto.setSubject(rs.getString("subject"));
            }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {
				try	{
					rs.close();
				}catch (Exception e2){
				}
			}
			if(pstmt!=null) {
				try	{
					pstmt.close();
				}catch (Exception e2){
				}
			}
		}

        return dto;
    }
    
	public int updateBoard(BoardDTO dto) throws Exception {
		int result=0;
		PreparedStatement pstmt=null;
		String sql;

		try {
			sql = "UPDATE bbs SET name=?, subject=?, content=?, pwd=? WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPwd());
			pstmt.setInt(5, dto.getNum());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return result;
	}
    
	public int deleteBoard(int num) throws Exception {
		int result=0;
		PreparedStatement pstmt=null;
		String sql;

		try {
			sql = "DELETE FROM bbs WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return result;
	}
}
