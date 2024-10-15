CREATE TABLE member (
	user_no NUMBER NOT NULL CONSTRAINT member_pk PRIMARY KEY,
	user_id varchar(30) NOT NULL,
	user_pwd varchar2(100) NOT NULL,
	user_name varchar2(30) NOT NULL,
	email varchar2(100)	NOT NULL,
	phone varchar2(13),
	gender varchar2(1),
	age	number,
	address varchar2(100),
	enroll_date	date DEFAULT sysdate not null,
	user_level	number,
	pt varchar2(30),
	status varchar2(1) DEFAULT 'Y' NULL,
	api	varchar2(100),
	qr	varchar2(300)NOT NULL,
	profile_pic	varchar2(300),
	membership	varchar2(30),
    attendance varchar2(100)   
);
drop SEQUENCE seq_mno;
create sequence seq_mno NOCACHE;

COMMENT ON COLUMN member.user_no IS '회원번호';
COMMENT ON COLUMN member.user_id IS '회원아이디';
COMMENT ON COLUMN member.user_pwd IS '회원비밀번호';
COMMENT ON COLUMN member.user_name IS '회원이름';
COMMENT ON COLUMN member.email IS '이메일';
COMMENT ON COLUMN member.phone IS '전화번호';
COMMENT ON COLUMN member.gender IS '성별';
COMMENT ON COLUMN member.age IS '나이';
COMMENT ON COLUMN member.address IS '주소';
COMMENT ON COLUMN member.enroll_date IS '가입일';
COMMENT ON COLUMN member.user_level IS '1 트레이너, 2회원';
COMMENT ON COLUMN member.pt IS '담당트레이너';
COMMENT ON COLUMN member.status IS 'Y, N';
COMMENT ON COLUMN member.api IS 'api로그인 키';
COMMENT ON COLUMN member.qr IS 'qr코드 발급후 저장 경로';
COMMENT ON COLUMN member.profile_pic IS '회원 프로필 사진';
COMMENT ON COLUMN member.membership IS '회원이 소유한 회원권';
comment on column member.attendance is '출결';

-- member samlpe 
INSERT INTO member (user_no, user_id, user_pwd, user_name, email, phone, gender, age, address, enroll_date, user_level, pt, status, api, qr, profile_pic, membership)
VALUES
(seq_mno.nextval, 'user01', 'Password!1', '김민수', 'minsu.kim@example.com', '01012345678', 'M', 25, '서울시 강남구 123', SYSDATE, 1, 'Trainer A', 'Y', 'api_key_1', 'qr_code_path_1', 'profile_pic_path_1', 'Gold Membership');
INSERT INTO member (user_no, user_id, user_pwd, user_name, email, phone, gender, age, address, enroll_date, user_level, pt, status, api, qr, profile_pic, membership)
VALUES
(seq_mno.nextval, 'user02', 'SecurePassword2!', '이수진', 'sujin.lee@example.com', '01098765432', 'F', 30, '부산시 해운대구 456', SYSDATE, 2, 'Trainer B', 'Y', 'api_key_2', 'qr_code_path_2', 'profile_pic_path_2', 'Silver Membership');
INSERT INTO member (user_no, user_id, user_pwd, user_name, email, phone, gender, age, address, enroll_date, user_level, pt, status, api, qr, profile_pic, membership)
VALUES
(seq_mno.nextval, 'user03', 'StrongPwd3$', '박지현', 'jihyun.park@example.com', '01045678910', 'F', 28, '대전시 유성구 789', SYSDATE, 2, 'Trainer C', 'Y', 'api_key_3', 'qr_code_path_3', 'profile_pic_path_3', 'Platinum Membership');

commit;
-- schedule table --
drop table schedule;
CREATE TABLE SCHEDULE (
    SCHEDULE_NO NUMBER NOT NULL,                 -- 스케줄 고유번호
    USER_NO NUMBER NOT NULL references member(user_no) , -- 스케줄 보유회원아이디
    SCHEDULE_TITLE VARCHAR2(100),                -- 스케줄이름
    SCHEDULE_DES VARCHAR2(3000),                 -- 스케줄 내용
    START_DATE varchar2(100),                  -- 시작 날짜
    END_DATE varchar2(100),                     -- 종료날짜
    DOW VARCHAR2(30),                             -- 요일                              
    back_color varchar2(30),                    -- 배경색
    allday varchar2(10)                         -- 종일 일정 여부
);
drop sequence seq_cno;
create sequence seq_cno nocache;

COMMENT ON COLUMN SCHEDULE.SCHEDULE_NO IS '스케줄 고유번호';
COMMENT ON COLUMN SCHEDULE.USER_NO IS '스케줄 보유회원 아이디';
COMMENT ON COLUMN SCHEDULE.SCHEDULE_TITLE IS '스케줄 이름';
COMMENT ON COLUMN SCHEDULE.SCHEDULE_DES IS '스케줄 내용';
COMMENT ON COLUMN SCHEDULE.START_DATE IS '시작 날짜';
COMMENT ON COLUMN SCHEDULE.END_DATE IS '종료 날짜';
COMMENT ON COLUMN SCHEDULE.DOW IS '요일';
COMMENT ON COLUMN SCHEDULE.BACK_COLOR IS '배경색';
COMMENT ON COLUMN SCHEDULE.ALIDAY IS '종일 일정 여부';

drop table qrInfo;
create table qrInfo (
    qr_no number constraint qr_pk PRIMARY key,
    id varchar2(30),
	type varchar2(30),
	created_at varchar2(100),
	valid_until varchar2(100),
	attendance varchar2(30),
	status varchar2(30) DEFAULT 'Y', -- 유효 여부
    att_status varchar2(30) -- 출결 상태
)
;

drop sequence seq_qno;
create sequence seq_qno nocache;

COMMENT ON COLUMN qrInfo.qr_no IS 'QR 코드 고유 번호';
COMMENT ON COLUMN qrInfo.id IS '사용자 ID';
COMMENT ON COLUMN qrInfo.type IS '사용자 타입';
COMMENT ON COLUMN qrInfo.created_at IS '생성 일시';
COMMENT ON COLUMN qrInfo.valid_until IS '유효 기간';
COMMENT ON COLUMN qrInfo.attendance IS '출석 정보';
COMMENT ON COLUMN qrInfo.status IS '유효 여부 (기본값: Y)';
COMMENT ON COLUMN qrInfo.att_status IS '출결 상태';

-- 회원추가정보 테이블
CREATE TABLE MEMBER_INFO(
    USER_NO NUMBER PRIMARY KEY, --회원번호
    HEIGHT NUMBER, --회원키
    WEIGHT NUMBER, --몸무게
    DISEASE VARCHAR2(100), --기저질환
    GOAL VARCHAR2(100), --운동목표
    CONSTRAINT FK_USER_NO FOREIGN KEY (USER_NO) REFERENCES MEMBER(USER_NO) ON DELETE CASCADE 
);
COMMENT ON COLUMN MEMBER_INFO.USER_NO IS '회원번호';
COMMENT ON COLUMN MEMBER_INFO.HEIGHT IS '회원키';
COMMENT ON COLUMN MEMBER_INFO.WEIGHT IS '몸무게';
COMMENT ON COLUMN MEMBER_INFO.DISEASE IS '기저질환';
COMMENT ON COLUMN MEMBER_INFO.GOAL IS '운동목표';
<<<<<<< HEAD
=======

------추가 테이블

-- 회원권 테이블
CREATE TABLE MEMBERSHIP (
	MEMBERSHIP_NO NUMBER CONSTRAINT PK_MEMBERSHIP PRIMARY KEY,
	MEMBERSHIP_LEVEL NUMBER DEFAULT 0 NOT NULL,
	MEMBERSHIP_NAME	VARCHAR2(30) NOT NULL,
	MEMBERSHIP_PERIOD VARCHAR2(30) NOT NULL,
	MEMBERSHIP_DESC	varchar2(3000) NULL
);

COMMENT ON COLUMN MEMBERSHIP.MEMBERSHIP_NO IS '회원권 고유번호';

COMMENT ON COLUMN MEMBERSHIP.MEMBERSHIP_LEVEL IS '0 : 없음 1: 낮은 회원권 2: 중간 회원권 3: 높은 회원권';

COMMENT ON COLUMN MEMBERSHIP.MEMBERSHIP_NAME IS '회원권 이름';

COMMENT ON COLUMN MEMBERSHIP.MEMBERSHIP_PERIOD IS '회원권 기간';

COMMENT ON COLUMN MEMBERSHIP.MEMBERSHIP_DESC IS '회원권 설명';

-- 회원권 고유번호 생성 시퀀스
CREATE SEQUENCE SEQ_MEMBERSHIP NOCACHE;


-- 회원권 신청 테이블
CREATE TABLE MEMBER_APPLICATION (
    APPLICATION_NO NUMBER CONSTRAINT PK_MEMBER_APPLICATION PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    MEMBERSHIP_NO NUMBER NOT NULL,
    APPLICATION_DATE DATE DEFAULT SYSDATE NOT NULL,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT FK_USER_TO_MEMBER FOREIGN KEY (USER_NO) REFERENCES MEMBER (USER_NO),
    CONSTRAINT FK_MEMBERSHIP_TO_MEMBER FOREIGN KEY (MEMBERSHIP_NO) REFERENCES MEMBERSHIP(MEMBERSHIP_NO)
);

COMMENT ON COLUMN MEMBER_APPLICATION.APPLICATION_NO IS '신청 기록 고유 번호';
COMMENT ON COLUMN MEMBER_APPLICATION.USER_NO IS '회원번호';
COMMENT ON COLUMN MEMBER_APPLICATION.MEMBERSHIP_NO IS '회원권 고유번호';
COMMENT ON COLUMN MEMBER_APPLICATION.APPLICATION_DATE IS '신청 날짜';
COMMENT ON COLUMN MEMBER_APPLICATION.STATUS IS '기간 만료 ''N''';


-- 회원권 신청 고유번호 생성 시퀀스
CREATE SEQUENCE SEQ_MEMBERSHIP_APPLICATION NOCACHE;

-- 트레이너 매칭 테이블
CREATE TABLE TRAINER_MATCHING (
    MATCHING_NO NUMBER CONSTRAINT PK_TRAINER_MATCHING PRIMARY KEY NOT NULL,
    USER_NO NUMBER NOT NULL,
    TRAINER_NO NUMBER NOT NULL,
    CONSTRAINT FK_USER_TO_TRAINER_MATCHING FOREIGN KEY (USER_NO) REFERENCES MEMBER (USER_NO),
    CONSTRAINT FK_TRAINER_TO_TRAINER_MATCHING FOREIGN KEY (TRAINER_NO) REFERENCES TRAINER_INFO (USER_NO)
);

COMMENT ON COLUMN TRAINER_MATCHING.MATCHING_NO IS '매칭기록고유번호';
COMMENT ON COLUMN TRAINER_MATCHING.USER_NO IS '회원번호';
COMMENT ON COLUMN TRAINER_MATCHING.TRAINER_NO IS '트레이너번호';

-- 트레이너 매칭 시퀀스

CREATE SEQUENCE SEQ_TRAINER_MATCHING NOCACHE;

drop table trainerinfo;
--- 트레이너 정보
CREATE TABLE trainerInfo (
    user_no NUMBER NOT NULL,                     -- 회원번호
    tr_career NUMBER,                            -- 경력 년수
    tr_certi varchar2(100),                      -- 자격 사항
    tr_profile VARCHAR2(300),                    -- 프로필 경로+파일명
    tr_descript varchar2(1000)                   -- 간략 소개
);

drop sequence seq_trainer_info;


>>>>>>> 0a7998ddf659c2159ef1594c24f904508cb294a9
