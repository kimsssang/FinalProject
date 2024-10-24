package com.kh.fitguardians.member.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.fitguardians.common.model.vo.QrInfo;
import com.kh.fitguardians.member.model.vo.BodyInfo;
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
		return (ArrayList)sqlSession.selectList("memberMapper.selectTpSchedule", userNo);
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

	public Member selectMemberBySocialIdKey(SqlSessionTemplate sqlSession, String api) {
		return sqlSession.selectOne("memberMapper.selectMemberBySocialIdKey", api);
	}
	
	public int insertSocialMember(SqlSessionTemplate sqlSession, Member newUser) {
		return sqlSession.insert("memberMapper.insertSocialMember", newUser);
	}
	
	public boolean checkAdditionalInfo(SqlSessionTemplate sqlSession, int userNo) {
		int result = sqlSession.selectOne("memberMapper.checkAdditionalInfo", userNo);
		if(result > 0) {
			return true;
		}else {
			return false;
		}
	}

	public int addBodyInfo(SqlSessionTemplate sqlSession, BodyInfo bi) {
		return sqlSession.insert("memberMapper.addBodyInfo", bi);
	}

	public Member selectMemberByUserId(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("memberMapper.selectMemberByUserId", userId);
	}

	public int defaultMemberInfoInsert(SqlSessionTemplate sqlSession, MemberInfo mi) {
		return sqlSession.insert("memberMapper.defaultMemberInfoInsert", mi);
	}

	public int defaultBodyInfoInsert(SqlSessionTemplate sqlSession, BodyInfo bi) {
		return sqlSession.insert("memberMapper.defaultBodyInfoInsert", bi);
	}

	public boolean checkBodyInfo(SqlSessionTemplate sqlSession, String userId) {
		int result = sqlSession.selectOne("memberMapper.checkBodyInfo", userId);
		if(result > 0) {
			return true;
		}else {
			return false;
		}
	}

	public int addAdditionalSocialMemberInfo(SqlSessionTemplate sqlSession, MemberInfo addAdditionalInfo) {
		return sqlSession.update("memberMapper.addAdditionalSocialMemberInfo", addAdditionalInfo);
	}
	
	public int addSocialMemberBodyInfo(SqlSessionTemplate sqlSession, BodyInfo bodyInfo) {
		return sqlSession.update("memberMapper.addSocialMemberBodyInfo", bodyInfo);
	}

	public ArrayList<Schedule> selectTpShedule(SqlSessionTemplate sqlSession, Member m) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectTpSchedule", m);
	}

	public int selectMyMember(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("memberMapper.selectMyMember", userId);
	}

	public int selectMemberCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.selectMemberCount");
	}
	
	public int trainerToday(SqlSessionTemplate sqlSession,int userNo) {
		return sqlSession.selectOne("memberMapper.trainerToday", userNo);
	}

	public int trainerTodayAll(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("memberMapper.trainerTodayAll", userNo);
	}

}
