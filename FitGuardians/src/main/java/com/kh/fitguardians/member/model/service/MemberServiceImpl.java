package com.kh.fitguardians.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

import com.kh.fitguardians.common.model.vo.QrInfo;
import com.kh.fitguardians.member.model.dao.MemberDao;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.MemberInfo;
import com.kh.fitguardians.member.model.vo.Schedule;
import com.kh.fitguardians.member.model.vo.TrainerInfo;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao mDao = new MemberDao();
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private MailSender mailsender;
	
	@Override
	public int checkId(String userId) {
		return mDao.checkId(sqlSession, userId);
	}

	@Override
	public int authEmail(String email) {
		int randomCode = (int)(Math.random()* 90000) + 10000;
		 String messageText = "안녕하세요!\n\n"
                 + "이메일 인증을 위한 요청이 접수되었습니다. 아래의 인증번호를 입력하여 인증을 완료해 주세요.\n\n"
                 + "인증번호: " + randomCode + "\n\n"
                 + "감사합니다!";
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email);
		message.setSubject("FitGuardians 인증번호 메일입니다.");
		message.setText(messageText);
		
		mailsender.send(message);
		return randomCode;
	}
	
	@Override
	public int insertMember(Member m) {
		return mDao.insertMember(sqlSession, m);
	}
	
	@Override
	public int insertQrInfo(QrInfo qr) {
		return mDao.insertQrInfo(sqlSession, qr);
	}
	
	@Override
	public int insertMemberWithInfo(Member m, MemberInfo info) {
		// MEMBER 테이블에 데이터 삽입 및 userNo 반환
	    int result1 = mDao.insertMember(sqlSession, m);
	    
	    if (result1 > 0) {
	        int userNo = mDao.selectUserNo(sqlSession); // 새로 생성된 userNo 조회
	        info.setUserNo(userNo); // MemberInfo에 userNo 설정
	        int result2 = mDao.insertMemberInfo(sqlSession, info); // MEMBER_INFO에 데이터 삽입
	        return (result2 > 0) ? 1 : 0;
	    }
	    
	    return 0;
	}

	@Override
	public Member loginMember(Member m) {
		return mDao.loginMember(sqlSession, m);
	}

	@Override
	public QrInfo qrCheck(QrInfo qr) {
		return mDao.qrCheck(sqlSession, qr);
	}

	@Override
	public int updateAttendance(QrInfo qr) {
		return mDao.updateAttendance(sqlSession, qr);
	}

	@Override
	public int updateAttStatus(QrInfo qr) {
		return mDao.updateAttStatus(sqlSession, qr);
	}

	@Override
	public MemberInfo selectMemberInfo(int userNo) {
		return mDao.selectMemberInfo(sqlSession, userNo);
	}

	@Override
	public int updateDisease(MemberInfo mInfo) {
		return mDao.updateDisease(sqlSession, mInfo);
	}

	@Override
	public int updateMemberPwd(Member m) {
		return mDao.updateMemberPwd(sqlSession, m);
	}

	@Override
	public int updateMemberEmail(Member m) {
		return mDao.updateMemberEmail(sqlSession, m);
	}

	@Override
	public int deleteMember(int userNo) {
		return mDao.deleteMember(sqlSession, userNo);
	}

	@Override
	public ArrayList<Schedule> selectSchedule(int userNo) {
		return mDao.selectSchedule(sqlSession, userNo);
	}

	@Override
	public int updateMemberProfilePic(Member m) {
		return mDao.updateMemberProfilePic(sqlSession, m);
	}

	@Override
	public int insertTrainerInfo(TrainerInfo trInfo) {
		 int userNo = mDao.selectUserNo(sqlSession);
		 trInfo.setUserNo(userNo);
		return mDao.insertTrainerInfo(sqlSession, trInfo);
	}

	@Override
	public TrainerInfo selectTrainerInfo(int userNo) {
		return mDao.selectTrainerInfo(sqlSession, userNo);
	}

	@Override
	public int updateTrainerInfo(TrainerInfo trInfo) {
		return mDao.updateTrainerInfo(sqlSession, trInfo);
	}

	

	

	
	

}
