package vo;

public class UserSelectVO {
	//찜 목록 테이블
	private int userSelectIdx;	//idx
	private String userIdx;		//유저 테이블에서 끌어올 유저idx
	private String movieName;	//영화 테이블에서 끌어올 영화제목
	
	//getter, setter
	public int getUserSelectIdx() {
		return userSelectIdx;
	}
	public void setUserSelectIdx(int userSelectIdx) {
		this.userSelectIdx = userSelectIdx;
	}
	
	public String getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(String userIdx) {
		this.userIdx = userIdx;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	
	
}
