package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.ActorVO;

public class ActorDAO {
	
	//sqlSession 생성
	SqlSession sqlSession;
	//생성자로 sqlSession 받아오기
	public ActorDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//배우추가
	public int actorInsert(ActorVO vo) {
		int res = sqlSession.insert("actor.actorInsert", vo);
		return res;
	}
	
	//배우 목록 꺼내오기
	public List<ActorVO> actorList(String movieName){
		List<ActorVO> actorList = sqlSession.selectList("actor.actorList", movieName);
		return actorList;
	}
	
	//배우 변경
	public int actorUpDate(ActorVO vo) {
		int res = sqlSession.insert("actor.actorInsert", vo);
		return res;
	}
	
	//배우 전체삭제
	public int actorDelect(ActorVO vo) {
		int res = sqlSession.delete("actor.actorDelete", vo);
		return res;
	}
	
}
