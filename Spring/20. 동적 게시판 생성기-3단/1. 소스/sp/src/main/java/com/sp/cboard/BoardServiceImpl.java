package com.sp.cboard;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("cboard.boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertBoard(Board dto, String mode, String pathname) throws Exception {
		try {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("tableName", dto.getTableName());

			if(mode.equals("created")) {
				int maxNum=dao.selectOne("cboard.maxNum", map);
				dto.setNum(maxNum+1);
				dto.setGroupNum(dto.getNum());
				
			} else if(mode.equals("answer")) {
				// orderNo 변경
				map.put("tableName", dto.getTableName());
				map.put("groupNum", dto.getGroupNum());
				map.put("orderNo", dto.getOrderNo());
				dao.updateData("cboard.updateOrderNo", map);

				int maxNum=dao.selectOne("cboard.maxNum", map);
				dto.setNum(maxNum+1);
				dto.setDepth(dto.getDepth() + 1);
				dto.setOrderNo(dto.getOrderNo() + 1);
			}
			dao.insertData("cboard.insertBoard", dto);
			
			// 파일 업로드
			if(dto.getUpload()!=null && ! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						
						String originalFilename=mf.getOriginalFilename();
						long fileSize=mf.getSize();
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						dto.setFileSize(fileSize);
						
						insertFile(dto);
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("cboard.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list=null;
		
		try {
			list=dao.selectList("cboard.listBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<Board> listBoardTop(Map<String, Object> map) {
		List<Board> list=null;
		
		try {
			list=dao.selectList("cboard.listBoardTop", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public Board readBoard(Map<String, Object> map) {
		Board dto=null;

		try {
			dto=dao.selectOne("cboard.readBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateHitCount(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("cboard.updateHitCount", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Board preReadBoard(Map<String, Object> map) {
		Board dto=null;

		try {
			dto=dao.selectOne("cboard.preReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		Board dto=null;

		try {
			dto=dao.selectOne("cboard.nextReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateBoard(Board dto, String pathname) throws Exception {
		try {
			dao.updateData("cboard.updateBoard", dto);
			
			if(dto.getUpload()!=null && ! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						String originalFilename=mf.getOriginalFilename();
						long fileSize=mf.getSize();
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						dto.setFileSize(fileSize);
						
						insertFile(dto);
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertBoardLike(Board dto) throws Exception {
		try {
			dao.insertData("cboard.insertBoardLike", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int boardLikeCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("cboard.boardLikeCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public void deleteBoard(Map<String, Object> map) throws Exception {
		try {
			// 댓글, 좋아요/싫어요 는 ON DELETE CASCADE 로 자동 삭제
			
			// 파일 지우기
			String pathname=(String)map.get("pathname");
			
			List<Board> listFile=listFile(map);
			if(listFile!=null) {
				Iterator<Board> it=listFile.iterator();
				while(it.hasNext()) {
					Board dto=it.next();
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			// 파일 테이블 내용 지우기
			map.put("field", "num");
			deleteFile(map);
			
			dao.deleteData("cboard.deleteBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertFile(Board dto) throws Exception {
		try {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("tableName", dto.getTableName());

			int maxFileNum=dao.selectOne("cboard.maxFileNum", map);
			dto.setFileNum(maxFileNum+1);
			
			dao.insertData("cboard.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public List<Board> listFile(Map<String, Object> map) {
		List<Board> listFile=null;
		
		try {
			listFile=dao.selectList("cboard.listFile", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listFile;
	}

	@Override
	public Board readFile(Map<String, Object> map) {
		Board dto=null;
		
		try {
			dto=dao.selectOne("cboard.readFile", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("cboard.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("tableName", dto.getTableName());
			int maxNum=dao.selectOne("cboard.maxReplyNum", map);
			dto.setReplyNum(maxNum+1);
			
			dao.insertData("cboard.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list=null;
		try {
			list=dao.selectList("cboard.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Reply> listReplyAnswer(Map<String, Object> map) {
		List<Reply> list=null;
		try {
			list=dao.selectList("cboard.listReplyAnswer", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int replyAnswerCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("cboard.replyAnswerCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public int replyCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("cboard.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("cboard.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("cboard.insertReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Map<String, Object> replyLikeCount(Map<String, Object> map) {
		Map<String, Object> result=null;
		try {
			result=dao.selectOne("cboard.replyLikeCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
