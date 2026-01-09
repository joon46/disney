package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.UserVO;

public class UserDAO {
	//sqlSession 생성
	SqlSession sqlSession;
	//생성자로 sqlSession 받아오기
	public UserDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//회원가입
	public int signUp(UserVO vo) {
		int res = sqlSession.insert("user.signUp", vo);
		return res;
	}
	
	//로그인을 위한 id찾아오기
	public UserVO userIdCheck(UserVO vo) {
		UserVO userVO = sqlSession.selectOne("user.userIdCheck", vo.getUserId());
		return userVO;
	}
	
	//로그인을 위한 pw찾아오기
	public UserVO userPwCheck(UserVO vo) {
		UserVO userVO = sqlSession.selectOne("user.userPwCheck", vo.getUserPw());
		return userVO;
	}
	
	//id검사
	public UserVO userIdCheck(String userId) {
		UserVO userVO = sqlSession.selectOne("user.userIdCheck", userId);
		return userVO;
	}
	
	//이메일 검사
	public UserVO userEmailCheck(String userEmail) {
		UserVO userVO = sqlSession.selectOne("user.userEmailCheck", userEmail);
		return userVO;
	}
	
	//전화번호 검사
	public UserVO userPhoneNumCheck(String userPhoneNum) {
		UserVO userVO = sqlSession.selectOne("user.userPhoneNumCheck", userPhoneNum);
		return userVO;
	}
	
	//닉네임 검사
	public UserVO userNickNameCheck(String userNickName) {
		UserVO userVO = sqlSession.selectOne("user.userNickNameCheck", userNickName);
		return userVO;
	}
	
	//카카오 로그인
	public UserVO kakaoLogin(String userEmail) {
		UserVO userVO = sqlSession.selectOne("user.kakaoLogin", userEmail);
		return userVO;
	}
	
	//카카오 회원가입
	public int kakaoSignUp(UserVO vo) {
		int res = sqlSession.insert("user.kakaoSignUp", vo);
		return res;
	}
	
	//네이버 로그인
	public UserVO naverLogin(String userEmail) {
		UserVO userVO = sqlSession.selectOne("user.naverLogin", userEmail);
		return userVO;
	}
	
	//네이버 회원가입
	public int naverSignUp(UserVO vo) {
		int res = sqlSession.insert("user.naverSignUp", vo);
		return res;
	}
	
	//비밀번호 변경
	public int userPwUpDate(UserVO vo) {
		int res = sqlSession.update("user.userPwUpDate", vo);
		return res;
	}
	
	//닉네임 변경
	public int userNickNameUpDate(UserVO vo) {
		int res = sqlSession.update("user.userNickNameUpDate", vo);
		return res;
	}
	
	//이메일 변경
	public int userEmailUpDate(UserVO vo) {
		int res = sqlSession.update("user.userEmailUpDate", vo);
		return res;
	}
	
	//전화번호 변경
	public int userPhoneNumUpDate(UserVO vo) {
		int res = sqlSession.update("user.userPhoneNumUpDate", vo);
		return res;
	}
	
	//전체 유저 조회
	public List<UserVO> userList(){
		List<UserVO> userList = sqlSession.selectList("user.userList");
		return userList;
	}
	
}