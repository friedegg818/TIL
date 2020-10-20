package com.sp.admin.boardManage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;
import com.sp.member.Member;

@Service("boardManage.boardManageService")
public class BoardManageServiceImpl implements BoardManageService {
	@Autowired
	private CommonDAO  dao;
	@Autowired
	private FileManager fileManager;

	@Override
	public void createBoardManage(BoardManage dto) throws Exception {
		try{
			// 테이블 만들기
			dao.updateData("boardManage.createBoardTable", dto.getBoard());
			dao.updateData("boardManage.createBoardFileTable", dto.getBoard());
			dao.updateData("boardManage.createBoardLikeTable", dto.getBoard());
			dao.updateData("boardManage.createBoardReplyTable", dto.getBoard());
			dao.updateData("boardManage.createBoardReplyLikeTable", dto.getBoard());
			
			dao.insertData("boardManage.insertBoardManage", dto);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount() {
		int result=0;
		
		try{
			result=dao.selectOne("boardManage.dataCount");			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<BoardManage> listBoardManage() {
		List<BoardManage> list=null;
		
		try{
			list=dao.selectList("boardManage.listBoardManage");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public BoardManage readBoardManage(int num) {
		BoardManage dto=null;
		try {
			dto=dao.selectOne("boardManage.readBoardManage1", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public BoardManage readBoardManage(String board) {
		BoardManage dto=null;
		try {
			dto=dao.selectOne("boardManage.readBoardManage2", board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public void updateBoardManage(BoardManage dto, String pathname) throws Exception {
		try{
			if(dto.getAttach()==0) { // 첨부파일이 없는 경우
				// 업로드된 파일지우기
				List<BoardFile> listFile=dao.selectList("boardManage.listBoardFile1", dto.getBoard());
				for(BoardFile vo:listFile) {
					fileManager.doFileDelete(vo.getSaveFilename(), pathname);
				}
				
				// 파일 테이블 내용 지우기
				dao.deleteData("boardManage.deleteBoardFile1", dto.getBoard());
			}
			
			if(dto.getBoardLike()==0) { // 게시물 좋아요가 불가능한경우
				// 게시물 좋아요 테이블 내용 지우기
				dao.deleteData("boardManage.deleteBoardLike", dto.getBoard());
			}

			if(dto.getReply()==0) { // 댓글형이 아닌 경우
				// 리플 좋아요 테이블 내용 지우기
				dao.deleteData("boardManage.deleteBoardReplyLike", dto.getBoard());
				
				// 리플 테이블 내용 지우기
				dao.deleteData("boardManage.deleteBoardReply", dto.getBoard());
			}
			
			if(dto.getReplyLike()==0) { // 리플 좋아요가 불가능한경우
				// 게시물 좋아요 테이블 내용 지우기
				dao.deleteData("boardManage.deleteBoardReplyLike", dto.getBoard());
			}
			
			if(dto.getAnswer()==0) { // 답변형이 아닌 경우
				// 답변 파일 지우기
				List<BoardFile> listFile=dao.selectList("boardManage.listBoardFile2", dto.getBoard());
				for(BoardFile vo:listFile) {
					fileManager.doFileDelete(vo.getSaveFilename(), pathname);
				}
				
				// 파일 테이블 내용 지우기
				dao.deleteData("boardManage.deleteBoardFile2", dto.getBoard());
				
				// 답변 지우기
				dao.deleteData("boardManage.deleteBoardAnswer", dto.getBoard());
			}
			
			dao.updateData("boardManage.updateBoardManage", dto);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteBoardManage(int num, String pathname) throws Exception {
		try{
			BoardManage dto=readBoardManage(num);
			
			dao.deleteData("boardManage.deleteBoardManage", num);
			
			if(dto!=null) {
				// 업로드된 파일지우기
				List<BoardFile> listFile=dao.selectList("boardManage.listBoardFile1", dto.getBoard());
				for(BoardFile vo:listFile) {
					fileManager.doFileDelete(vo.getSaveFilename(), pathname);
				}
				
				// 테이블 drop
				dao.updateData("boardManage.dropBoardFileTable", dto.getBoard());
				dao.updateData("boardManage.dropBoardReplyLikeTable", dto.getBoard());
				dao.updateData("boardManage.dropBoardReplyTable", dto.getBoard());
				dao.updateData("boardManage.dropBoardLikeTable", dto.getBoard());
				dao.updateData("boardManage.dropBoardTable", dto.getBoard());
			}
					
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Member> listMemberRole() {
		List<Member> list=null;
		
		try{
			list=dao.selectList("member.listMemberRole");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

}
