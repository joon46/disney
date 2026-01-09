package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.UserSelectVO;

public class UserSelectDAO {
	
	//sqlSession 생성
	SqlSession sqlSession;
	
	//생성자로 sqlSession 받아오기
	public UserSelectDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//찜 전체 조회(사용자의 idx에 맞는 영화만)
	public List<UserSelectVO> userSelectList(int userIdx){
		List<UserSelectVO> returnList = sqlSession.selectList("userSelect.userSelectList", userIdx);
		return returnList;
	}
	
	//찜 추가
	public int userSelectInsert(UserSelectVO vo) {
		int res = sqlSession.insert("userSelect.userSelectInsert", vo);
		return res;
	}
	
	 //유저의 idx와 영화의 제목이 일치하는 항목이 있는지 확인
	public UserSelectVO userSelectCheck(UserSelectVO vo) {
		UserSelectVO userSeleteVO = sqlSession.selectOne("userSelect.userSelectCheck", vo);
		return userSeleteVO;
	}
	
	public int userSelectDelete(UserSelectVO vo) {
		int res = sqlSession.delete("userSelect.userSelectDelete", vo);
		return res;
	}
	
}
