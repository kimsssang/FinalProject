package com.kh.fitguardians.member.model.service;

import java.util.ArrayList;

import com.kh.fitguardians.common.model.vo.QrInfo;
import com.kh.fitguardians.member.model.vo.BodyInfo;
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

	// 회원 정보 변경
	public int updateMemberPwd(Member m);
	
	public int updateMemberEmail(Member m);
	
	public int deleteMember(int userNo);
	
	public ArrayList<Schedule> selectSchedule(int userNo);
	
	public int updateMemberProfilePic(Member m);
	
	public int insertTrainerInfo(TrainerInfo trInfo);
	
	public TrainerInfo selectTrainerInfo(int userNo);
	
	public int updateTrainerInfo(TrainerInfo trInfo);
	
	// 소셜 회원 정보 조회
	public Member selectMemberBySocialIdKey(String api);
	
	// 소셜 회원가입
	public int insertSocialMember(Member newUser);
	
	// 소셜 회원(추가 정보 존재 유무확인)
	public boolean checkAdditionalInfo(int userNo);
	
	// 소셜 회원(추가 정보 입력)
	public int addAdditionalInfo(MemberInfo addAdditionalInfo);

	// 회원가입시 자동으로 bodyInfo 추가
	int addBodyInfo(BodyInfo bi);

	// id를 통해서 userNo 값 가져오기
	public Member selectMemberByUserId(String userId);

	// 기본 추가 정보 넣기
	public int defaultMemberInfoInsert(MemberInfo mi);

	// 신체 추가 정보 넣기
	int defaultBodyInfoInsert(BodyInfo bi);

	// 소셜 회원(신체정보 존재 유무 확인)
	boolean checkBodyInfo(String userId);

}
