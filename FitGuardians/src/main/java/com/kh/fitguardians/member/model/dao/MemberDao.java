package com.kh.fitguardians.member.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.fitguardians.common.model.vo.QrInfo;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.MemberInfo;
import com.kh.fitguardians.member.model.vo.Schedule;
import com.kh.fitguardians.member.model.vo.TrainerInfo;

@Repository
public class MemberDao {

	public int checkId(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("memberMapper.checkId", userId);
	}

	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}
	
	public int selectUserNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.selectUserNo");
	}
	
	public int insertMemberInfo(SqlSessionTemplate sqlSession, MemberInfo info) {
		return sqlSession.insert("memberMapper.insertMemberInfo", info);
	}
	
	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}

	public int insertQrInfo(SqlSessionTemplate sqlSession, QrInfo qr) {
		return sqlSession.insert("memberMapper.insertQrInfo", qr);
	}

	public QrInfo qrCheck(SqlSessionTemplate sqlSession, QrInfo qr) {
		return sqlSession.selectOne("memberMapper.qrCheck", qr);
	}

	public int updateAttendance(SqlSessionTemplate sqlSession, QrInfo qr) {
		return sqlSession.update("memberMapper.updateAttendance", qr);
	}

	public int updateAttStatus(SqlSessionTemplate sqlSession, QrInfo qrResult) {
		return sqlSession.update("memberMapper.updateAttStatus", qrResult);
	}

	public MemberInfo selectMemberInfo(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("memberMapper.selectMemberInfo", userNo);
	}

	public int updateDisease(SqlSessionTemplate sqlSession, MemberInfo mInfo) {
		return sqlSession.update("memberMapper.updateDisease", mInfo);
	}

	public int memberPwdCheck(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.memberPwdCheck", m);
	}

	public int updateMemberPwd(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMemberPwd", m);
	}

	public int updateMemberEmail(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMemberEmail", m);
	}

	public int deleteMember(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.update("memberMapper.deleteMember", userNo);
	}

	public ArrayList<Schedule> selectSchedule(SqlSessionTemplate sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectSchedule", userNo);
	}

	public int updateMemberProfilePic(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMemberProfilePic", m);
	}

	public int insertTrainerInfo(SqlSessionTemplate sqlSession, TrainerInfo trInfo) {
		return sqlSession.insert("memberMapper.insertTrainerInfo", trInfo);
	}

	public TrainerInfo selectTrainerInfo(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("memberMapper.selectTrainerInfo", userNo);
	}

	public int updateTrainerInfo(SqlSessionTemplate sqlSession, TrainerInfo trInfo) {
		return sqlSession.update("memberMapper.updateTrainerInfo", trInfo);
	}



}
