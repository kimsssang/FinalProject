package com.kh.fitguardians.member.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
import com.kh.fitguardians.exercise.model.service.ExerciseServiceImpl;
import com.kh.fitguardians.member.model.service.MemberServiceImpl;
import com.kh.fitguardians.member.model.vo.BodyInfo;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.MemberInfo;
import com.kh.fitguardians.member.model.vo.Schedule;
import com.kh.fitguardians.member.model.vo.TrainerInfo;

@Controller
public class MemberController {
	
	@Autowired
	private MemberServiceImpl mService = new MemberServiceImpl();
	@Autowired
	private ExerciseServiceImpl eService = new ExerciseServiceImpl();
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder; 
	@Autowired
	private ServletContext servletContext;
	
	@RequestMapping("dashboard.me")
	public String goMain() {
		return "Trainee/traineeDashboard";
	}
	
	// 회원 상세정보 조회
    @RequestMapping("traineeDetail.me")
    public ModelAndView memberDetailView(@RequestParam("userId") String userId, ModelAndView mv) {

    	Member m = mService.getTraineeDetails(userId);
    	ArrayList<BodyInfo> bi = mService.getTraineeBodyInfo(userId);
    	MemberInfo mi = mService.getTraineeInfo(m.getUserNo());
    	// 최근 6개 데이터 조회문
    	ArrayList<BodyInfo> recentBi = mService.getRecentInfo(userId);
    	
    	// 가장 최근 1개 데이터 조회문
    	BodyInfo lastBodyInfo = null;
    	
    	// 가장 최근에 측정한 BodyInfo의 값을 가져옴
    	for (BodyInfo bodyInfo : recentBi) {
    		if(lastBodyInfo == null || bodyInfo.getMeasureDate().after(lastBodyInfo.getMeasureDate())) {
    			lastBodyInfo = bodyInfo;
    		}
    	}
    	
    	// lastBodyInfo에 값이 없으면 NullPointerException이 발생할 수 있다.
    	if(lastBodyInfo != null) {
    		double lastSmm = lastBodyInfo.getSmm();
    		double lastFat = lastBodyInfo.getFat();
    		double lastBmi = lastBodyInfo.getBmi();
    		
    		mv.addObject("lastSmm", String.format("%.1f", lastSmm));
    		mv.addObject("lastFat", String.format("%.1f", lastFat));
    		mv.addObject("lastBmi", String.format("%.1f", lastBmi));
    		
    	}else { // lastBodyInfo가 없을 때 예외처리

    		mv.addObject("lastSmm", 0.0);
    		mv.addObject("lastFat", 0.0);
    		mv.addObject("lastBmi", 0.0);
    		
    	}
    	
    	mv.addObject("m" , m);
    	mv.addObject("bi" , bi);
    	mv.addObject("mi", mi);
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
	public ModelAndView memberEnroll(Member m, String memberInfo, HttpServletRequest request, ModelAndView mv) throws IOException {
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
				
				String qrCodeUrl = "http://localhost:8282/fitguardians/resources/qrCodes/" + fileName;
				m.setQr(qrCodeUrl);
			} catch (WriterException e) {
				e.printStackTrace();
			}
		}
		
		
		// 기본 프로필 사진 설정
        String profile = m.getProfilePic() == null ? 
            (m.getGender().equals("F") ? "resources/profilePic/gymW.png" : "resources/profilePic/gymM.png") : 
            m.getProfilePic();
        m.setProfilePic(profile);
        
        
		// 회원 추가 정보가 있는지 확인
        if (memberInfo != null && !memberInfo.isEmpty()) { // 회원 추가정보가 있다면
            // 추가 정보가 있으면 추가 정보 저장
            MemberInfo info = new Gson().fromJson(memberInfo, MemberInfo.class);
            
            // 추가 정보중에서 기저질환이 없으면 값을 비게 만들기
            if(info.getDisease().equals("없음")) {
				info.setDisease(null);
            }
            
            int result = mService.insertMemberWithInfo(m, info);
            int result2 = mService.insertQrInfo(qr);
            if (result > 0 && result2 > 0) { // 성공적으로 회원가입을 한 경우
                request.getSession().setAttribute("alertMsg", "회원가입이 완료되었습니다. 환영합니다!");
                
            	Member mem = mService.getTraineeDetails(m.getUserId());
            	ArrayList<BodyInfo> bi = mService.getTraineeBodyInfo(m.getUserId());
            	MemberInfo mi = mService.getTraineeInfo(m.getUserNo());
            	// 최근 6개 데이터 조회문
            	ArrayList<BodyInfo> recentBi = mService.getRecentInfo(m.getUserId());
            	
            	// 가장 최근 1개 데이터 조회문
            	BodyInfo lastBodyInfo = null;
            	
            	for (BodyInfo bodyInfo : bi) {
            	    lastBodyInfo = bodyInfo;
            	}
            	double lastSmm = lastBodyInfo.getSmm();
            	double lastFat = lastBodyInfo.getFat();
            	double lastBmi = lastBodyInfo.getBmi();
            	
            	mv.addObject("m" , mem);
            	mv.addObject("bi" , bi);
            	mv.addObject("mi", mi);
            	mv.addObject("lastSmm", String.format("%.1f", lastSmm));
            	mv.addObject("lastFat", String.format("%.1f", lastFat));
            	mv.addObject("lastBmi", String.format("%.1f", lastBmi));
            	mv.addObject("recentBi", recentBi);
                
            	mv.setViewName("Trainer/traineeDetailInfo");
            	
                return mv;
            }
            
            // BodyInfo테이블 하나 자동으로 생성하기 - 추가정보 입력한 경우
            BodyInfo bi = new BodyInfo();
            
            if(m.getGender() == "M") { // 성별이 남성인 경우

            	double mAge = Double.parseDouble(m.getAge());
            	double mBmi = info.getWeight() / Math.pow(info.getHeight(), 2);
            	double mSmm = 0.407 * info.getWeight() + 0.267 * info.getHeight() - 19.2;
            	double mBfp = 1.20 * mBmi + 0.23 * mAge - 16.2;
            	double mFat = info.getWeight() * (mBfp / 100);
            	
            	bi.setUserId(m.getUserId());
            	bi.setBmi(mBmi);
            	bi.setSmm(mSmm);
            	bi.setFat(mFat);
            	int biResult1 = mService.addBodyInfo(bi);
            	
            }else { // 성별이 여성인 경우
            	
            	double fAge = Double.parseDouble(m.getAge());
            	double fBmi = info.getWeight() / Math.pow(info.getHeight(), 2);
            	double fSmm = 0.252 * info.getWeight() + 0.473 * info.getHeight() - 48.3;
            	double fBfp = 1.20 * fBmi + 0.23 * fAge - 5.4;
            	double fFat = info.getWeight() * (fBfp / 100);
            	
            	bi.setUserId(m.getUserId());
            	bi.setBmi(fBmi);
            	bi.setSmm(fSmm);
            	bi.setFat(fFat);
            	int biResult2 = mService.addBodyInfo(bi);
            	
            }
        } else { // 회원 추가정보가 없다면
            // 추가 정보가 없으면 기존 방식대로 회원가입 처리
        	// MemberInfo가  0 or null
			MemberInfo info = new MemberInfo();
			info.setUserNo(m.getUserNo());
			info.setHeight(0);
			info.setWeight(0);
			info.setDisease(null);
			info.setGoal("");
            
            // BodyInfo테이블 하나 자동으로 생성하기 - 추가정보 입력 안한 경우 (BodyInfo가 0 혹은 null)
            BodyInfo bi = new BodyInfo();
            bi.setUserId(m.getUserId());
            bi.setBmi(0);
            bi.setSmm(0);
            bi.setFat(0);
            int biResult3 = mService.addBodyInfo(bi);
            
            int result = mService.insertMemberWithInfo(m, info);
            int result2 = mService.insertQrInfo(qr);
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
            
            if (result > 0 && result2 > 0) {
                request.getSession().setAttribute("alertMsg", "회원가입이 완료되었습니다. 환영합니다!");
                mv.setViewName("common/loginForm");
                return mv;
            }
        }
        request.getSession().setAttribute("errorMsg", "회원가입에 실패했습니다.");
        mv.setViewName("common/loginForm");
        return mv;
	}
	
	@RequestMapping("login.me")
	public String memberLogin(Member m, HttpServletRequest request) {
		Member loginUser = mService.loginMember(m);
		HttpSession session = request.getSession();
		if(loginUser != null) {
			if(bcryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {
				
				session.setAttribute("loginUser", loginUser);
				System.out.println("회원 아이디 : " + loginUser.getUserId());
				System.out.println("회원 정보 : " + loginUser);
				
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
					
					System.out.println("회원의 recentBi : " + recentBi);

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
			BodyInfo bodyInfo = mService.getBodyInfo(m.getUserId());
			request.setAttribute("memberInfo", mInfo);
			request.setAttribute("disease", diseaseJson);
			request.setAttribute("bodyInfo", bodyInfo);
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
		
		if(result > 0) {
			return "DDDY";
		}else {
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
	public ModelAndView PtCalednar(HttpSession session, ModelAndView mv) {
		String userId = ((Member)session.getAttribute("loginUser")).getUserId();
		
		ArrayList<Member> list = eService.getTrainee(userId);
		
		mv.addObject("list", list).setViewName("Trainer/PtCalendar");;
		
		return mv;
	
	}
	
	@RequestMapping(value="calendar.me", produces="application/json")
	public String traineeCalender(HttpSession session, HttpServletRequest request) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		ArrayList<Schedule> schedule = mService.selectSchedule(loginUser.getUserNo());
		request.setAttribute("schedule", schedule);
		return "Trainee/TraineeCalendar";
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
