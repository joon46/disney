package com.korea.project;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.ActorDAO;
import vo.ActorVO;

@Controller
public class ActorController {
	
	@Autowired
	HttpServletRequest request;
	
	ActorDAO actorDao;
	
	public ActorController(ActorDAO actorDao) {
		this.actorDao = actorDao;
	}
	
	//영화배우 추가
	@RequestMapping("actorInsert.do")
	@ResponseBody
	public String actorInsert(ActorVO vo) {
		int res = actorDao.actorInsert(vo);
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		return result;
	}
	
}
