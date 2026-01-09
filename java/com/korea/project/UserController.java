package com.korea.project;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.UserDAO;
import util.Comm;
import vo.UserVO;

@Controller
public class UserController {

	@Autowired
	HttpServletRequest request;

	UserDAO userDao;

	// 로그인 이후 세션 저장
	HttpSession session;

	public UserController(UserDAO userDao) {
		this.userDao = userDao;
	}

	// 로그인 페이지로 이동
	@RequestMapping(value = { "/loginForm.do" })
	public String loginForm() {
		return Comm.USERPATH + "login.jsp";
	}

	// 로그인 페이지로 이동
	@RequestMapping(value = "/loginForm.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginForm(@ModelAttribute("url") String url) {

		return Comm.USERPATH + "login.jsp";
	}

	//로그인
	@RequestMapping("login.do")
	@ResponseBody
	public String login(UserVO vo) {
		//파라미터로 받아온 vo로 정보를 찾아봄
		UserVO baseVO = userDao.userIdCheck(vo);
		String result = "no";
		//만약 vo로 관련된 나머지 정보가 있다면 if문으로 들어감
		if (baseVO != null) {
			result = "idOk";
			//아이디는 있으므로 비밀번호 체크
			if (baseVO.getUserPw().equals(vo.getUserPw())) {
				//비밀번호가 맞다면
				//세션에 로그인 정보가 없다면if문으로 들어감
				if (session == null) {
					//세션에서 값 얻기
					session = request.getSession();
					//세션에 값 저장
					session.setAttribute("login", baseVO);
				} else {
					//세션이 있다면 else문으로 들어감
					try {
						//login이라는 세션이 있는지 확인 없으면 if문으로 들어감
						if (session.getAttribute("login") == null) {
							// 세션에서 값 얻기
							session = request.getSession();
							// 세션에 값 저장
							session.setAttribute("login", baseVO);
						}
					} catch (Exception e) {
						System.out.println("세션 받기 실패");
					}
				}
				result = "yes";
				// 계정이 관리자인지 확인
				if (baseVO.getUserId().equals("manager")) {
					result = "manager";
				}
			}
		}
		return result;
	}

	// 카카오 로그인
	@RequestMapping("kakaoLogin.do")
	@ResponseBody
	public String kakaoLogin(UserVO vo) {
		//카카오 간편로그인에서 받아온 이메일로 정보를 확인
		UserVO baseVO = userDao.kakaoLogin(vo.getUserEmail());
		String result = "no";
		//카카오에서 받아온 이메일로 찾은 vo값이 있다면 if문으로 들어감
		if (baseVO != null) {
			//로그인 완료
			result = "login";
			// 세션에 로그인 정보 저장
			if (session == null) {
				session = request.getSession();
				session.setAttribute("login", baseVO);
			} else {
				try {
					if (session.getAttribute("login") == null) {
						// 세션에서 값 얻기
						session = request.getSession();
						// 세션에 값 저장
						session.setAttribute("login", baseVO);
					}
				} catch (Exception e) {
					System.out.println("세션 받기 실패");
				}
			}
		} else { // 카카오에서 받아온 이메일로 vo들을 찾았을때 값이 없다면 else문으로 들어감
			//이후 카카오에서 받은 정보로 회원가입
			int res = userDao.kakaoSignUp(vo);
			//회원가입이 잘되었다면 result에 회원가입이 완료되었다고 알려주기
			if (res == 1) {
				result = "signUp";
				// 세션에 로그인 정보 저장
				if (session == null) {
					session = request.getSession();
					session.setAttribute("login", vo);
				} else {
					try {
						if (session.getAttribute("login") == null) {
							// 세션에서 값 얻기
							session = request.getSession();
							// 세션에 값 저장
							session.setAttribute("login", baseVO);
						}
					} catch (Exception e) {
						System.out.println("세션 받기 실패");
					}
				}
			} else {
				result = "no";
			}
		}
		return result;
	}

	//네이버 로그인
	//카카오 로그인과 비슷한 내용이니까 위에 참고
	@RequestMapping("naverLogin.do")
	@ResponseBody
	public String naverLogin(UserVO vo) {
		UserVO baseVO = userDao.naverLogin(vo.getUserEmail());
		String result = "no";
		if (baseVO != null) {
			result = "login";
			// 세션에 로그인 정보 저장
			if (session == null) {
				session = request.getSession();
				session.setAttribute("login", baseVO);
			} else {
				try {
					if (session.getAttribute("login") == null) {
						// 세션에서 값 얻기
						session = request.getSession();
						// 세션에 값 저장
						session.setAttribute("login", baseVO);
					}
				} catch (Exception e) {
					System.out.println("세션 받기 실패");
				}
			}
		} else {
			int res = userDao.naverSignUp(vo);
			if (res == 1) {
				result = "signUp";
				// 세션에 로그인 정보 저장
				if (session == null) {
					session = request.getSession();
					session.setAttribute("login", vo);
				} else {
					try {
						if (session.getAttribute("login") == null) {
							// 세션에서 값 얻기
							session = request.getSession();
							// 세션에 값 저장
							session.setAttribute("login", baseVO);
						}
					} catch (Exception e) {
						System.out.println("세션 받기 실패");
					}
				}
			} else {
				result = "no";
			}
		}
		return result;
	}

	//회원가입 페이지로 이동
	@RequestMapping(value = { "/signUpForm.do" })
	public String signUpForm() {
		return Comm.USERPATH + "signUp.jsp";
	}

	//회원가입
	@RequestMapping("signUp.do")
	public String signUp(UserVO vo, Model model) {
		String bd = vo.getUserBirthDate();
		String by = "";
		for (int i = 0; i < 4; i++) {
			by += bd.charAt(i);
		}
		int date = Integer.parseInt(by);
		int age = 2022 - date + 1;
		vo.setUserAge(age);
		// Dao 내부의 회원가입 메서드
		int res = userDao.signUp(vo);
		model.addAttribute("vo", vo);
		return Comm.USERPATH + "Welcome.jsp";
	}

	// 회원가입 이후 웰컴창으로 이동
	@RequestMapping("/welcome.do")
	public String welcomeForm() {
		return Comm.USERPATH + "Welcome.jsp";
	}

	// id체크
	@RequestMapping("userIdCheck.do")
	@ResponseBody
	public String userIdCheck(@RequestParam("userId") String userId) throws Exception {
		UserVO baseVO = userDao.userIdCheck(userId);
		String result = "no";
		try {
			if (baseVO == null) {
				result = "yes";
			}
			return result;
		} catch (Exception e) {
			return result;
		}

	}

	// 이메일 체크
	@RequestMapping("userEmailCheck.do")
	@ResponseBody
	public String userEmailCheck(@RequestParam("userEmail") String userEmail) throws Exception {
		UserVO baseVO = userDao.userEmailCheck(userEmail);
		String res = "no";
		try {
			if (baseVO == null) {
				res = "yes";
			}
			return res;
		} catch (Exception e) {
			return res;
		}
	}
	//전화번호 중복체크
	@RequestMapping("userPhoneNumCheck.do")
	@ResponseBody
	public String userPhoneNumCheck(@RequestParam("userPhoneNum") String userPhoneNum) {
		UserVO baseVO = userDao.userPhoneNumCheck(userPhoneNum);
		String res = "no";
		try {
			if(baseVO == null) {
				res = "yes";
			}
			return res;
		} catch (Exception e) {
			return res;
		}
	}

	// 닉네임 체크
	@RequestMapping("userNickNameCheck.do")
	@ResponseBody
	public String userNickNameCheck(@RequestParam("userNickName") String userNickName) throws Exception {
		UserVO baseVO = userDao.userNickNameCheck(userNickName);
		String res = "no";
		try {
			if (baseVO == null) {
				res = "yes";
			}
			return res;
		} catch (Exception e) {
			return res;
		}
	}
	
	//비밀번호 변경
	@RequestMapping("pwdupdate.do")
	@ResponseBody
	public String userPwUpDate(UserVO vo) {
		UserVO baseVO = (UserVO)session.getAttribute("login");
		vo.setUserIdx(baseVO.getUserIdx());
		int res = userDao.userPwUpDate(vo);
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		return result;
	}
	
	//닉네임 변경
	@RequestMapping("userNickNameUpDate.do")
	@ResponseBody
	public String userNickNameUpDate(UserVO vo) {
		UserVO baseVo = (UserVO)session.getAttribute("login");
		vo.setUserIdx(baseVo.getUserIdx());
		int res = userDao.userNickNameUpDate(vo);
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		return result;
	}
	
	//이메일 변경
	@RequestMapping("userEmailUpDate.do")
	@ResponseBody
	public String userEmailUpDate(UserVO vo) {
		UserVO baseVo = (UserVO)session.getAttribute("login");
		vo.setUserIdx(baseVo.getUserIdx());
		int res = userDao.userEmailUpDate(vo);
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		return result;
	}
	//전화번호 변경
	@RequestMapping("userPhoneNumUpDate.do")
	@ResponseBody
	public String userPhoneNumUpDate(UserVO vo) {
		UserVO baseVo = (UserVO)session.getAttribute("login");
		vo.setUserIdx(baseVo.getUserIdx());
		int res = userDao.userPhoneNumUpDate(vo);
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		return result;
	}
	
	// 세션 삭제
	@RequestMapping("sessionDrop.do")
	@ResponseBody
	public String sessionDelete() {
		String result = "no";
		if (session != null) {
			System.out.println("세션삭제 1 : " + session.getAttribute("login"));
			session.removeAttribute("login");
			result = "yes";
		}
		return result;
	}

}
