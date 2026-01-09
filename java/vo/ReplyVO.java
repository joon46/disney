package vo;

public class ReplyVO {
	//유저 댓글 테이블
	private int replyIdx;			//idx
	private String movieName;		//영화 테이블에서 끌어올 영화제목
	private String replyComment;	//댓글 내용
	private String userIdx;			//유저 테이블에서 끌어올 유저아이디
	private String replyDate;		//댓글 작성 시간
	
	//getter, setter
	public int getReplyIdx() {
		return replyIdx;
	}
	public void setReplyIdx(int replyIdx) {
		this.replyIdx = replyIdx;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getReplyComment() {
		return replyComment;
	}
	public void setReplyComment(String replyComment) {
		this.replyComment = replyComment;
	}
	public String getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(String userIdx) {
		this.userIdx = userIdx;
	}
	public String getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(String replyDate) {
		this.replyDate = replyDate;
	}
	
	
}
