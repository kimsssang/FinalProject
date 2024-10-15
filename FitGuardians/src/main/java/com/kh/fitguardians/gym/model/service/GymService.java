package com.kh.fitguardians.gym.model.service;

import java.util.List;

import com.kh.fitguardians.gym.model.vo.Gym;

public interface GymService {
	
	// 로그인한 사용자의 주소 정보를 가져오는 메서드
	String getUserAddress(int userNo);
	
	// 주어진 주소(사용자의 주소)를 기준으로 주변 헬스장 목록을 반환하는 메서드
	List<Gym> findGymsNearAddress(String address);
	
	// 사용자가 입력한 키워드를 기반으로 주소를 검색하는 메서드
	String getAddressFromKeyword(String keyword);

}
