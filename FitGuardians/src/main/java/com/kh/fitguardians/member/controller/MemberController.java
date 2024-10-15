package com.kh.fitguardians.member.controller;

import java.io.IOException;

import java.io.IOException;

import java.io.File;
import java.io.IOException;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.kh.fitguardians.common.model.vo.QrInfo;
import com.google.gson.Gson;
import com.kh.fitguardians.member.model.service.MemberServiceImpl;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.MemberInfo;
import com.kh.fitguardians.member.model.vo.Schedule;
import com.kh.fitguardians.member.model.vo.TrainerInfo;

@Controller
public class MemberController {

	@Autowired
	private MemberServiceImpl mService = new MemberServiceImpl();
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	@Autowired
	private ServletContext servletContext;

	@RequestMapping("main.co")
	public String goMain() {
		return "main";
	}

	@RequestMapping("traineeDetail.me")
	public String memberDetailView() {
		return "Trainer/traineeDetailInfo";
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
		if (result > 0) {
			return "YYYN";
		} else {
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
		
		
		// 기본 프로필 사진 설정
        String profile = m.getProfilePic() == null ? 
            (m.getGender().equals("F") ? "resources/profilePic/gymW.png" : "resources/profilePic/gymM.png") : 
            m.getProfilePic();
        m.setProfilePic(profile);
        
        // 트레이너일때 기본 트레이너 정보 입력
        if(m.getUserLevel().equals("1")) {
        	TrainerInfo trInfo = new TrainerInfo();
        	trInfo.setUserNo(m.getUserNo());
        	trInfo.setTrCareer("");
        	trInfo.setTrCerti("");
        	trInfo.setTrDescript("");
        	trInfo.setTrProfile("resources/trProfile/blank-profile-picture.webp");
        	int result3 = mService.insertTrainerInfo(trInfo); 
        	
        }
		// 회원 추가 정보가 있는지 확인
        if (memberInfo != null && !memberInfo.isEmpty()) {
            // 추가 정보가 있으면 추가 정보 저장
            MemberInfo info = new Gson().fromJson(memberInfo, MemberInfo.class);
            
            // 추가 정보중에서 기저질환이 없으면 값을 비게 만들기
            if(info.getDisease().equals("없음")) {
            	info.setDisease(null);
            }
            
            int result = mService.insertMemberWithInfo(m, info);
            int result2 = mService.insertQrInfo(qr);
            if (result > 0 && result2 > 0) {
                request.getSession().setAttribute("alertMsg", "회원가입이 완료되었습니다. 환영합니다!");
                return "Trainee/traineeDashboard";
            }
        } else {
            // 추가 정보가 없으면 기존 방식대로 회원가입 처리
        	MemberInfo info = new MemberInfo();
        	info.setUserNo(m.getUserNo());
        	info.setHeight(0);
        	info.setWeight(0);
        	info.setDisease(null);
        	info.setGoal("");
            int result = mService.insertMemberWithInfo(m, info);
            int result2 = mService.insertQrInfo(qr);
            if (result > 0 && result2 > 0) {
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
		if (loginUser != null) {
			if (bcryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {
				session.setAttribute("loginUser", loginUser);
				return "main";
			} else {
				session.setAttribute("errorMsg", "비밀번호가 일치하지 않습니다. 다시 입력해주세요!");
				return "redirect:loginform.me";
			}

		} else {
			session.setAttribute("errorMsg", "아이디가 틀렸습니다 다시 입력해주세요!");
			return "redirect:loginform.me";
		}

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

			if (qrResult != null) {
				// 출석
				if (qrResult.getAttendance() == null) {
					qrResult.setAttendance(LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME));
					int upResult = mService.updateAttendance(qrResult);
					return "YYYQ";
				} else {

					LocalDateTime attendanceTime = LocalDateTime.parse(qrResult.getAttendance(),
							DateTimeFormatter.ISO_DATE_TIME);
					Duration duration = Duration.between(attendanceTime, now);
					long hours = duration.toHours();
					System.out.println(hours);

					if (qrResult.getType().equals("trainee") && hours >= 1) {
						qrResult.setAttendance(now.toString());
						result1 = mService.updateAttStatus(qrResult);
					} else if (qrResult.getType().equals("trainer") && hours >= 6) {
						qrResult.setAttendance(now.toString());
						result2 = mService.updateAttStatus(qrResult);
					}

				}
			}

		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		if (result1 > 0 || result2 > 0) {
			return "YYQQ";
		} else {
			return "NNQQ";
		}
	}

	// mypage 관련
	@RequestMapping("mypage.me")
	public String myPage(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Member m = (Member) session.getAttribute("loginUser");
		if (m.getUserLevel().equals("2")) {
			MemberInfo mInfo = mService.selectMemberInfo(m.getUserNo());
			
			Gson gson = new Gson();
			String diseaseJson = gson.toJson(mInfo.getDisease());
			request.setAttribute("memberInfo", mInfo);
			request.setAttribute("disease", diseaseJson);
		}else {
			TrainerInfo trInfo = mService.selectTrainerInfo(m.getUserNo());
			request.setAttribute("trInfo", trInfo);
		}
		return "common/myPage";
	}

	@ResponseBody
	@RequestMapping("changeDisease.me")
	public String updateDisease(MemberInfo mInfo) {

		int result = mService.updateDisease(mInfo);
		if (result > 0) {
			return "DDDY";
		} else {
			return "DDDN";
		}
	}

	@ResponseBody
	@RequestMapping("checkPwd.me")
	public String memberPwdCheck(Member m, String userEncoPwd, HttpServletRequest request) {
		// Member login = (Member) request.getSession().getAttribute("loginUser");
		if (bcryptPasswordEncoder.matches(m.getUserPwd(), userEncoPwd)) {
			return "YYYP";
		} else {
			return "NNNP";
		}

	}

	@ResponseBody
	@RequestMapping("changePwd.me")
	public String updateMemberPwd(Member m, HttpServletRequest request) {
		// 비밀번호 암호화작업
		String encPwd = bcryptPasswordEncoder.encode(m.getUserPwd());
		m.setUserPwd(encPwd);

		int result = mService.updateMemberPwd(m);
		if (result > 0) {
			Member loginUser = mService.loginMember(m);
			request.getSession().setAttribute("loginUser", loginUser);
			return "YYCP";
		} else {
			return "NNCP";
		}

	}

	@ResponseBody
	@RequestMapping("changeEmail.me")
	public String updateMemberEmail(Member m, HttpServletRequest request) {
		System.out.println(m);
		int result = mService.updateMemberEmail(m);
		if (result > 0) {
			Member updateMember = mService.loginMember(m);
			request.getSession().setAttribute("loginUser", updateMember);
			return "YYYE";
		} else {
			return "NNNE";
		}

	}

	@ResponseBody
	@RequestMapping("delete.me")
	public String deleteMember(int userNo, HttpServletRequest request) {

		int result = mService.deleteMember(userNo);
		if (result > 0) {
			request.getSession().invalidate();
			return "YYYD";
		} else {
			return "NNND";
		}
	}
	
	@RequestMapping(value="calendar.pt", produces="application/json")
	public String trainerCalender(HttpSession session, HttpServletRequest request) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		ArrayList<Schedule> schedule = mService.selectSchedule(loginUser.getUserNo());
		request.setAttribute("schedule", schedule);
		return "Trainer/trainerCalendar";
	}
	
	@RequestMapping(value="calendar.me", produces="application/json")
	public String traineeCalender(HttpSession session, HttpServletRequest request) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		ArrayList<Schedule> schedule = mService.selectSchedule(loginUser.getUserNo());
		request.setAttribute("schedule", schedule);
		return "Trainer/trainerCalendar";
	}
	
	@RequestMapping("changePicture.me")
	public String updateMemberProfilePic(Member m, MultipartFile upfile, HttpSession session) {
		
		// 기본 설정 프로필일땐 바로 삽입
		if(m.getProfilePic() == "resources/profilePic/gymM.png" && m.getProfilePic() == "resources/profilePic/gymW.png") {
			String changeName = saveFile(upfile, session);
			m.setProfilePic("resources/profilePic/" + changeName);
			
		}else { // 다른 사진에서 새로운 사진 업로드하면 다른사진 삭제 후 진행
			new File(session.getServletContext().getRealPath(m.getProfilePic())).delete();
			String changeName = saveFile(upfile, session);
			m.setProfilePic("resources/profilePic/" + changeName);
			
		}
		
		int result = mService.updateMemberProfilePic(m);
		if(result > 0) {
			Member updateMember = mService.loginMember(m);
			session.setAttribute("loginUser", updateMember);
			session.setAttribute("alertMsg", "프로필사진이 변경 되었습니다!");
			return "redirect:/";
		}else {
			session.setAttribute("errorMsg", "프로필사진 변경 실패");
			return "redirect:/";
		}
		
	}
	
	@ResponseBody
	@RequestMapping("updateInfo.tr")
	public String ajaxUpdateTrainerInfo(
			@ModelAttribute TrainerInfo trInfo,
			@RequestParam(value="upfiles", required=false) MultipartFile upfiles, HttpSession session) {
		System.out.println(trInfo);
		System.out.println(upfiles);
		String changeName = "";
		int result = 0;
		if(upfiles != null && upfiles.getSize() > 0) { // 새로 변경할 사진 있을 때
			// 새로 변경할 때 사진이 기본 사진일때
			if(trInfo.getTrProfile().equals("resources/trProfilePic/blank-profile-picture.webp") ) {
				changeName = saveFileTr(upfiles, session);

			}else { // 새로 변경하는데 사진이 기본 사진이 아닐때 원래 사진 지우기
				new File(session.getServletContext().getRealPath(trInfo.getTrProfile())).delete();
				changeName = saveFileTr(upfiles, session);
			}
			
			trInfo.setTrProfile("resources/trProfilePic/" + changeName);
			result = mService.updateTrainerInfo(trInfo);
			
		}else {
			// 새로 변경할 사진 없을 때 
			result = mService.updateTrainerInfo(trInfo);
		}
		
		return result > 0 ? "YYTR" : "NNTR";
	}

	
	/**첨부파일 서버 폴더에 저장하는 역할
	 * @param upfile
	 * @param session
	 * @return 변경된 파일명
	 */
	public String saveFile(MultipartFile upfile, HttpSession session) {
		String originName = upfile.getOriginalFilename();
		// 
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int random = (int)(Math.random() * 90000 + 10000);
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + random + ext;
		// 업로드 폴더 경로
		String savePath = session.getServletContext().getRealPath("/resources/profilePic/");
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();

		}
		
		return changeName;
	}
	
	/**첨부파일 서버 폴더에 저장하는 역할
	 * @param upfile
	 * @param session
	 * @return 변경된 파일명
	 */
	public String saveFileTr(MultipartFile upfile, HttpSession session) {
		String originName = upfile.getOriginalFilename();
		// 
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int random = (int)(Math.random() * 90000 + 10000);
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + random + ext;
		// 업로드 폴더 경로
		String savePath = session.getServletContext().getRealPath("/resources/trProfilePic/");
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();

		}
		
		return changeName;
	}
}
