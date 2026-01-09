package com.korea.project;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.ActorDAO;
import dao.MovieDAO;
import dao.ReplyDAO;
import dao.ScoreDAO;
import dao.UserDAO;
import dao.UserSelectDAO;
import util.Comm;
import vo.ActorVO;
import vo.MovieVO;
import vo.ReplyVO;
import vo.ScoreVO;
import vo.UserSelectVO;
import vo.UserVO;

@Controller
public class MovieController {
	
	@Autowired
	HttpServletRequest request;
	
	//세션 불러오기
	HttpSession session;
	
	//DAO생성
	MovieDAO movieDao;
	UserDAO userDao;
	UserSelectDAO userSelectDao;
	ReplyDAO replyDao;
	ActorDAO actorDao;
	ScoreDAO scoreDao;
	
	//DAO생성자로 받아오기
	public MovieController(MovieDAO movieDao, UserDAO userDao, UserSelectDAO userSelectDao, ReplyDAO replyDao, ActorDAO actorDao, ScoreDAO scoreDao) {
		this.movieDao = movieDao;
		this.userDao = userDao;
		this.userSelectDao = userSelectDao;
		this.replyDao = replyDao;
		this.actorDao = actorDao;
		this.scoreDao = scoreDao;
	}
		
	//로그인 전 화면
	@RequestMapping(value = {"/", "beforeLogin.do"})
	public String main() {
		return Comm.MOVIEPATH + "beforeLogin.jsp";
	}

	//로그인 후 화면
	@RequestMapping(value = {"afterLogin.do"})
	public String Main(Model model) {
		//영화 조회수 세션 삭제
		//다시 movie.jsp로 들어갈때 조회수가 증가하게 초기화
		session = request.getSession();
		session.removeAttribute("s");
		
		//유저 로그인 세션 받아오기
		HttpSession session = request.getSession();
		UserVO vo = (UserVO)session.getAttribute("login");
		
		//리스트로 영화 받아오기(조회순 정렬)
		List<MovieVO> hitList = movieDao.movieList();
		int hitListSize = hitList.size();
		int movieListSize = 0;
		if(hitListSize % 6 == 0) {
			movieListSize = hitListSize / 6;
		}else {
			movieListSize = (hitListSize / 6) + 1;
		}
		for(int i = 1; i <= movieListSize; i++) {
			int begin = 0;
			int end = 5;
			int j = (i - 1) * 6;
			model.addAttribute("begin", begin + j);
			model.addAttribute("end", end + j);
		}
		System.out.println(movieListSize);
		model.addAttribute("movieListSize", movieListSize);
		model.addAttribute("movieHit", hitList);
		
		//유저 idx로 찜 목록 받아오기
		List<UserSelectVO> selectList = userSelectDao.userSelectList(vo.getUserIdx());
		
		//영화 제목 받아오는 리스트 생성
		List<String> movieNameList = new ArrayList<String>();
		
		//리스트안에 있는 영화제목들을 영화제목리스트에 넣어준다.
		for(int i = 0; i < selectList.size(); i++) {
			movieNameList.add(selectList.get(i).getMovieName());
		}
		
		//movie테이블 끌어오기
		List<MovieVO> movieSelectList = movieDao.movieList(movieNameList);
		//모델객체에 바인딩
		model.addAttribute("movieSelect", movieSelectList);
		//로그인 이후 페이지로 이동
		return Comm.MOVIEPATH + "afterLogin.jsp";
	}
	
	//영화 화면 설정
	@RequestMapping("movie.do")
	public String movie(HttpServletRequest request, Model model, MovieVO movieVo) {
		//세션 받아오기
		HttpSession session = request.getSession();
		UserVO vo = (UserVO)session.getAttribute("login");
		
		//영화 정보가져오기
		MovieVO baseVO = movieDao.movieAbout(movieVo.getMovieIdx());
		//영화 시청횟수 증가를 위해 세션에 값을 저장
		session = request.getSession();
		String show = (String)session.getAttribute("s");
		//세션값이 없다면 세션에 값을 저장
		if(show == null) {
			int res = movieDao.movieHitUpDate(baseVO.getMovieIdx());
			session.setAttribute("s", "check");
		}
		
		//댓글 목록 가져오기
		List<ReplyVO> list = replyDao.replyList(baseVO.getMovieName());
		//배우 목록 가져오기
		List<ActorVO> actorList = actorDao.actorList(baseVO.getMovieName());
		//별점 목록 가져오기
		List<ScoreVO> scoreList = scoreDao.scoreList(baseVO.getMovieName());
		//별점 총점 변수
		double totalScore = 0;
		//별점 평균 점수
		double avgScore = 0;
		//별점 리스트가 비어있지않으면
		//별점 리스트의 별점들을 총점에 더해준다.
		//이후 평균 점수로 나눠서 movie.jsp로 보내줌
		if(scoreList != null) {
			for(int i = 0; i < scoreList.size(); i++) {
				totalScore += scoreList.get(i).getStarScore();
			}
			avgScore = totalScore / scoreList.size();
		}
		
		//모델 객체에 바인딩
		model.addAttribute("movieOne", baseVO);
		model.addAttribute("user", vo);
		model.addAttribute("list", list);
		model.addAttribute("actors", actorList);
		model.addAttribute("avgScore", avgScore);
		//영화 페이지로 이동
		return Comm.MOVIEPATH + "movie.jsp";
	}
	
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//관리자 관련 코드	
	
	//매니저 확인
	@RequestMapping("managerPage.do")
	public String managerPage() {
		//세션 받아오기
		HttpSession session = request.getSession();
		UserVO vo = (UserVO)session.getAttribute("login");
		return Comm.MOVIEPATH + "managerPage.jsp";	
	}
	
	//영화 추가 페이지
	@RequestMapping("movieInsertForm.do")
	public String movieInsertForm() {
		return Comm.MOVIEPATH + "insertMovie.jsp";
	}
	
	//영화 추가하기
	@RequestMapping("movieInsert.do")
	@ResponseBody
	public String movieInsert(MovieVO vo) {
		int res = movieDao.movieInsert(vo);
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		return result;
	}
	
	//영화 리스트 페이지
	@RequestMapping("movieUpDateForm.do")
	public String movieUpDateForm(Model model) {
		List<MovieVO> movieList = movieDao.movieList();
		model.addAttribute("movieList", movieList);
		return Comm.MOVIEPATH + "upDateListMovie.jsp";
	}
	
	//영화변경 페이지
	@RequestMapping("movieUpDate.do")
	public String movieUpDate(MovieVO vo, Model model) {
		//영화 정보 끌어오기
		MovieVO movieVo = movieDao.movieAbout(vo.getMovieIdx());
		List<ActorVO> actorList = actorDao.actorList(vo.getMovieName());
		model.addAttribute("movie", movieVo);
		model.addAttribute("actorList", actorList);
		return Comm.MOVIEPATH + "updateMovie.jsp";
	}
	
	//영화 수정
	@RequestMapping("movieUpDateMethod.do")
	@ResponseBody
	public String movieUpDate(MovieVO vo) {
		int res = movieDao.movieUpDate(vo);
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		return result;
	}
	//영화 삭제
	@RequestMapping("movieDelete.do")
	@ResponseBody
	public String movieDelete(MovieVO vo) {
		int res = movieDao.movieDelete(vo);
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		return result;
	}
	
	//배우수정
	@RequestMapping("actorUpDate.do")
	@ResponseBody
	public String actorUpDate(ActorVO vo) {
		int res = actorDao.actorUpDate(vo);
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		return result;
	}
	//배우삭제
	@RequestMapping("actorDelete.do")
	@ResponseBody
	public String actorDelete(ActorVO vo) {
		int res = actorDao.actorDelect(vo);
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		return result;
	}
	
	//사용자 조회 페이지
	@RequestMapping("userAboutForm.do")
	public String userAboutForm() {
		List<UserVO> list = userDao.userList();
		request.setAttribute("list", list);
		return Comm.MOVIEPATH + "selectUsers.jsp";
	}
	
	
	
	
	
	
	
	
}
