package com.sp.nbbs;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("nbbs.boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	private CommonDAO  dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertBoard(Board dto, String pathname) throws Exception {
		try{
			if(dto.getUpload()!=null && ! dto.getUpload().isEmpty()) {
				String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			
			dao.insertData("nbbs.insertBoard", dto);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list=null;
		
		try{
			list=dao.selectList("nbbs.listBoard", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try{
			result=dao.selectOne("nbbs.dataCount", map);			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public Board readBoard(int num) {
		Board dto=null;
		
		try{
			// 게시물 가져오기
			dto=dao.selectOne("nbbs.readBoard", num);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try{
			dao.updateData("nbbs.updateHitCount", num);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Board preReadBoard(Map<String, Object> map) {
		Board dto=null;
		
		try{
			dto=dao.selectOne("nbbs.preReadBoard", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		Board dto=null;
		
		try{
			dto=dao.selectOne("nbbs.nextReadBoard", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateBoard(Board dto, String pathname) throws Exception {
		try{
			if(dto.getUpload()!=null && !dto.getUpload().isEmpty()) {
				// 이전파일 지우기
				if(dto.getSaveFilename().length()!=0)
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				
				String newFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
				if (newFilename != null) {
					dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
					dto.setSaveFilename(newFilename);
				}
			}
			
			dao.updateData("nbbs.updateBoard", dto);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteBoard(int num, String pathname) throws Exception {
		try{
			Board dto = readBoard(num);
			if(dto!=null) {
				if(dto.getSaveFilename() != null ) {
				  fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			
				dao.deleteData("nbbs.deleteBoard", num);
			}
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteFile(int num, String pathname) throws Exception {
		Board dto=null;
		try {
			dto = readBoard(num);
			if(dto==null) {
				return;
			}
			
			if(dto.getSaveFilename()!=null) {
				fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				
				dto.setSaveFilename("");
				dto.setOriginalFilename("");
				
				updateBoard(dto, pathname);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
