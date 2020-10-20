package com.sp.cboard;

import java.util.List;
import java.util.Map;

public interface BoardService {
	public void insertBoard(Board dto, String mode, String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Board> listBoard(Map<String, Object> map);
	public List<Board> listBoardTop(Map<String, Object> map);
	
	public void updateHitCount(Map<String, Object> map) throws Exception;
	public Board readBoard(Map<String, Object> map);
	public Board preReadBoard(Map<String, Object> map);
	public Board nextReadBoard(Map<String, Object> map);
	
	public void updateBoard(Board dto, String pathname) throws Exception;
	public void deleteBoard(Map<String, Object> map) throws Exception;
	
	public void insertBoardLike(Board dto) throws Exception;
	public int boardLikeCount(Map<String, Object> map);
	
	public void insertFile(Board dto) throws Exception;
	public List<Board> listFile(Map<String, Object> map);
	public Board readFile(Map<String, Object> map);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
	public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public List<Reply> listReplyAnswer(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public int replyAnswerCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;

	public void insertReplyLike(Map<String, Object> map) throws Exception;
	public Map<String, Object> replyLikeCount(Map<String, Object> map);
}
