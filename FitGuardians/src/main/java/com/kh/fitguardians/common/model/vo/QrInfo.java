package com.kh.fitguardians.common.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter@Setter
@ToString
public class QrInfo {
	
	private String qrNo;
	private String id;
	private String type;
	private String createdAt;
	private String validUntil;
	private String attendance;
	private String status;
	private String attStatus;
}
