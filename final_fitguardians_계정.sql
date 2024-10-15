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
		 where schedule_title = '일정추가'
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
     , att_status = '출석'
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
<<<<<<< HEAD
           ;
=======
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
     , '대회 우승'
     , 'resources/trProfilePic/jang.jpg'
     , '잘부탁드립니다'
     )
     ;
     
>>>>>>> 0a7998ddf659c2159ef1594c24f904508cb294a9
