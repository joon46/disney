package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.ScoreVO;

public class ScoreDAO {
	
	//sqlSession 생성
	SqlSession sqlSession;
	//생성자로 sqlSession 받아오기
	public ScoreDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//별점 추가
	public int scoreInsert(ScoreVO vo) {
		int res = sqlSession.insert("score.scoreInsert",vo);
		return res;
	}
	
	//별점 검사
	public ScoreVO scoreCheck(ScoreVO vo) {
		ScoreVO b_vo = sqlSession.selectOne("score.scoreCheck", vo);
		return b_vo;
	}
	
	//영화 제목에 맞는 별점리스트
	public List<ScoreVO> scoreList(String movieName){
		List<ScoreVO> scoreList = sqlSession.selectList("score.scoreList", movieName);
		return scoreList;
	}
	
}
