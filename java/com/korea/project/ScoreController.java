package com.korea.project;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.ScoreDAO;
import vo.ScoreVO;

@Controller
public class ScoreController {
	
	@Autowired
	HttpServletRequest request;
	
	ScoreDAO scoreDao;
	
	public ScoreController(ScoreDAO scoreDao) {
		this.scoreDao = scoreDao;
	}
	
	//별점추가
	@RequestMapping("scoreInsert.do")
	@ResponseBody
	public String scoreInsert(ScoreVO vo) {
		//유저의 idx와 영화 제목이 겹치는
		//별점이 존재하면 추가하지 않는다
		ScoreVO baseVo = scoreDao.scoreCheck(vo);
		String result = "no";
		if(baseVo == null) {
			//유저의 idx와 영화 제목이 겹치는
			//별점이 존재하지 않는다면 별점 추가
			int res = scoreDao.scoreInsert(vo);
			if(res == 1) {
				result = "yes";
			}
		}else {
			result = "exist";
		}
		return result;
	}
	
}
