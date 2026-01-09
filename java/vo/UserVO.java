package vo;

public class UserVO {
	//유저 정보 테이블
	private int userIdx;					//PK
	private String userId;					//사용자 id
	private String userPw;					//사용자 비밀번
	private String userName;				//사용자 이름
	private String userPhoneNum;			//사용자 핸드폰 번호
	private String userEmail;				//사용자 이메일
	private String userRegDate;				//사용자 가입 날짜
	private String userBirthDate;			//사용자 생년월일
	private String userNickName;			//사용자 닉네임
	private int userAge;					//사용자 나이
	private String userMemberShip;			//유저 멤버십
	
	
	//getter, setter
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPhoneNum() {
		return userPhoneNum;
	}
	public void setUserPhoneNum(String userPhoneNum) {
		this.userPhoneNum = userPhoneNum;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserRegDate() {
		return userRegDate;
	}
	public void setUserRegDate(String userRegDate) {
		this.userRegDate = userRegDate;
	}
	public String getUserBirthDate() {
		return userBirthDate;
	}
	public void setUserBirthDate(String userBirthDate) {
		this.userBirthDate = userBirthDate;
	}

	public String getUserNickName() {
		return userNickName;
	}
	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}
	public int getUserAge() {
		return userAge;
	}
	public void setUserAge(int userAge) {
		this.userAge = userAge;
	}
	public String getUserMemberShip() {
		return userMemberShip;
	}
	public void setUserMemberShip(String userMemberShip) {
		this.userMemberShip = userMemberShip;
	}
	
	
	
}

