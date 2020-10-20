package com.score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

// CRUD : Create(insert), Retrieve(select), Update, Delete
public class ScoreDAO {
	private Connection conn = DBConn.getConnection();

	public int insertScore(ScoreDTO dto) throws Exception {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO score(hak,name,birth,kor,eng,mat) VALUES (?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getHak());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getBirth());
			pstmt.setInt(4, dto.getKor());
			pstmt.setInt(5, dto.getEng());
			pstmt.setInt(6, dto.getMat());

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

	public List<ScoreDTO> listScore() {
		List<ScoreDTO> list = new ArrayList<ScoreDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append("SELECT hak, name, birth, kor, eng, mat,");
			sb.append(" (kor+eng+mat)tot, (kor+eng+mat)/3 ave,");
			sb.append(" RANK() OVER(ORDER BY(kor+eng+mat) DESC) rank");
			sb.append(" FROM score");

			pstmt = conn.prepareStatement(sb.toString());

			rs = pstmt.executeQuery();
			while (rs.next()) {
				ScoreDTO dto = new ScoreDTO();
				dto.setHak(rs.getString("hak"));
				dto.setName(rs.getString("name"));
				dto.setBirth(rs.getDate("birth").toString());
				dto.setKor(rs.getInt("kor"));
				dto.setEng(rs.getInt("eng"));
				dto.setMat(rs.getInt("mat"));
				dto.setTot(rs.getInt("tot"));
				dto.setAve(rs.getInt("ave"));
				dto.setRank(rs.getInt("rank"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		return list;
	}

	public int deleteScore(String hak) throws Exception {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "DELETE FROM score WHERE hak=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hak);
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

	public ScoreDTO readScore(String hak) {
		ScoreDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT hak, name, birth, kor, eng, mat FROM score WHERE hak=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hak);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new ScoreDTO();
				dto.setHak(rs.getString("hak"));
				dto.setName(rs.getString("name"));
				dto.setBirth(rs.getDate("birth").toString());
				dto.setKor(rs.getInt("kor"));
				dto.setEng(rs.getInt("eng"));
				dto.setMat(rs.getInt("mat"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		return dto;
	}

	public int updateScore(ScoreDTO dto) throws Exception {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		try {
			sql = "UPDATE SCORE SET name=?, birth=?, kor=?, eng=?, mat=? WHERE hak=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getBirth());
			pstmt.setInt(3, dto.getKor());
			pstmt.setInt(4, dto.getEng());
			pstmt.setInt(5, dto.getMat());
			pstmt.setString(6, dto.getHak());			
			
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
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
	
	public int deleteList (String[] hak) {
		int result = 0;
		PreparedStatement pstmt = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append("DELETE FROM score WHERE hak IN ( ");
			for(int i=1; i<=hak.length; i++) {
				sb.append("?");				
				if(i==hak.length) {
					sb.append(")"); break;
				}					
				sb.append(", ");
			}
			pstmt = conn.prepareStatement(sb.toString());				
			
			for(int i=1; i<=hak.length; i++) {				
				pstmt.setString(i, hak[i-1]);			
			}			
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();		
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

}
