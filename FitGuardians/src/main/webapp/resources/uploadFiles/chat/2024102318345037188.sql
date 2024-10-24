--DB ��ũ��Ʈ

-----------------����------------------
--���������� ������̺� �� �������� ����
BEGIN
    FOR C IN (SELECT TABLE_NAME FROM USER_TABLES) LOOP
    EXECUTE IMMEDIATE ('DROP TABLE '||C.TABLE_NAME||' CASCADE CONSTRAINTS');
    END LOOP;
END;
/
--���������� ��� ������ ����
BEGIN
FOR C IN (SELECT * FROM USER_SEQUENCES) LOOP
  EXECUTE IMMEDIATE 'DROP SEQUENCE '||C.SEQUENCE_NAME;
END LOOP;
END;
/
--���������� ��� �� ����
BEGIN
FOR C IN (SELECT * FROM USER_VIEWS) LOOP
  EXECUTE IMMEDIATE 'DROP VIEW '||C.VIEW_NAME;
END LOOP;
END;
/
--���������� ��� Ʈ���� ����
BEGIN
FOR C IN (SELECT * FROM USER_TRIGGERS) LOOP
  EXECUTE IMMEDIATE 'DROP TRIGGER '||C.TRIGGER_NAME;
END LOOP;
END;
/

------------------------------- ���� ���̺�---------------------------------------
CREATE TABLE MEMBER (
    USER_NO NUMBER NOT NULL CONSTRAINT PK_MEMBER PRIMARY KEY,  -- ȸ����ȣ
    USER_ID VARCHAR2(30) NOT NULL,  -- ȸ�����̵�
    USER_PWD VARCHAR2(100) NOT NULL,  -- ȸ����й�ȣ
    USER_NAME VARCHAR2(30) NOT NULL,  -- ȸ���̸�
    EMAIL VARCHAR2(100) NOT NULL,  -- �̸���
    PHONE VARCHAR2(13),  -- ��ȭ��ȣ
    GENDER VARCHAR2(1),  -- ����
    AGE NUMBER,  -- ����
    ADDRESS VARCHAR2(100),  -- �ּ�
    ENROLL_DATE DATE DEFAULT SYSDATE,  -- ������
    USER_LEVEL NUMBER,  -- 1 Ʈ���̳�, 2ȸ��
    PT VARCHAR2(30),  -- ���Ʈ���̳�
    STATUS VARCHAR2(1) DEFAULT 'Y',  -- ���� (Y, N)
    API VARCHAR2(100),  -- API �α��� Ű
    QR VARCHAR2(300) NOT NULL,  -- QR�ڵ� �߱� �� ���� ���
    PROFILE_PIC VARCHAR2(300),  -- ȸ�� ������ ����
    MEMBERSHIP VARCHAR2(30),  -- ȸ���� ������ ȸ����
    PT_TIME NUMBER DEFAULT 0 NOT NULL -- PTȽ��
);

COMMENT ON COLUMN MEMBER.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.USER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.USER_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.GENDER IS '����';
COMMENT ON COLUMN MEMBER.AGE IS '����';
COMMENT ON COLUMN MEMBER.ADDRESS IS '�ּ�';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '������';
COMMENT ON COLUMN MEMBER.USER_LEVEL IS '1 Ʈ���̳�, 2ȸ��';
COMMENT ON COLUMN MEMBER.PT IS '���Ʈ���̳�';
COMMENT ON COLUMN MEMBER.STATUS IS 'Y, N';
COMMENT ON COLUMN MEMBER.API IS 'API �α��� Ű';
COMMENT ON COLUMN MEMBER.QR IS 'QR�ڵ� �߱� �� ���� ���';
COMMENT ON COLUMN MEMBER.PROFILE_PIC IS 'ȸ�� ������ ����';
COMMENT ON COLUMN MEMBER.MEMBERSHIP IS 'ȸ���� ������ ȸ����';

--ALTER TABLE member
--ADD pt_time NUMBER DEFAULT 0 NOT NULL;

-- ���� ��ȣ ������
CREATE SEQUENCE SEQ_MNO NOCACHE;

-----------------------------��ü��ȭ����----------------------------------------------
CREATE TABLE BODY_INFO (
    BODY_INFO_NO NUMBER NOT NULL,   -- ��ü��ȭ ������ȣ
    USER_ID VARCHAR(300) NOT NULL,               -- ȸ�����̵�
    MEASURE_DATE DATE DEFAULT SYSDATE NOT NULL,  -- ������
    BMI NUMBER,                                  -- BMI
    FAT NUMBER,                               -- ü���淮
    SMM NUMBER,                                -- ��ݱٷ�
    BI_STATUS VARCHAR2(1) DEFAULT 'Y'                             -- ����(Y,N)
);

COMMENT ON COLUMN BODY_INFO.BODY_INFO_NO IS '��ü��ȭ��ȣ';
COMMENT ON COLUMN BODY_INFO.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN BODY_INFO.MEASURE_DATE IS '������';
COMMENT ON COLUMN BODY_INFO.BMI IS 'ü��������';
COMMENT ON COLUMN BODY_INFO.FAT IS 'ü���淮';
COMMENT ON COLUMN BODY_INFO.SMM IS '��ݱٷ�';
COMMENT ON COLUMN BODY_INFO.BI_STATUS IS '����(Y,N)';

CREATE SEQUENCE SEQ_BF_NO NOCACHE;

----------------------------------ȸ�� �߰� ����-----------------------------------
-- ȸ���߰����� ���̺�
CREATE TABLE MEMBER_INFO(
    USER_NO NUMBER PRIMARY KEY, --ȸ����ȣ
    HEIGHT NUMBER, --ȸ��Ű
    WEIGHT NUMBER, --������
    DISEASE VARCHAR2(100), --������ȯ
    GOAL VARCHAR2(100), --���ǥ
    CONSTRAINT FK_USER_NO FOREIGN KEY (USER_NO) REFERENCES MEMBER(USER_NO) ON DELETE CASCADE 
);
COMMENT ON COLUMN MEMBER_INFO.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER_INFO.HEIGHT IS 'ȸ��Ű';
COMMENT ON COLUMN MEMBER_INFO.WEIGHT IS '������';
COMMENT ON COLUMN MEMBER_INFO.DISEASE IS '������ȯ';
COMMENT ON COLUMN MEMBER_INFO.GOAL IS '���ǥ';

---------------------------�⼮ sql-------------------------------------

create table qrInfo (
    qr_no number constraint qr_pk PRIMARY key,
    id varchar2(30),
   type varchar2(30),
   created_at varchar2(100),
   valid_until varchar2(100),
   attendance varchar2(30),
   status varchar2(30) DEFAULT 'Y', -- ��ȿ ����
    att_status varchar2(30) -- ��� ����
);

create sequence seq_qno nocache;

COMMENT ON COLUMN qrInfo.qr_no IS 'QR �ڵ� ���� ��ȣ';
COMMENT ON COLUMN qrInfo.id IS '����� ID';
COMMENT ON COLUMN qrInfo.type IS '����� Ÿ��';
COMMENT ON COLUMN qrInfo.created_at IS '���� �Ͻ�';
COMMENT ON COLUMN qrInfo.valid_until IS '��ȿ �Ⱓ';
COMMENT ON COLUMN qrInfo.attendance IS '�⼮ ����';
COMMENT ON COLUMN qrInfo.status IS '��ȿ ���� (�⺻��: Y)';
COMMENT ON COLUMN qrInfo.att_status IS '��� ����';


----------------------------�Ĵ� sql---------------------------------------

--�Ĵ� sql

create table mealPlan(
    send_id varchar2(50) not null,
    get_id varchar2(50) not null,
    food_code varchar2(30) ,
    food_name varchar2(50),
    carbs number ,
    fat number,
    protein number,
    kcal number,
    sugar number,
    meal_date varchar2(30),
    meal_msg VARCHAR2(500),
    meal_remsg VARCHAR2(500),
    msg_type VARCHAR2(5)
    );
      
COMMENT ON COLUMN mealPlan.send_USER is '���� ���� ��ȣ';
COMMENT ON COLUMN mealPlan.get_no is '�޴� ȸ�� ��ȣ';
COMMENT ON COLUMN mealPlan.food_code is '���� �ڵ�';
COMMENT ON COLUMN mealPlan.food_name is '���ĸ�';
COMMENT ON COLUMN mealPlan.carbs is 'ź��ȭ��';
COMMENT ON COLUMN mealPlan.fat is '����';
COMMENT ON COLUMN mealPlan.protein is '�ܹ���';
COMMENT ON COLUMN mealPlan.kcal is 'Į�θ�';
COMMENT ON COLUMN mealPlan.sugar is '���';
COMMENT ON COLUMN mealPlan.meal_date is '�Ĵ� ��¥';
COMMENT ON COLUMN mealPlan.meal_msg is '�Ĵ� �Ѹ���';
COMMENT ON COLUMN mealPlan.meal_remsg is '�Ĵ� ����';
COMMENT ON COLUMN mealPlan.msg_type is '�Ĵ� ������������(Ʈ���̳� T ȸ�� S)';

---------------------� ���� SCRIPT------------------------------------
-- AI �÷�

CREATE TABLE EXERCISE_PLAN (
    AI_EXERCISE_NO NUMBER NOT NULL CONSTRAINT PK_EXERCISE_PLAN PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    EXERCISE_GOAL VARCHAR2(300) NULL,
    FITNESS_LEVEL VARCHAR2(30) NULL,
    EXERCISE_TYPE VARCHAR2(300) NULL,
    EQUIPMENT VARCHAR2(300) NULL,
    HEALTH_CONDITION VARCHAR2(300) NULL,
    DAYS_PER_WEEK NUMBER NULL,
    DURATION NUMBER NULL,
    PLAN_DURATION_WEEK NUMBER NULL
);

COMMENT ON COLUMN EXERCISE_PLAN.AI_EXERCISE_NO IS 'AI �÷� ��ȣ';
COMMENT ON COLUMN EXERCISE_PLAN.USER_NO IS 'ȸ�� ��ȣ';
COMMENT ON COLUMN EXERCISE_PLAN.EXERCISE_GOAL IS '� ����';
COMMENT ON COLUMN EXERCISE_PLAN.FITNESS_LEVEL IS '� ����';
COMMENT ON COLUMN EXERCISE_PLAN.EXERCISE_TYPE IS '� ����';
COMMENT ON COLUMN EXERCISE_PLAN.EQUIPMENT IS '� ����';
COMMENT ON COLUMN EXERCISE_PLAN.HEALTH_CONDITION IS '���� ��ȯ';
COMMENT ON COLUMN EXERCISE_PLAN.DAYS_PER_WEEK IS '�ְ� � Ƚ��';
COMMENT ON COLUMN EXERCISE_PLAN.DURATION IS '� ���� �ð�';
COMMENT ON COLUMN EXERCISE_PLAN.PLAN_DURATION_WEEK IS '� �ְ�';

-- AI�÷� ������
CREATE SEQUENCE SEQ_AIEXPLAN_NO NOCACHE;

-- AI �
CREATE TABLE EXERCISE_SCHEDULE(
    AI_EXERCISE_NO NUMBER NOT NULL,
    EXERCISE_NAME VARCHAR2(300) NULL,
    EQUIPMENT VARCHAR2(300) NULL,
    DURATION NUMBER NULL,
    SETS NUMBER NULL,
    CONSTRAINT FK_EXERCISE_SCHEDULE FOREIGN KEY(AI_EXERCISE_NO) REFERENCES EXERCISE_PLAN(AI_EXERCISE_NO)
);

-- Ʈ���̳� �÷�
CREATE TABLE WORKOUT (
    EX_NO NUMBER NOT NULL CONSTRAINT PK_WORKOUT PRIMARY KEY, -- � ��ȣ
    USER_ID VARCHAR2(300) NOT NULL, -- ȸ�� ��ȣ
    WORKOUT_TITLE VARCHAR2(3000) NULL, -- � ����
    WORKOUT_DATE DATE DEFAULT SYSDATE NULL, -- ���
    WORKOUT_CATEGORY CHAR(3) NULL, -- � ���� (��ü: UE, ����: ABS, ��ü: LE)
    DIFFICULTY CHAR(1) NULL, -- � ���̵� ���� (L: ����, M: �߰�, H: ����)
    DESCRIPTION VARCHAR2(3000) NULL, -- � ����
    WORKOUT_STATUS CHAR(1) DEFAULT 'Y' NULL
);

COMMENT ON COLUMN WORKOUT.EX_NO IS '���ȣ';
COMMENT ON COLUMN WORKOUT.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN WORKOUT.WORKOUT_TITLE IS '� ����';
COMMENT ON COLUMN WORKOUT.WORKOUT_DATE IS '���';
COMMENT ON COLUMN WORKOUT.WORKOUT_CATEGORY IS '�����(��ü: UE, ����: ABS, ��ü: LE)';
COMMENT ON COLUMN WORKOUT.DIFFICULTY IS '����̵� ����(L: ����, M: �߰�, H: ����)';
COMMENT ON COLUMN WORKOUT.DESCRIPTION IS '� ����';
COMMENT ON COLUMN WORKOUT.WORKOUT_STATUS IS '� ������ ���� ����(Y: ���� N:������)';

-- Ʈ���̳� �÷� ������
CREATE SEQUENCE SEQ_WORKOUT_EX_NO NOCACHE;

-- ȸ�� ���� �Է� ���̺�
CREATE TABLE TN_WORKOUT(
    EX_NO NUMBER NOT NULL CONSTRAINT PK_TN_WORKOUT PRIMARY KEY, -- � ��ȣ
    USER_ID VARCHAR2(300) NOT NULL, -- ȸ�� ��ȣ
    WORKOUT_TITLE VARCHAR2(3000) NULL, -- � ����
    WORKOUT_DATE DATE DEFAULT SYSDATE NULL, -- ���
    WORKOUT_TARGET VARCHAR2(3000) NULL, -- � ���� (ȸ���� �����Ӱ� �ۼ�)
    DIFFICULTY CHAR(1) NULL, -- � ���̵� ���� (L: ����, M: �߰�, H: ����)
    DESCRIPTION VARCHAR2(3000) NULL, -- � ����
    WORKOUT_STATUS CHAR(1) DEFAULT 'Y' NULL
);

COMMENT ON COLUMN TN_WORKOUT.EX_NO IS '���ȣ';
COMMENT ON COLUMN TN_WORKOUT.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN TN_WORKOUT.WORKOUT_TITLE IS '� ����';
COMMENT ON COLUMN TN_WORKOUT.WORKOUT_DATE IS '���';
COMMENT ON COLUMN TN_WORKOUT.WORKOUT_TARGET IS '� ǥ��(ȸ���� �����Ӱ� �ۼ�)';
COMMENT ON COLUMN TN_WORKOUT.DIFFICULTY IS '����̵� ����(L: ����, M: �߰�, H: ����)';
COMMENT ON COLUMN TN_WORKOUT.DESCRIPTION IS '� ����';
COMMENT ON COLUMN TN_WORKOUT.WORKOUT_STATUS IS '� ������ ���� ����(Y: ���� N:������)';

-- ȸ���� �ۼ��� �÷� ������
CREATE SEQUENCE SEQ_TN_WORKOUT_EX_NO NOCACHE;

----------------------------�����-----------------------------------------------
-- ȸ���� ���̺� 

CREATE TABLE MEMBERSHIP (
   MEMBERSHIP_NO NUMBER CONSTRAINT PK_MEMBERSHIP PRIMARY KEY,
   MEMBERSHIP_LEVEL NUMBER DEFAULT 0 NOT NULL,
   MEMBERSHIP_NAME   VARCHAR2(30) NOT NULL,
   MEMBERSHIP_PERIOD VARCHAR2(30) NOT NULL,
   MEMBERSHIP_DESC   varchar2(3000) NULL
);

COMMENT ON COLUMN MEMBERSHIP.MEMBERSHIP_NO IS 'ȸ���� ������ȣ';
COMMENT ON COLUMN MEMBERSHIP.MEMBERSHIP_LEVEL IS '0 : ���� 1: ���� ȸ���� 2: �߰� ȸ���� 3: ���� ȸ����';
COMMENT ON COLUMN MEMBERSHIP.MEMBERSHIP_NAME IS 'ȸ���� �̸�';
COMMENT ON COLUMN MEMBERSHIP.MEMBERSHIP_PERIOD IS 'ȸ���� �Ⱓ';
COMMENT ON COLUMN MEMBERSHIP.MEMBERSHIP_DESC IS 'ȸ���� ����';

-- ȸ���� ������ȣ ���� ������
CREATE SEQUENCE SEQ_MEMBERSHIP NOCACHE;

-- ȸ���� ��û ���̺�
CREATE TABLE MEMBER_APPLICATION (
    APPLICATION_NO NUMBER CONSTRAINT PK_MEMBER_APPLICATION PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    MEMBERSHIP_NO NUMBER NOT NULL,
    APPLICATION_DATE DATE DEFAULT SYSDATE NOT NULL,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT FK_USER_TO_MEMBER FOREIGN KEY (USER_NO) REFERENCES MEMBER (USER_NO),
    CONSTRAINT FK_MEMBERSHIP_TO_MEMBER FOREIGN KEY (MEMBERSHIP_NO) REFERENCES MEMBERSHIP(MEMBERSHIP_NO)
);

COMMENT ON COLUMN MEMBER_APPLICATION.APPLICATION_NO IS '��û ��� ���� ��ȣ';
COMMENT ON COLUMN MEMBER_APPLICATION.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER_APPLICATION.MEMBERSHIP_NO IS 'ȸ���� ������ȣ';
COMMENT ON COLUMN MEMBER_APPLICATION.APPLICATION_DATE IS '��û ��¥';
COMMENT ON COLUMN MEMBER_APPLICATION.STATUS IS '�Ⱓ ���� ''N''';


-- ȸ���� ��û ������ȣ ���� ������
CREATE SEQUENCE SEQ_MEMBERSHIP_APPLICATION NOCACHE;

----------------------------ä�ù�----------------------------------------------
CREATE TABLE CHAT_ROOM (
   CH_NO NUMBER CONSTRAINT CHNO_PK   PRIMARY KEY,
   USER_NO   NUMBER REFERENCES MEMBER NOT NULL,
   TRAINER_NO NUMBER REFERENCES MEMBER NOT NULL,
   CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
   STATUS CHAR(1) DEFAULT 'Y' CHECK(STATUS IN ('Y','N'))
);

COMMENT ON COLUMN CHAT_ROOM.CH_NO IS 'ä�ù��ȣ';
COMMENT ON COLUMN CHAT_ROOM.USER_NO IS '�������̺�����ȸ��';
COMMENT ON COLUMN CHAT_ROOM.TRAINER_NO IS '�������̺�����Ʈ���̳�';
CREATE SEQUENCE SEQ_CHNO NOCACHE;

----------------------------�޽���--------------------------------------------
-- �޽��� ���̺�
CREATE TABLE MESSAGE (
    MSG_NO NUMBER NOT NULL CONSTRAINT PK_MESSAGE PRIMARY KEY,
    MSG_CONTENT VARCHAR2(4000) NOT NULL,
    SEND_DATE DATE DEFAULT SYSDATE NOT NULL,
    CH_NO NUMBER NOT NULL,
    SENDER_NO NUMBER NOT NULL,
    RECEIVER_NO NUMBER NOT NULL,
    MSG_STATUS CHAR(1) DEFAULT 'U' NOT NULL CHECK (MSG_STATUS IN ('U', 'R', 'D', 'E')),
    CONSTRAINT FK_CHATROOM_TO_MESSAGE FOREIGN KEY (CH_NO) REFERENCES CHAT_ROOM (CH_NO),
    CONSTRAINT FK_SENDER_TO_MESSAGE FOREIGN KEY (SENDER_NO) REFERENCES MEMBER (USER_NO),
    CONSTRAINT FK_RECEIVER_TO_MESSAGE FOREIGN KEY (RECEIVER_NO) REFERENCES MEMBER (USER_NO)
);

COMMENT ON COLUMN MESSAGE.MSG_NO IS '�޽�����ȣ';
COMMENT ON COLUMN MESSAGE.MSG_CONTENT IS '�޽�������';
COMMENT ON COLUMN MESSAGE.SEND_DATE IS '�޽���������¥';
COMMENT ON COLUMN MESSAGE.CH_NO IS 'ä�ù��ȣ';
COMMENT ON COLUMN MESSAGE.SENDER_NO IS '�߽���';
COMMENT ON COLUMN MESSAGE.RECEIVER_NO IS '������';
COMMENT ON COLUMN MESSAGE.MSG_STATUS IS '�޽�������(U: ���� ����, R: ����, D: ��޵�, E: ����)';

CREATE SEQUENCE SEQ_MESSAGE_NO NOCACHE;

----------------------------ȸ�� ����----------------------------------------------
CREATE TABLE SCHEDULE (
    SCHEDULE_NO NUMBER NOT NULL,                 -- ������ ������ȣ
    USER_NO NUMBER NOT NULL references member(user_no) , -- ������ ����ȸ�����̵�(�ۼ���)
    pt_user varchar2(100) ,                                -- ������ ����� ������ ���� ��ĳ��
    SCHEDULE_TITLE VARCHAR2(100),                -- �������̸�
    SCHEDULE_DES VARCHAR2(3000),                 -- ������ ����
    START_DATE varchar2(100),                  -- ���� ��¥
    END_DATE varchar2(100),                     -- ���ᳯ¥
    DOW VARCHAR2(30),                             -- ����                              
    back_color varchar2(30),                    -- ����
    allday varchar2(10),                         -- ���� ���� ����
    kakao_calendar_id varchar2(100)		  -- īī�� Ķ���� �϶� id
);

COMMENT ON COLUMN SCHEDULE.SCHEDULE_NO IS '������ ������ȣ';
COMMENT ON COLUMN SCHEDULE.USER_NO IS '������ ����ȸ�� ���̵�';
COMMENT ON COLUMN SCHEDULE.SCHEDULE_TITLE IS '������ �̸�';
COMMENT ON COLUMN SCHEDULE.SCHEDULE_DES IS '������ ����';
COMMENT ON COLUMN SCHEDULE.START_DATE IS '���� ��¥';
COMMENT ON COLUMN SCHEDULE.END_DATE IS '���� ��¥';
COMMENT ON COLUMN SCHEDULE.DOW IS '����';
COMMENT ON COLUMN SCHEDULE.BACK_COLOR IS '����';
COMMENT ON COLUMN SCHEDULE.ALLDAY IS '���� ���� ����';
COMMENT ON COLUMN SCHEDULE.pt_user IS '��ĳ�� ����� ������ ����';
COMMENT ON COLUMN SCHEDULE.kakao_calendar_id IS '��ĳ�� ����� ������ ����';
create sequence seq_cno nocache;

----------------------------Ʈ���̳� ����-------------------------------------------
--- Ʈ���̳� ����
CREATE TABLE trainerInfo (
    user_no NUMBER NOT NULL,                     -- ȸ����ȣ
    tr_career NUMBER,                            -- ��� ���
    tr_certi varchar2(100),                      -- �ڰ� ����
    tr_profile VARCHAR2(300),                    -- ������ ���+���ϸ�
    tr_descript varchar2(1000)                   -- ���� �Ұ�
);

create sequence seq_trainer_info nocache;
--alter table trainerInfo drop column tr_info_no;

----------------------------------ä�� ����--------------------------------------
CREATE TABLE FILE_UPLOAD(
    FILE_NO NUMBER CONSTRAINT PK_FILE PRIMARY KEY, -- ���� ���� NO
    FILE_NAME VARCHAR2(255) NOT NULL, -- ����� ���� �̸�
    FILE_PATH VARCHAR2(4000) NOT NULL, -- ������ ���� ���
    UPLOADED_BY NUMBER NOT NULL, -- ������ ���ε��� ����� NO
    UPLOAD_DATE DATE DEFAULT SYSDATE NOT NULL, -- ���� ���ε� ��¥
    CONSTRAINT FK_MEMBER_TO_FILE FOREIGN KEY (UPLOADED_BY) REFERENCES MEMBER (USER_NO) ON DELETE CASCADE -- �ܷ� Ű ����
);

COMMENT ON COLUMN FILE_UPLOAD.FILE_NO IS '���Ϲ�ȣ';
COMMENT ON COLUMN FILE_UPLOAD.FILE_NAME IS '����� ���� �̸�';
COMMENT ON COLUMN FILE_UPLOAD.FILE_PATH IS '���ϰ��';
COMMENT ON COLUMN FILE_UPLOAD.UPLOADED_BY IS '������ ���ε��� �����';
COMMENT ON COLUMN FILE_UPLOAD.UPLOAD_DATE IS '���� ���ε� ��¥';

CREATE SEQUENCE SEQ_FILE_NO NOCACHE; -- ���� ��ȣ�� �ڵ����� �����ϱ� ���� ������

commit;