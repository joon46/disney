package vo;

public class ScoreVO {
	//영화 별점 테이블
	private int scoreIdx;		//별점 idx
	private String userIdx;		//유저 테이블에서 끌어올 유저아이디
	private String movieName;	//영화 테이블에서 끌어올 영화제목
	private int starScore;		//별점을 정하는 점수(1~5까지 1점당 별한개)
	
	//getter, setter
	public int getScoreIdx() {
		return scoreIdx;
	}
	public void setScoreIdx(int scoreIdx) {
		this.scoreIdx = scoreIdx;
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
	public int getStarScore() {
		return starScore;
	}
	public void setStarScore(int starScore) {
		this.starScore = starScore;
	}
	
	
	
}
