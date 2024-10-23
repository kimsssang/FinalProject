<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat Page</title>
    <!-- Bootstrap CSS 추가 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        .trainer {
            cursor: pointer; /* 클릭 가능하다는 느낌을 줌 */
            transition: background-color 0.3s; /* 부드러운 배경색 변화 */
        }

        .trainer:hover {
            background-color: #f8f9fa; /* 마우스 오버 시 배경색 변경 */
        
		}
		.trainer .card-body {
		    height: 200px;
		    width: 250px;
		}
		
		.trainer .card-body table {
		    border-collapse: separate;
		    border-spacing: 0 8px;
		    font-size: 16px;
		}

		.trainer .card-body td {
		    overflow: hidden;
		    white-space: nowrap;
		    text-overflow: ellipsis;
		    max-width: 140px; /* 필요에 따라 너비 조절 */
		}
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <jsp:include page="../common/sideTrainee.jsp"/>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <jsp:include page="../common/topBar.jsp"/>
                <div class="container-fluid">
                    <c:choose>
                        <c:when test="${not empty sessionScope.loginUser.userNo}">
                            <div class="card mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">트레이너 검색</h6>
                                </div>
                                <div class="card-body">
                                    <div class="input-group">
                                        <input type="text" id="trainerSearchInput" class="form-control" placeholder="트레이너 이름을 입력하세요." style="margin-right:10px">
                                        <button type="button" class="btn btn-primary ms-2" id="trainerSearchBtn">검색</button>
                                    </div>
                                    <div id="trainersContainer" style="display: flex; flex-wrap: wrap; gap: 10px; margin-top: 20px;"></div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-warning">로그인 후에 이용 가능합니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    

	<script>
	$(document).ready(function() {
	    $('#trainerSearchBtn').on('click', function() {
	        var keyword = $('#trainerSearchInput').val().trim(); // 검색어 가져오기
	
	        //if (keyword) {
	            $.ajax({
	                type: 'POST',
	                url: '/fitguardians/searchTrainers',
	                data: { keyword: keyword },
	                dataType: 'json',
	                success: function(response) {
	                    $('#trainersContainer').empty(); // 이전 검색 결과 삭제
	                    console.log(response);
	
	                    var trainersList = "";
	                    response.forEach(function(trainer) {
	                        trainersList += `<div class="card trainer" data-userno=\${trainer.userNo} data-name=\${trainer.userName}>
	                                        	<div class="card-header">
	                                        		<img src="\${trainer.profilePic}" alt="\${trainer.userName}" style="width: 210px; height: 200px;"/>
	                                        	</div>
	                                        	<div class="card-body">
	                                        		<table>
	                                        			<tr>
	                                        				<th>아이디 &nbsp;&nbsp;</th>
	                                        				<td>\${trainer.userId}</td>
	                                        			</tr>
	                                        			<tr>
		                                        			<th>이 &nbsp;&nbsp;름 &nbsp;&nbsp;</th>
	                                        				<td>\${trainer.userName}</td>
	                                        			</tr>
	                                        			<tr>
	                                        				<th>이메일 &nbsp;&nbsp;</th>
                                        					<td>\${trainer.email}</td>
	                                        			</tr>
	                                        			<tr>
	                                        				<th>핸드폰 &nbsp;&nbsp;</th>
                                        					<td>\${trainer.phone}</td>
	                                        			</tr>
	                                        		</table>
	                                        	</div>
	                                         </div>
	                                        `;
	                    });
	                    $("#trainersContainer").html(trainersList);
	
	                    // 트레이너 클릭 시 채팅방 존재 여부 확인 이벤트 리스너
	                    $('.trainer').on('click', function() {
	                        var trainerName = $(this).data('name'); // 트레이너 이름 가져오기
	                        var userNo = $(this).data('userno'); // 트레이너 유저 번호 가져오기
	
	                        // 채팅방 존재 여부 확인
	                        $.ajax({
	                            url: '/fitguardians/chat/exists', // 채팅방 존재 여부 확인 API 호출
	                            method: 'GET',
	                            data: {
	                                senderNo: currentUserNo,
	                                receiverNo: userNo
	                            },
	                            success: function(response) {
	                                if (response.exists) {
	                                    // 채팅방이 존재하면 모달 열기 및 메시지 로드
	                                    openChatModal(trainerName, userNo, response.chatRoomNo); // chatRoomNo 전달
	                                } else {
	                                    // 채팅방이 존재하지 않으면 새로 생성
	                                    $.ajax({
	                                        url: '/fitguardians/chat/create', // 채팅방 생성 API 호출
	                                        method: 'POST',
	                                        data: {
	                                            senderNo: currentUserNo,
	                                            receiverNo: userNo
	                                        },
	                                        success: function(chatRoomNo) {
	                                            // 생성된 채팅방 번호로 모달 열기
	                                            openChatModal(trainerName, userNo, chatRoomNo);
	                                        },
	                                        error: function(xhr, status, error) {
	                                            console.error("채팅방 생성 오류:", error);
	                                        }
	                                    });
	                                }
	                            },
	                            error: function(xhr, status, error) {
	                                console.error("채팅방 존재 여부 확인 실패:", error);
	                            }
	                        });
	                    });
	                },
	                error: function(xhr, status, error) {
	                    console.error("검색 요청 실패:", error);
	                }
	            });
	        //} else {
	          //  alert("검색어를 입력하세요.");
	        //}
	    });
	
	    // 엔터 키 이벤트 추가
	    $('#trainerSearchInput').on('keypress', function(event) {
	        if (event.which === 13) { // Enter 키 코드
	            $('#trainerSearchBtn').click(); // 버튼 클릭 이벤트 트리거
	            event.preventDefault(); // Enter 키로 인해 폼이 제출되는 것을 방지
	        }
	    });
	});
	</script>





</body>
</html>
