package dao;


import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.MovieVO;

public class MovieDAO {
	//sqlSession 생성
	SqlSession sqlSession;
	//생성자로 sqlSession 받아오기
	public MovieDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//영화 추가하기
	public int movieInsert(MovieVO vo) {
		int res = sqlSession.insert("movie.movieInsert", vo);
		return res;
	}
	
	//영화 조회순으로 정렬후 전체 영화 가져오기
	public List<MovieVO> movieList(){
		List<MovieVO> list = sqlSession.selectList("movie.movieList");
		return list;
	}
	
	//영화 제목으로 영화 정보 끌어오기
	public List<MovieVO> movieList(List<String> movieNameList){
		List<MovieVO> movieList = new ArrayList<MovieVO>();
		for(int i = 0; i < movieNameList.size(); i++) {
			MovieVO vo = sqlSession.selectOne("movie.movieSelectList", movieNameList.get(i));
			movieList.add(vo);
		}
		return movieList;
	}
	
	//영화 정보 가져오기
	public MovieVO movieAbout(int movieIdx) {
		MovieVO movieVO = sqlSession.selectOne("movie.movieAbout", movieIdx);
		return movieVO;
	}
	
	//영화 조회수증가
	public int movieHitUpDate(int movieIdx) {
		int res = sqlSession.update("movieHitUpDate", movieIdx);
		return res;
	}
	
	//영화 업데이트
	public int movieUpDate(MovieVO vo) {
		int res = sqlSession.update("movie.movieUpDate", vo);
		return res;
	}
	
	//영화 삭제
	public int movieDelete(MovieVO vo) {
		int res = sqlSession.delete("movie.movieDelete", vo);
		return res;
	}
	
}
