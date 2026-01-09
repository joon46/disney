package vo;

public class ActorVO {
	//영화의 출연진 정보 테이블
	private int actorIdx;		//idx
	private String movieName;	//영화 테이블에서 가져올 영화제목
	private String actorName;	//배우들 작성
	
	//getter, setter
	public int getActorIdx() {
		return actorIdx;
	}
	public void setActorIdx(int actorIdx) {
		this.actorIdx = actorIdx;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getActorName() {
		return actorName;
	}
	public void setActorName(String actorName) {
		this.actorName = actorName;
	}
	
	
	
}
