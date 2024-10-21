package com.kh.fitguardians.chat.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class FileUpload {
	
	private int fileNo;          // 파일 고유 번호
    private String fileName;     // 저장된 파일 이름
    private String filePath;     // 파일의 저장 경로
    private int uploadedBy;      // 파일을 업로드한 사용자 NO
    private String uploadDate;     // 파일 업로드 날짜

}
