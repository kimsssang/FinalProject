package com.kh.fitguardians.member.model.service;

import java.util.ArrayList;

import com.kh.fitguardians.common.model.vo.QrInfo;
import com.kh.fitguardians.member.model.vo.BodyInfo;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.MemberInfo;

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
	
	// 트레이너 - 멤버 구하기 + 정보 조회
	public ArrayList<Member> getTraineeList(String userId);
	
	// 회원 정보디테일 누적 조회
	public Member getTraineeDetails(String userId); 
	
	// 회원 신체정보 조회
	public ArrayList<BodyInfo> getTraineeBodyInfo(String userId);
	
	// 회원 추가정보 조회
	public MemberInfo getTraineeInfo(int userNo);
	
	// 회원 신체정보 삽입
	public int saveBodyInfo(BodyInfo bi);
	
	// 회원 신체정보 데이터 삭제
	public int deleteBodyInfo(int bodyInfoNo);

	// 최근 6개 신체정보 조회(차트용)
	ArrayList<BodyInfo> getRecentInfo(String userId);

	// 트레이너 정보 알아오기
	Member getTrainerInfo(String trainerId);

	// 회원 추가정보
	MemberInfo getMemberInfo(int userNo);

	// 회원 신체정보
	BodyInfo getBodyInfo(String userId);
	
	public MemberInfo selectMemberInfo(int userNo);
	
	public int updateDisease(MemberInfo mInfo);

}
