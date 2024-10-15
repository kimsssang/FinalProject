package com.kh.fitguardians.member.model.service;

import java.util.ArrayList;

import com.kh.fitguardians.common.model.vo.QrInfo;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.MemberInfo;
import com.kh.fitguardians.member.model.vo.Schedule;
import com.kh.fitguardians.member.model.vo.TrainerInfo;

public interface MemberService {
	
	// 아이디 중복 확인
	public int checkId(String userId);
	
	// 이메일 인증 번호
	public int authEmail(String email);
	
	// 회원가입
	public int insertMember(Member m);
	// qr정보 insert
	public int insertQrInfo(QrInfo qr);
	
	// 회원가입(추가정보포함)
	public int insertMemberWithInfo(Member m, MemberInfo info);
	
	// 로그인
	public Member loginMember(Member m);
	
	// 출첵 qr체크
	public QrInfo qrCheck(QrInfo qr);
	
	public int updateAttendance(QrInfo qr);
	
	public int updateAttStatus(QrInfo qr);
	
	public MemberInfo selectMemberInfo(int userNo);
	
	public int updateDisease(MemberInfo mInfo);	
	
	public int updateMemberPwd(Member m);
	
	public int updateMemberEmail(Member m);
	
	public int deleteMember(int userNo);
	
	public ArrayList<Schedule> selectSchedule(int userNo);
	
	public int updateMemberProfilePic(Member m);
	
	public int insertTrainerInfo(TrainerInfo trInfo);
	
	public TrainerInfo selectTrainerInfo(int userNo);
	
	public int updateTrainerInfo(TrainerInfo trInfo);
}
