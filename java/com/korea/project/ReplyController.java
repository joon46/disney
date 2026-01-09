package com.korea.project;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.ReplyDAO;
import vo.ReplyVO;

@Controller
public class ReplyController {
	
	@Autowired
	HttpServletRequest request;
	
	ReplyDAO replyDao;
	
	public ReplyController(ReplyDAO replyDao) {
		this.replyDao = replyDao;
	}
	
	//평점 추가
	@RequestMapping("replyInsert.do")
	@ResponseBody
	public String replyInsert(ReplyVO vo) {	
		int res = replyDao.replyInsert(vo);
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		return result;
	}
	
	//평점 삭제
	@RequestMapping("replyDelete.do")
	@ResponseBody
	public String replyDelete(ReplyVO vo) {
		int res = replyDao.replyDelete(vo);
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		return result;
	}
	
	
	
	
}
