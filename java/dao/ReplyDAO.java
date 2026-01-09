package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.MovieVO;
import vo.ReplyVO;

public class ReplyDAO {
	
	//sqlSession 생성
	SqlSession sqlSession;
	//생성자로 sqlSession 받아오기
	public ReplyDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//댓글추가
	public int replyInsert(ReplyVO vo) {
		int res = sqlSession.insert("reply.insertReply", vo);
		return res;
	}
	
	//댓글 불러오기
	public List<ReplyVO> replyList(String movieName) {
		List<ReplyVO> replyList = sqlSession.selectList("reply.replyList", movieName);
		return replyList;
	}
	
	//평점 삭제
	public int replyDelete(ReplyVO vo) {
		int res = sqlSession.delete("reply.replyDelete", vo);
		return res;
	}
	
}
