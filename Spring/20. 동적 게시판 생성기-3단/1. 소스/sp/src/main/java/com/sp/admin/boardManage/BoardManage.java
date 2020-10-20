package com.sp.admin.boardManage;

// ${tableName} : 게시판 테이블명
// ${tableName}_FILE : 파일저장 테이블명
// ${tableName}_REPLY : 리플저장 테이블명

public class BoardManage {
	private int listNum, num;
	private String board, title, icon, info;
	private int updateMembership, answerMembership;
	private String updateMembershipName, answerMembershipName;
	private int notice, attach;
	private int boardLike, replyLike, answer, reply;
	private String created;
	
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getBoard() {
		return board;
	}
	public void setBoard(String board) {
		this.board = board;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public int getUpdateMembership() {
		return updateMembership;
	}
	public void setUpdateMembership(int updateMembership) {
		this.updateMembership = updateMembership;
	}
	public int getAnswerMembership() {
		return answerMembership;
	}
	public void setAnswerMembership(int answerMembership) {
		this.answerMembership = answerMembership;
	}
	public String getUpdateMembershipName() {
		return updateMembershipName;
	}
	public void setUpdateMembershipName(String updateMembershipName) {
		this.updateMembershipName = updateMembershipName;
	}
	public String getAnswerMembershipName() {
		return answerMembershipName;
	}
	public void setAnswerMembershipName(String answerMembershipName) {
		this.answerMembershipName = answerMembershipName;
	}
	public int getNotice() {
		return notice;
	}
	public void setNotice(int notice) {
		this.notice = notice;
	}
	public int getAttach() {
		return attach;
	}
	public void setAttach(int attach) {
		this.attach = attach;
	}
	public int getBoardLike() {
		return boardLike;
	}
	public void setBoardLike(int boardLike) {
		this.boardLike = boardLike;
	}
	public int getReplyLike() {
		return replyLike;
	}
	public void setReplyLike(int replyLike) {
		this.replyLike = replyLike;
	}
	public int getAnswer() {
		return answer;
	}
	public void setAnswer(int answer) {
		this.answer = answer;
	}
	public int getReply() {
		return reply;
	}
	public void setReply(int reply) {
		this.reply = reply;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
}
