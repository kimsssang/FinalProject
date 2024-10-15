package com.kh.fitguardians.member.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.fitguardians.common.model.vo.QrInfo;
import com.kh.fitguardians.member.model.vo.BodyInfo;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.MemberInfo;

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

	public Member getTrainerInfo(SqlSessionTemplate sqlSession, String trainerId) {
		return sqlSession.selectOne("memberMapper.getTrainerInfo", trainerId);
	}

	public MemberInfo getMemberInfo(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("memberMapper.getMemberInfo", userNo);
	}

	public BodyInfo getBodyInfo(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("memberMapper.getBodyInfo", userId);
	}

	public ArrayList<Member> getTraineeList(SqlSessionTemplate sqlSession, String userId) {
		ArrayList<Member> m = (ArrayList)sqlSession.selectList("memberMapper.getTraineeList", userId);
		//System.out.println("m의 값" + m);
		return m;
	}

	public Member getTraineeDetails(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("memberMapper.getTraineeDetails", userId);
	}

	public ArrayList<BodyInfo> getTraineeBodyInfo(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("memberMapper.getTraineeBodyInfo", userId);
	}

	public MemberInfo getTraineeInfo(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("memberMapper.getTraineeInfo", userNo);
	}

	public int saveBodyInfo(SqlSessionTemplate sqlSession, BodyInfo bi) {
		return sqlSession.insert("memberMapper.saveBodyInfo", bi);
	}

	public int deleteBodyInfo(SqlSessionTemplate sqlSession, int bodyInfoNo) {
		return sqlSession.update("memberMapper.deleteBodyInfo", bodyInfoNo);
	}

	public ArrayList<BodyInfo> getRecentInfo(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("memberMapper.getRecentInfo", userId);
	}
	
	
	

}
