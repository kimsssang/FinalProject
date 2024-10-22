INSERT INTO member (user_no, user_id, user_pwd, user_name, email, phone, gender, age, address, enroll_date, user_level, pt, status, api, qr, profile_pic, membership)
VALUES
(seq_mno.nextval, 'user01', 'Password!1', 'ï¿½ï¿½Î¼ï¿?', 'minsu.kim@example.com', '01012345678', 'M', 25, 'ï¿½ï¿½ï¿½ï¿½ï¿? ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ 123', SYSDATE, 1, 'Trainer A', 'Y', 'api_key_1', 'qr_code_path_1', 'profile_pic_path_1', 'Gold Membership');
INSERT INTO member (user_no, user_id, user_pwd, user_name, email, phone, gender, age, address, enroll_date, user_level, pt, status, api, qr, profile_pic, membership)
VALUES
(seq_mno.nextval, 'user02', 'SecurePassword2!', 'ï¿½Ì¼ï¿½ï¿½ï¿½', 'sujin.lee@example.com', '01098765432', 'F', 30, 'ï¿½Î»ï¿½ï¿? ï¿½Ø¿ï¿½ë±? 456', SYSDATE, 2, 'Trainer B', 'Y', 'api_key_2', 'qr_code_path_2', 'profile_pic_path_2', 'Silver Membership');
INSERT INTO member (user_no, user_id, user_pwd, user_name, email, phone, gender, age, address, enroll_date, user_level, pt, status, api, qr, profile_pic, membership)
VALUES
(seq_mno.nextval, 'user03', 'StrongPwd3$', 'ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½', 'jihyun.park@example.com', '01045678910', 'F', 28, 'ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ 789', SYSDATE, 2, 'Trainer C', 'Y', 'api_key_3', 'qr_code_path_3', 'profile_pic_path_3', 'Platinum Membership');

commit;

INSERT 
		  INTO member 
		     ( user_no
		     , user_id
		     , user_pwd
		     , user_name
		     , email
		     , phone
		     , gender
		     , age
		     , address
		     , user_level
		     , qr
		     )
        VALUES
        	 (
        	   seq_mno.nextval
        	 , #{userId}
        	 , #{userPwd}
        	 , #{userName}
        	 , #{email}
        	 , #{phone}
        	 , #{gender}
        	 , #{age}
        	 , #{address}
        	 , #{userLevel} 
        	 , 'qr_code_path_1'
        	 )
             ;
select schedule_no
		     , schedule_title
		     , start_date
		     , end_date
		  from schedule
		 where user_no = 4;             
         
select count(schedule_no)
		  from schedule
		 where schedule_title = 'ï¿½ï¿½ï¿½ï¿½ï¿½ß°ï¿½'
		   or start_date = '2024-10-15T04:21:00.000Z'
           ;
select count(qr_no)
		  from qrinfo
		 where status = 'Y'
		   and id = 'qrtest01'
           and to_timestamp(created_at, 'YYYY-MM-DD"T"HH24:MI:SS.FF') between
           to_timestamp('2024-10-08T16:40:43.6181094', 'YYYY-MM-DD"T"HH24:MI:SS.FF') and
           to_timestamp('2025-10-08T16:40:43.6191067', 'YYYY-MM-DD"T"HH24:MI:SS.FF')
           ;
           
select qr_no
		     , id
		     , type
		     , created_at
		     , valid_until
		     , attendance
		     , att_status
		  from qrinfo
		 where status = 'Y'
		   and id = 'qrtest01'
           and to_timestamp(created_at, 'YYYY-MM-DD"T"HH24:MI:SS.FF') between
           to_timestamp('2024-10-08T16:40:43.6181094', 'YYYY-MM-DD"T"HH24:MI:SS.FF') and
           to_timestamp('2025-10-08T16:40:43.6181094', 'YYYY-MM-DD"T"HH24:MI:SS.FF')
           ;

update qrinfo
   set attendance = to_timestamp(sysdate,'YYYY-MM-DD"T"HH24:MI:SS.FF')
     , att_status = 'ï¿½â¼®'
 where id = 'qrtest02'
 ;
 
 commit;
 
select qr_no
		     , id
		     , type
		     , created_at
		     , valid_until
		     , attendance
		     , att_status
		  from qrinfo
		 where status = 'Y'
		   and id = 'qrtest01'
           and to_timestamp('2024-10-08T17:10:10.776433', 'YYYY-MM-DD"T"HH24:MI:SS.FF') between
           to_timestamp('2024-10-08T17:10:10.776433', 'YYYY-MM-DD"T"HH24:MI:SS.FF') and
           to_timestamp('2025-10-08T16:40:43.6191067', 'YYYY-MM-DD"T"HH24:MI:SS.FF') 
           ;
           
insert 
  into trainerinfo
     (
       tr_info_no
     , user_no
     , tr_career
     , tr_certi
     , tr_profile
     , tr_descript
     )
values
     (
       seq_trainer_info.nextval
     , 4
     , 5
     , 'ï¿½ï¿½È¸ ï¿½ï¿½ï¿?'
     , 'resources/trProfilePic/jang.jpg'
     , 'ï¿½ßºï¿½Å¹ï¿½å¸³ï¿½Ï´ï¿½'
     )
     ;
     
insert 
  into schedule
     (
       schedule_no
     , user_no
     , schedule_title
     , start_date
     , end_date
     , back_color
     , pt_user
     )
values
     (
       seq_cno.nextval
     , '4'
     , 'È¸ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½×½ï¿½Æ®22'
     , '2024-10-22T08:16:00.000Z'
     , '2024-10-23T08:17:00.000Z'
     , 'red'
     , 'noinfo'
     )     
;

	select schedule_no
		     , schedule_title
		     , start_date
		     , end_date
		     , back_color
		  from schedule
		 where user_no = 4
		   and pt_user = 'noinfo'
           ;
           
           select schedule_no
		     , schedule_title
		     , start_date
		     , end_date
		     , back_color
             , pt_user
		  from schedule
		 where user_no = 4
		   and pt_user is null
           ;
select count(schedule_no)
		  from schedule
		 where schedule_title = #{scheduleTitle}
		   and start_date = #{startDate}
		   and user_no = #{userNo}
           ;
           
SELECT *FROM MEMBER m
		JOIN BODY_INFO b ON m.USER_ID = b.USER_ID
		JOIN MEMBER_INFO mi ON m.USER_NO = mi.USER_NO
		WHERE m.STATUS = 'Y'
			AND b.BI_STATUS = 'Y'
			AND m.PT = 'jang10'
			AND b.MEASURE_DATE = (
				SELECT MAX(MEASURE_DATE)
				FROM BODY_INFO
				WHERE USER_ID = m.USER_ID
				AND BI_STATUS = 'Y'
			)           
;
select count(schedule_no)
		  from schedule
		 where schedule_title = 'test'
		   and start_date = '2024-10-27T00:00:00.000Z'
		   and user_no = 30
           ;

select count(schedule_no)
		  from schedule
		 where schedule_title = 'ÀÏÁ¤ 1'
		   and start_date = '2024-10-21T00:00:00.00Z'
		   and user_no = '30'
;

select schedule_no
		     , schedule_title
		     , schedule_des
		     , start_date
		     , end_date
		     , back_color
		     , allday
		  from schedule
		 where user_no = '4'
		   and pt_user = 'noinfo'
           ;