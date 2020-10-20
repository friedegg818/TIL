package com.sp.admin.boardManage;

import java.util.List;

import com.sp.member.Member;

public interface BoardManageService {
	public void createBoardManage(BoardManage dto) throws Exception;
	
	public int dataCount();
	public List<BoardManage> listBoardManage();
	public List<Member> listMemberRole();
	
	public BoardManage readBoardManage(int num);
	public BoardManage readBoardManage(String board);
	
	public void updateBoardManage(BoardManage dto, String pathname) throws Exception;
	public void deleteBoardManage(int num, String pathname) throws Exception;
}
