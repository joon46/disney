package com.korea.project;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.UserSelectDAO;
import util.Comm;
import vo.UserSelectVO;
import vo.UserVO;

@Controller
public class UserSelectController {
	
	@Autowired
	HttpServletRequest request;
	
	UserSelectDAO userSelectDao;
	
	public UserSelectController(UserSelectDAO userSelectDao) {
		this.userSelectDao = userSelectDao;
	}
	
	//마이페이지 이동
	@RequestMapping("/myPage.do")
	public String myPage(HttpServletRequest request, Model model) {
		//마이페이지에서 세션 받아오기 성공
		HttpSession session = request.getSession();
		UserVO vo = (UserVO)session.getAttribute("login");
		System.out.println("---------------------------------");
		System.out.println("마이페이지 세션 이동 확인용");
		System.out.println(vo.getUserEmail());
		System.out.println(vo.getUserIdx());
		System.out.println("---------------------------------");
		List<UserSelectVO> selectList = userSelectDao.userSelectList(vo.getUserIdx());
		model.addAttribute("vo", vo);
		model.addAttribute("list", selectList);
		return Comm.USERSELECTPATH + "myPage.jsp";
	}
	
	//찜
	@RequestMapping("userSelectInsert.do")
	@ResponseBody
	public String userSelectInsert(UserSelectVO vo) {
		//중복 조회
		UserSelectVO checkVO = userSelectDao.userSelectCheck(vo);
		String result = "a";
		if(checkVO == null) {
			int res = userSelectDao.userSelectInsert(vo);
			result = "no";
			if(res == 1) {
				result = "yes";
			}
		}
		return result;
	}
	
	//찜 목록 삭제
	@RequestMapping("userSelectDelete.do")
	@ResponseBody
	public String userSelectDelete(UserSelectVO vo) {
		int res = userSelectDao.userSelectDelete(vo);
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		return result;
	}
	

}
