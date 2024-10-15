package com.kh.fitguardians.member.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.kh.fitguardians.common.model.vo.QrInfo;
import com.kh.fitguardians.member.model.service.MemberServiceImpl;
import com.kh.fitguardians.member.model.vo.BodyInfo;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.MemberInfo;

@Controller
public class MemberController {
	
	@Autowired
	private MemberServiceImpl mService = new MemberServiceImpl();
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder; 
	@Autowired
	private ServletContext servletContext;
	
	@RequestMapping("dashboard.me")
	public String goMain() {
		return "Trainee/traineeDashboard";
	}
	
    @RequestMapping("traineeDetail.me")
    public ModelAndView memberDetailView(@RequestParam("userId") String userId, ModelAndView mv) {

    	Member m = mService.getTraineeDetails(userId);
    	ArrayList<BodyInfo> bi = mService.getTraineeBodyInfo(userId);
    	MemberInfo mi = mService.getTraineeInfo(m.getUserNo());
    	// 최근 6개 데이터 조회문
    	ArrayList<BodyInfo> recentBi = mService.getRecentInfo(userId);
    	
    	// 가장 최근 1개 데이터 조회문
    	BodyInfo lastBodyInfo = null;
    	
    	for (BodyInfo bodyInfo : bi) {
    	    lastBodyInfo = bodyInfo;
    	}
    	double lastSmm = lastBodyInfo.getSmm();
    	double lastFat = lastBodyInfo.getFat();
    	double lastBmi = lastBodyInfo.getBmi();
    	
    	mv.addObject("m" , m);
    	mv.addObject("bi" , bi);
    	mv.addObject("mi", mi);
    	mv.addObject("lastSmm", String.format("%.1f", lastSmm));
    	mv.addObject("lastFat", String.format("%.1f", lastFat));
    	mv.addObject("lastBmi", String.format("%.1f", lastBmi));
    	mv.addObject("recentBi", recentBi);
    	
    	mv.setViewName("Trainer/traineeDetailInfo");
    	
        return mv;
    }

	@RequestMapping("loginform.me")
	public String loginForm() throws IOException {
		return "common/loginForm";
	}
	
	@RequestMapping("enrollForm.me")
	public String enrollForm() {
		return "common/enrollForm";
	}
	
	@ResponseBody
	@RequestMapping("checkId.me")
	public String memberCheckId(String userId) {
		int result = mService.checkId(userId);
		if(result > 0) {
			return "YYYN";
		}else {
			return "YYYI";
		}
	}
	
	@ResponseBody
	@RequestMapping("auth.email")
	public String ajaxAuthEmail(String email) {
		int randomCode = mService.authEmail(email);
		return randomCode + "";
	}
	
	
	@RequestMapping(value = "enroll.me", produces = "text/html; charset=UTF-8")
	public String memberEnroll(Member m, String memberInfo, HttpServletRequest request) throws IOException {
		String encPwd = bcryptPasswordEncoder.encode(m.getUserPwd());
		m.setUserPwd(encPwd);
		
		String type = m.getUserLevel().equals("1") ? "trainer" : "trainee";
		
		QrInfo qr = new QrInfo();
		if(m.getQr() == null) {
			qr.setId(m.getUserId());
			qr.setType(type);
			qr.setCreatedAt(LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME));
			qr.setValidUntil(LocalDateTime.now().plusYears(1).format(DateTimeFormatter.ISO_DATE_TIME));
			ObjectMapper objectMapper = new ObjectMapper();
			
			String qrData = objectMapper.writeValueAsString(qr); 
			String fileName = m.getUserId() + ".png"; // 파일명 설정
		    String filePath = servletContext.getRealPath("/resources/qrCodes/" + fileName); // ServletContext를 이용해 경로 설정
		    // 디렉터리 존재 여부 확인
		    File dir = new File(servletContext.getRealPath("/resources/qrCodes/"));
		    if (!dir.exists()) {
		        dir.mkdirs(); // 디렉터리가 없으면 생성
		    }
		    
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			
			try {
				BitMatrix bitMatrix = qrCodeWriter.encode(qrData, BarcodeFormat.QR_CODE, 200, 200);
				Path path = FileSystems.getDefault().getPath(filePath);
				MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);
				m.setQr(filePath);
			} catch (WriterException e) {
				e.printStackTrace();
			}
		}
		
		int result2 = mService.insertQrInfo(qr);
		int result1 = mService.insertMember(m);
		
		
		
		// 기본 프로필 사진 설정
        String profile = m.getProfilePic() == null ? 
            (m.getGender().equals("F") ? "resources/profilePic/gymW.png" : "resources/profilePic/gymM.png") : 
            m.getProfilePic();
        m.setProfilePic(profile);
		
        System.out.println(memberInfo);
		// 회원 추가 정보가 있는지 확인
        if (memberInfo != null && !memberInfo.isEmpty()) {
            // 추가 정보가 있으면 추가 정보 저장
            MemberInfo info = new Gson().fromJson(memberInfo, MemberInfo.class);
            
            // 추가 정보중에서 기저질환이 없으면 값을 비게 만들기
            if(info.getDisease().equals("없음")) {
            	info.setDisease(null);
            }
            
            int result = mService.insertMemberWithInfo(m, info);
            if (result > 0 && result1 > 0 && result2 > 0) {
                request.getSession().setAttribute("alertMsg", "회원가입이 완료되었습니다. 환영합니다!");
                return "Trainee/traineeDashboard";
            }
        } else {
            // 추가 정보가 없으면 기존 방식대로 회원가입 처리
            int result = mService.insertMember(m);
            if (result > 0 && result1 > 0 && result2 > 0) {
                request.getSession().setAttribute("alertMsg", "회원가입이 완료되었습니다. 환영합니다!");
                return "Trainee/traineeDashboard";
            }
        }
        request.getSession().setAttribute("errorMsg", "회원가입에 실패했습니다.");
        return "common/loginForm";
	}
	
	@RequestMapping("login.me")
	public String memberLogin(Member m, HttpServletRequest request) {
		Member loginUser = mService.loginMember(m);
		HttpSession session = request.getSession();
		if(loginUser != null) {
			if(bcryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {
				
				session.setAttribute("loginUser", loginUser);
				
				// 트레이너 정보 알아오기
				String trainerId = loginUser.getPt();
				Member trainer = mService.getTrainerInfo(trainerId);
	
				if(loginUser.getUserLevel().equals("2")) {
					
					// 회원 추가정보 가져오기
					MemberInfo mi = mService.getMemberInfo(loginUser.getUserNo());
					
					// 회원 신체정보 가져오기
					BodyInfo bi = mService.getBodyInfo(loginUser.getUserId());
					
					// 회원 최근 6개 신체정보 가져오기
			    	ArrayList<BodyInfo> recentBi = mService.getRecentInfo(loginUser.getUserId());
					
					// 회원
					session.setAttribute("trainer", trainer);
					session.setAttribute("mi", mi);
					session.setAttribute("bi", bi);
					session.setAttribute("recentBi", recentBi);

					return "Trainee/traineeDashboard";
				}else {
					// 트레이너 - 
					return "redirect:traineeList.me";
				}
			}else {
				session.setAttribute("errorMsg", "비밀번호가 일치하지 않습니다. 다시 입력해주세요!");
				return "redirect:loginform.me";
			}
			
		}else {
			session.setAttribute("errorMsg", "아이디가 틀렸습니다 다시 입력해주세요!");
			return "redirect:loginform.me";
		}
		
	}
	
	@RequestMapping("traineeList.me")
	public ModelAndView traineeList(HttpSession session, ModelAndView mv) {
		// 페이지가 로드되자마자 트레이너의 담당 회원이 조회되야 한다.
		String userId = ((Member)session.getAttribute("loginUser")).getUserId();
		ArrayList<Member> list = mService.getTraineeList(userId);
		//System.out.println("userId :" + userId);
		
		//System.out.println(list);
		mv.addObject("list", list)
		  .setViewName("Trainer/traineeManagement");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("saveBodyInfo.me")
	public String saveBodyInfo(BodyInfo bi){
		
		int result = mService.saveBodyInfo(bi);
		///System.out.println(result);
		return result>0?"success":"error";
		
	}
	
	@ResponseBody
	@RequestMapping("deleteBodyInfo.me")
	public String deleteBodyInfo(int bodyInfoNo) {
		int result = mService.deleteBodyInfo(bodyInfoNo);
		return result >0?"success":"error";
	}

	
	@RequestMapping("logout.me")
	public String memberlogOut(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("qrForm.me")
	public String qrCheckForm() {
		return "common/checkQr";
	}
	
	@ResponseBody
	@RequestMapping("qrCheck.me")
	public String MemberQrCheck(@RequestBody Map<String, String> request) {
		ObjectMapper objectMapper = new ObjectMapper();
		String qrData = request.get("qr");
		QrInfo qrInfo = null;
		int result1 = 0;
		int result2 = 0;
		try {
			qrInfo = objectMapper.readValue(qrData, QrInfo.class);
				// qr 일치 확인
				QrInfo qrResult = mService.qrCheck(qrInfo);
				LocalDateTime now = LocalDateTime.now();
				
				if(qrResult != null) {
					// 출석
					if(qrResult.getAttendance() == null) {
						qrResult.setAttendance(LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME));
						int upResult = mService.updateAttendance(qrResult);
						return "YYYQ";
					}else {
						
						LocalDateTime attendanceTime = LocalDateTime.parse(qrResult.getAttendance(), DateTimeFormatter.ISO_DATE_TIME); 
						Duration duration = Duration.between(attendanceTime, now);
						long hours = duration.toHours();
						System.out.println(hours);
						
						
						if(qrResult.getType().equals("trainee") && hours >= 1) {
							qrResult.setAttendance(now.toString());
							result1 = mService.updateAttStatus(qrResult);
						}else if(qrResult.getType().equals("trainer") && hours >= 6) {
							qrResult.setAttendance(now.toString());
							result2 = mService.updateAttStatus(qrResult);
						}
						
						
					}
				}
				
				
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		if(result1 > 0 || result2 > 0) {
			return "YYQQ";
		}else {
			return "NNQQ";
		}
	}
	
	// mypage 관련
	@RequestMapping("mypage.me")
	public String myPage(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Member m = (Member) session.getAttribute("loginUser");
		if(m.getUserLevel().equals("2")) {
			MemberInfo mInfo = mService.selectMemberInfo(m.getUserNo());
			Gson gson = new Gson();
			String diseaseJson = gson.toJson(mInfo.getDisease());
			request.setAttribute("memberInfo", mInfo);
			request.setAttribute("disease", diseaseJson);
		}
		return "common/myPage";
	}
	
	@ResponseBody
	@RequestMapping("changeDisease.me")
	public String updateDisease(MemberInfo mInfo) {
		
		int result = mService.updateDisease(mInfo);
		if(result > 0) {
			return "DDDY";
		}else {
			return "DDDN";
		}
	}
	
	
}
