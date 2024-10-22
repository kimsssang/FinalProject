<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top Bar</title>
<c:if test="${not empty loginUser && not empty loginUser.api}">
	<!-- sweetalert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.all.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.min.css" rel="stylesheet">
	
	<!-- sumoselect -->
	<link rel="stylesheet" href="resources/css/sumoselect.css">
	<script defer src="resources/js/jquery.sumoselect.js"></script>
	
	<script src="resources/js/kakao.min.js"></script>
	
	<link rel="stylesheet" href="resources/css/topBar.css">
</c:if>

<style>
	/* 파일 링크 스타일 */
	.file-link {
	    color: black;
	    text-decoration: underline;
	    cursor: pointer;
	}
	
	/* 링크 호버 효과*/
	.file-link:hover {
	    color: #FFD700;
	}
	
	#weather {
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    font-size: 20px;
	    color: #333;
	    margin: 10px;
	    text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
	    font-family: 'Arial', sans-serif;
	    transition: all 0.3s ease;
	}
	
	#weather:hover {
	    color: #007BFF;
	    transform: scale(1.05);
	    
	}
</style>
</head>
<body>
<!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">
                    <div id="weather">날씨정보 가져와볼까?</div>
                    <div id="weather"></div>

					<script>
				    $(document).ready(function() {
				        if (navigator.geolocation) {
				            navigator.geolocation.getCurrentPosition(function(position) {
				                $.ajax({
				                    url: "https://api.openweathermap.org/data/2.5/weather?lat=" + position.coords.latitude + "&lon=" + position.coords.longitude + "&appid=26f63825b5ad487da0d03e384708dc2a&units=metric&lang=kr",
				                    method: 'GET',
				                    success: function(data) {
				                        const icon = data.weather[0].icon; // 날씨 아이콘 코드
				                        const iconUrl = "https://openweathermap.org/img/wn/" + icon + ".png"; // 아이콘 URL
				                        $('#weather').html('<img src="' + iconUrl + '" alt="' + data.weather[0].description + '">현재 위치의 날씨: ' + data.weather[0].description + ', 온도: ' + data.main.temp.toFixed(1) + '°C');
				                    },
				                    error: function() {
				                        $('#weather').text('날씨 정보를 불러오지 못했습니다.');
				                    }
				                });
				            }, function() {
				                $('#weather').text('위치 정보를 불러오지 못했습니다.');
				            });
				        } else {
				            $('#weather').text('브라우저에서 위치 정보를 사용할 수 없습니다.');
				        }
				    });
				    </script>


						<c:choose>
							<c:when test="${ not empty loginUser }">
		                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
		                        <li class="nav-item dropdown no-arrow d-sm-none">
		                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
		                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		                                <i class="fas fa-search fa-fw"></i>
		                            </a>
		                            <!-- Dropdown - Messages -->
		                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
		                                aria-labelledby="searchDropdown">
		                                <form class="form-inline mr-auto w-100 navbar-search">
		                                    <div class="input-group">
		                                        <input type="text" class="form-control bg-light border-0 small"
		                                            placeholder="Search for..." aria-label="Search"
		                                            aria-describedby="basic-addon2">
		                                        <div class="input-group-append">
		                                            <button class="btn btn-primary" type="button">
		                                                <i class="fas fa-search fa-sm"></i>
		                                            </button>
		                                        </div>
		                                    </div>
		                                </form>
		                            </div>
		                        </li>
		
		                        <!-- Nav Item - Alerts -->
		                        <li class="nav-item dropdown no-arrow mx-1">
		                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
		                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		                                <i class="fas fa-bell fa-fw"></i>
		                                <!-- Counter - Alerts -->
		                                <span class="badge badge-danger badge-counter">3+</span>
		                            </a>
		                            <!-- Dropdown - Alerts -->
		                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
		                                aria-labelledby="alertsDropdown">
		                                <h6 class="dropdown-header">
		                                    Alerts Center
		                                </h6>
		                                <a class="dropdown-item d-flex align-items-center" href="#">
		                                    <div class="mr-3">
		                                        <div class="icon-circle bg-primary">
		                                            <i class="fas fa-file-alt text-white"></i>
		                                        </div>
		                                    </div>
		                                    <div>
		                                        <div class="small text-gray-500">December 12, 2019</div>
		                                        <span class="font-weight-bold">A new monthly report is ready to download!</span>
		                                    </div>
		                                </a>
		                                <a class="dropdown-item d-flex align-items-center" href="#">
		                                    <div class="mr-3">
		                                        <div class="icon-circle bg-success">
		                                            <i class="fas fa-donate text-white"></i>
		                                        </div>
		                                    </div>
		                                    <div>
		                                        <div class="small text-gray-500">December 7, 2019</div>
		                                        $290.29 has been deposited into your account!
		                                    </div>
		                                </a>
		                                <a class="dropdown-item d-flex align-items-center" href="#">
		                                    <div class="mr-3">
		                                        <div class="icon-circle bg-warning">
		                                            <i class="fas fa-exclamation-triangle text-white"></i>
		                                        </div>
		                                    </div>
		                                    <div>
		                                        <div class="small text-gray-500">December 2, 2019</div>
		                                        Spending Alert: We've noticed unusually high spending for your account.
		                                    </div>
		                                </a>
		                                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
		                            </div>
		                        </li>
								
		                        <!-- 채팅 목록 -->
								<li class="nav-item dropdown no-arrow mx-1">
								    <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
								       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								        <i class="fas fa-envelope fa-fw"></i>
								        <!-- Counter - Active Chats -->
								        <span class="badge badge-danger badge-counter" id="activeChatCount">${activeChatCount}</span> <!-- 현재 활성화 채팅 수 -->
								    </a>
								    <!-- Dropdown - Messages -->
								    <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
								         aria-labelledby="messagesDropdown">
								        <h6 class="dropdown-header">
								            Chat Center
								        </h6>
								        
								        <!-- AJAX로 가져온 활성화된 채팅 리스트가 여기에 동적으로 추가됩니다. -->
								        <div id="participantList">
								        
								        </div>
								
								    </div>
								</li>

							</c:when>
							<c:otherwise>
								
							</c:otherwise>
						</c:choose>

                        <!-- 채팅 모달 -->
						<div class="modal fade" id="chatModal" tabindex="-1" aria-labelledby="chatModalLabel" aria-hidden="true">
						    <div class="modal-dialog">
						        <div class="modal-content">
						            <div class="modal-header">
						                <!-- 동적으로 선택된 사용자 이름 렌더링 -->
						                <h5 class="modal-title" id="chatModalLabel">${participantName}님과의 채팅</h5>
						                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
						            </div>
						            <div class="modal-body">
						                <!-- 채팅 메시지 영역 -->
						                <div id="chatMessages" style="height: 300px; overflow-y: auto; border: 1px solid #ddd; padding: 10px;">
						                    <!-- EL 표현식을 사용하여 채팅 메시지를 렌더링 -->
						                    <c:forEach var="message" items="${messages}">
						                        <div class="d-flex mb-3" style="position: relative;">
						                            <!-- 메시지 보낸 사람이 현재 로그인한 유저인지 확인 -->
						                            <c:choose>
						                                <c:when test="${message.senderId == currentUserId}">
						                                    <!-- 본인이 보낸 메시지 -->
						                                    <div class="bg-primary text-white p-2 rounded" style="max-width: 70%; margin-left: auto;">
						                                        <p class="mb-0">${message.content}</p>
						                                        <small class="text-muted">You · ${message.timestamp}</small>
						                                    </div>
						                                </c:when>
						                                <c:otherwise>
						                                    <!-- 상대방이 보낸 메시지 -->
						                                    <div class="d-flex mb-3">
						                                        <div class="mr-2">
						                                            <img class="rounded-circle" src="${message.profileImg}" alt="${message.senderName}" style="width: 40px;">
						                                        </div>
						                                        <div class="bg-light p-2 rounded" style="max-width: 70%;">
						                                            <p class="mb-0">${message.content}</p>
						                                            <small class="text-muted">${message.senderName} · ${message.timestamp}</small>
						                                        </div>
						                                    </div>
						                                </c:otherwise>
						                            </c:choose>
						                        </div>
						                    </c:forEach>
						                </div>
						                <!-- 입력 영역 -->
						                
						                <!-- 파일 전송 아이콘 추가 -->
					                    <button id="fileUploadIcon" class="btn btn-outline-secondary" type="button">
					                        <img src="/fitguardians/resources/images/fileTransfer.png" alt="파일 전송" />
					                    </button>
					
					                    <!-- 숨겨진 파일 입력창 -->
					                    <input type="file" id="fileInput" style="display:none;" multiple />
					                    
						                
						                <div class="input-group mt-3">
						                    <input type="text" class="form-control" id="messageInputTopBar" placeholder="메시지를 입력하세요..." />
						                    <button id="sendMessageButton" class="btn btn-primary" type="button">Send</button>
						                </div>
						            </div>
						        </div>
						    </div>
						</div>




                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        
                        <c:choose>
                        	<c:when test="${not empty loginUser}">
		                        <li class="nav-item dropdown no-arrow">
		                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
		                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${ loginUser.userName }</span>
		                                <img class="img-profile rounded-circle" src="${ loginUser.profilePic }" />
		                            </a>
		                            <!-- Dropdown - User Information -->
		                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
		                                aria-labelledby="userDropdown">
		                                <a class="dropdown-item" href="mypage.me">
		                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
		                                    My Page
		                                </a>
		                                <a class="dropdown-item" onclick="uploadImg();">
		                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
		                                    Settings
											<a id="qr" href="${loginUser.qr}"></a>
		                                </a>
		                                <a class="dropdown-item" href="sendQr.me">
		                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
		                                    QR코드 전송
		                                </a>
		                                <div class="dropdown-divider"></div>
		                                <a class="dropdown-item" href="logout.me" data-toggle="modal" data-target="#logoutModal">
		                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
		                                    Logout
		                                </a>
		                            </div>
		                        </li>
	                        </c:when>
	                        <c:otherwise>
	                        	 <li class="nav-item dropdown no-arrow">
		                            <a class="nav-link" href="loginform.me" id="userDropdown" role="button">
		                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">로그인을 해주세요</span>
		                            </a>
		                        </li>
	                        </c:otherwise>
                        </c:choose>

                    </ul>

                </nav>
                <!-- End of Topbar -->
                
                 <!-- Logout Modal-->
			    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
			        aria-hidden="true">
			        <div class="modal-dialog" role="document">
			            <div class="modal-content">
			                <div class="modal-header">
			                    <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
			                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
			                        <span aria-hidden="true">×</span>
			                    </button>
			                </div>
			                <div class="modal-body">로그아웃을 하려면 로그아웃 버튼을 눌러주세요</div>
			                <div class="modal-footer">
			                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
			                    <a class="btn btn-primary" href="logout.me">Logout</a>
			                </div>
			            </div>
			        </div>
			    </div>
	<script>
	    // 현재 시간을 가져오는 함수
	    var getCurrentTime = function() {
	        var now = new Date();
	        var year = now.getFullYear();
	        var month = ('0' + (now.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
	        var day = ('0' + now.getDate()).slice(-2);
	        var hours = ('0' + now.getHours()).slice(-2);
	        var minutes = ('0' + now.getMinutes()).slice(-2);
	
	        return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
	    };
	
	    // 변수 선언
	    var userNo = ${sessionScope.loginUser.userNo}; // 세션에서 가져온 사용자 번호
	    var userLevel = ${sessionScope.loginUser.userLevel}; // 세션에서 가져온 사용자 레벨,
	    var currentUserNo = userNo; // 현재 로그인한 유저 NO
	    var selectedUserNo; // 상대방 유저 NO
	    var chNo; // 채팅방 번호
	    var lastMsgNo; // 전역 변수로 가장 큰 msgNo 저장
	    var intervalId; // 새로운 채팅을 불러오기 위한 인터벌
	    var chatMessagesContainer; // 채팅창을 자동으로 맨 아래로 내려오게 하기 위한 변수
	
	    // 모달을 열고 메시지를 로드하는 함수
	    function openChatModal(participantName, userNo, chatRoomNo) {
	        selectedUserNo = userNo; // 상대방 유저 NO
	        chNo = chatRoomNo; // 채팅방 NO
	        chatMessagesContainer = $('#chatMessages');
	        
	    	 // 디버깅을 위한 콘솔 로그 추가
	        console.log('모달 열기 - 트레이너 이름:', participantName);
	        console.log('모달 열기 - 유저 번호:', userNo);
	        console.log('모달 열기 - 채팅방 번호:', chatRoomNo);
	
	        // 모달 제목 설정
	        $('#chatModal .modal-title').text('"' + participantName + '" 님과의 채팅');
	
	        // AJAX 요청
	        $.ajax({
	            url: '/fitguardians/chat/messages/' + chNo, // 메시지를 가져오는 API 엔드포인트
	            method: 'GET',
	            data: {
	                senderNo: currentUserNo, // 현재 로그인한 유저 NO
	                receiverNo: selectedUserNo, // 상대방 유저 NO
	            },
	            success: function(response) {
	                console.log("AJAX 응답:", response); // 응답 내용 확인
	                if (response && response.length > 0) {
	                    updateChatMessages(response); // 메시지 업데이트 함수 호출
	                } else {
	                    console.warn("응답이 비어 있습니다."); // 경고 메시지 출력
	                }
	                
	                // 모달 여는 코드 추가!
	                $('#chatModal').modal('show');
	                
	             	// 이전의 setInterval 정리
	                if (intervalId) {
	                    clearInterval(intervalId);
	                }

	                // 2초마다 새로운 메시지 가져오기 시작
	                intervalId = setInterval(() => {
	                    fetchNewMessages(lastMsgNo);
	                }, 2000);

	            },
	            error: function(xhr, status, error) {
	                console.error("메시지 로드 오류:", error);
	            }
	        });
	    }
	    
	 	// 모달이 열렸을 때 스크롤을 아래로 내리기
	    $('#chatModal').on('shown.bs.modal', function() {
	        chatMessagesContainer.scrollTop(chatMessagesContainer[0].scrollHeight);
	    });
	    
	 	// 닫기 버튼 클릭 시 인터벌 해제
	    $('.btn-close').on('click', function () {
	        clearInterval(intervalId);
	    });
	    
		// 채팅모달 닫을 시 인터벌 해제(잘 안되는것 같음)
	    $('#chatModal').on('hidden.bs.modal', function () {
	        clearInterval(intervalId);
	    });

	    
	    // 새 메시지를 가져오는 함수
	    function fetchNewMessages(lastMsgNo){
	    	$.ajax({
	    		
	    		url: '/fitguardians/chat/newMessages/' + chNo,
	    		method: 'GET',
	    		data: {
	    			senderNo: currentUserNo, // 로그인 유저 넘버임!
	    			receiverNo: selectedUserNo, // 상대방 유저 넘버임!
	    			lastMsgNo: lastMsgNo // 가장 큰 msgNo 전송
	    		},
	    		success: function(response) {
	    			if(response && response.length > 0){
	    				updateChatMessages(response); // 새 메시지 업데이트
	    			}
	    		},
	    		error: function(xhr, status, error){
	    			console.log("세 메시지 로드 오류", error);
	    		}
	    	})
	    }
	    
	    
	
	    // 드롭다운 아이템 클릭 시
	    $(document).on('click', '.chat-participant', function() {
	        // 클릭한 참가자의 이름과 ID 가져오기
	        var participantName = $(this).data('participant-name');
	        var userNo = $(this).data('user-no'); // 상대방 유저 NO
	        var chatRoomNo = $(this).data('chat-room-no'); // 채팅방 NO
	
	        // 모달 열기
	        openChatModal(participantName, userNo, chatRoomNo);
	    });
	
	 	// 채팅 메시지를 업데이트하는 함수
	    function updateChatMessages(messages) {
	        var chatMessagesContainer = $('#chatMessages');
	        //chatMessagesContainer.empty(); // 기존 메시지 삭제

	        var messagesToStatusUpdate = []; // 메시지들의 상태 업데이트를 담을 변수

	        // 메시지 렌더링
	        messages.forEach(function(message) {
	            var messageElement;
	            var formattedDate = message.sendDate;

	            if (message.senderNo == currentUserNo) {
	                // 본인이 보낸 메시지
	                messageElement = '<div class="d-flex mb-3" style="position: relative; align-items: flex-start;">' +
	                    '<div class="bg-primary text-white p-2 rounded" style="max-width: 70%; margin-left: auto;">' +
	                    '<p class="mb-0">' + message.msgContent + '</p>' +
	                    '<small class="text-muted">당신 · ' + formattedDate + '</small>' +
	                    '</div>';

	                // 메시지 상태에 따른 표시
	                if (message.msgStatus === "U") {
	                    messageElement += '<span style="font-size: 0.8rem; margin-left: 5px; margin-top: auto;">1</span>'; // 오른쪽에 배치
	                }

	                messageElement += '</div>';

	            } else {
	                // 상대방이 보낸 메시지
	                messageElement = '<div class="d-flex mb-3">' +
	                    '<div class="mr-2">' +
	                    '<img class="rounded-circle" src="' + message.profileImg + '" alt="' + message.senderName + '" style="width: 40px;">' +
	                    '</div>' +
	                    '<div class="bg-light p-2 rounded" style="max-width: 70%;">' +
	                    '<p class="mb-0">' + message.msgContent + '</p>' +
	                    '<small class="text-muted">' + message.senderName + ' · ' + formattedDate + '</small>' +
	                    '</div></div>';

	                // 수신자일 경우 상태업데이트 배열에 값 담기
	                if (message.msgStatus === "U" && message.receiverNo === currentUserNo) {
	                    messagesToStatusUpdate.push({
	                        msgNo: message.msgNo,        // 메시지 번호
	                        chNo: chNo,           // 채팅방 번호
	                        receiverNo: message.receiverNo, // 수신자 번호
	                        msgStatus: message.msgStatus // 현재 상태
	                    });
	                }
	            }

	            chatMessagesContainer.append(messageElement); // 메시지를 컨테이너에 추가
	            
				
	        });
	        
	    	// 스크롤을 맨 아래로 내리기
	        chatMessagesContainer.scrollTop(chatMessagesContainer[0].scrollHeight);
	        
	     	// 가장 큰 msgNo 찾기
            if (messages.length > 0) {
                lastMsgNo = Math.max(...messages.map(msg => msg.msgNo));
            }

	        // 상태 업데이트 호출 (배열이 비어있지 않을 때만)
	        if (messagesToStatusUpdate.length > 0) {
	            updateMessagesStatusToRead(messagesToStatusUpdate);
	        }
	    }

	    
	    function updateMessagesStatusToRead(messagesToStatusUpdate) {
	    	console.log("업데이트할 메시지들:", messagesToStatusUpdate);

	        $.ajax({
	            url: '/fitguardians/chat/updateStatus', // 상태 업데이트 API 엔드포인트
	            method: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(messagesToStatusUpdate),
	            success: function(updatedCount) {
	                console.log(updatedCount + "개의 메시지 상태가 업데이트되었습니다.");
	            },
	            error: function(xhr, status, error) {
	                console.error("메시지 상태 업데이트 오류:", error);
	            }
	        });
	    }

	
	    // 메시지 전송 함수
	    function sendMessage(messageContent) {
	        console.log('sendMessage 함수 호출됨'); // 함수 호출 확인
	        
	        if(!messageContent) {
	        	messageContent = $('#messageInputTopBar').val();
	        }	
	        console.log('입력된 메시지:', messageContent); // 로그 출력
	
	        // 메시지가 비어있지 않은 경우에만 진행
	        if (messageContent.trim() !== "") {
	            // 전송할 데이터 확인을 위해 console.log 추가
	            var messageData = {
	                msgContent: messageContent,
	                senderNo: currentUserNo, // 현재 로그인한 유저 No
	                receiverNo: selectedUserNo, // 상대방 유저 No
	                chNo: chNo // 채팅방 번호
	            };
	            console.log('전송할 메시지 데이터:', JSON.stringify(messageData)); // 여기서 데이터 로그 출력
	
	            // 메시지 전송을 위한 AJAX 요청
	            $.ajax({
	                url: '/fitguardians/chat/send', // 메시지 전송 엔드포인트
	                method: 'POST',
	                contentType: 'application/json',
	                data: JSON.stringify(messageData),
	                success: function(response) {
	                	// 메시지 전송 성공 시, 메시지 추가
	                	
	                	var msgStatus = response.msgStatus; // 서버로부터 응답받은 메시지 상태
	                	console.log(response.msgStatus);
	                	
	                	var newMessage = '<div class="d-flex justify-content-end mb-3" style="position: relative; align-items: flex-start;">' + // 오른쪽 정렬
				                	    '<div class="bg-primary text-white p-2 rounded" style="max-width: 70%;">' +
				                	    '<p class="mb-0">' + messageContent + '</p>' +
				                	    '<small class="text-muted">당신 · ' + getCurrentTime() + '</small>' +
				                	    '</div>'				                	    
				        
				                	    // 메시지를 읽지 않았을 경우 1을 추가
				        if(msgStatus === "U"){
				        	newMessage += '<span style="font-size: 0.8rem; margin-left: 5px; margin-top: auto;">1</span>';
				        }
				        
				        newMessage += '</div>'; // div 닫음        	    

	                	// 메시지를 컨테이너에 추가
	                	$('#chatMessages').append(newMessage);

	                    // 입력 필드 비우기
	                    $('.input-group input[type="text"]').val('');
	                    // 스크롤을 가장 아래로 내리기
	                    $('#chatMessages').scrollTop($('#chatMessages')[0].scrollHeight);
	                },
	                error: function(xhr, status, error) {
	                    console.error('메시지를 전송하는 중 오류 발생:', error);
	                }
	            });
	        } else {
	            console.log('메시지를 입력하세요.'); // 메시지 비어있을 경우 콘솔에 로그 출력
	        }
	    }
	
	    $(function() {
	        // 활성화 채팅 수 가져오기
	        $.ajax({
	            url: '/fitguardians/chat/activeChatCount/' + userNo,
	            type: 'GET',
	            success: function(activeChatCount) {
	                // 활성화 채팅 수 업데이트
	                $('#activeChatCount').text(activeChatCount);
	            },
	            error: function(xhr, status, error) {
	                console.error('활성화 채팅 수를 가져오는 중 오류 발생:', error);
	            }
	        });
	
	        // 사용자 레벨에 따라 활성화된 참가자 가져오기
	        var participantUrl = userLevel === 2 ? '/fitguardians/chat/activeParticipants/user/' : '/fitguardians/chat/activeParticipants/trainer/';
	        $.ajax({
	            url: participantUrl + userNo,
	            type: 'GET',
	            success: function(activeParticipants) {
	                var participantList = $('#participantList');
	                participantList.empty(); // 기존 내용 비우기
	
	                if (activeParticipants.length > 0) {
	                    let items = '';
	
	                    activeParticipants.forEach(participant => {
	                        const image = participant.participantImage || 'default-image.png';
	                        const lastMessage = participant.lastMessage || '메시지가 없습니다.';
	                        const participantName = participant.participantName || '참가자 없음';
	                        const lastActive = participant.lastActive || '활동 없음';
	                        const statusClass = participant.participantStatus === 'Y' ? 'bg-success' : 'bg-danger';
	                        const messageToDisplay = lastMessage.includes('href=') ? '파일이 포함되었습니다.' : lastMessage;
	                        
	                     	
	
	                        // 문자열 연결 방식으로 아이템 생성
	                        items += '<a class="dropdown-item chat-participant d-flex align-items-center" href="#" data-toggle="modal" data-target="#chatModal" data-user-no="' + participant.participantNo + '" data-chat-room-no="' + participant.chatRoomNo + '" data-participant-name="' + participant.participantName + '">' +
	                            '<div class="dropdown-list-image mr-3">' +
	                            '<img class="rounded-circle" src="' + image + '" alt="...">' +
	                            '<div class="status-indicator ' + statusClass + '"></div>' +
	                            '</div>' +
	                            '<div class="font-weight-bold">' +
	                            '<div class="text-truncate">' + messageToDisplay + '</div>' +
	                            '<div class="small text-gray-500">' + participantName + ' · ' + lastActive + '</div>' +
	                            '</div></a>';
	                    });
	
	                    participantList.append(items); // participantList에 아이템 추가
	                } else {
	                    participantList.append('<a class="dropdown-item chat-participant text-center">활성화된 참가자가 없습니다.</a>');
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error('활성화된 참가자를 가져오는 중 오류 발생:', error);
	            }
	        });
	        
	     	// '전송' 버튼 클릭 시 메시지 전송
	        $('#sendMessageButton').on('click', function() {
	        	console.log('전송 버튼 클릭됨'); // 클릭 확인
	            sendMessage();
	        });
	
	        // Enter 키를 눌렀을 때 메시지 전송
	        $('#messageInputTopBar').on('keypress', function(event) {
	            if (event.which === 13) { // Enter 키 코드
	                sendMessage();
	                event.preventDefault(); // Enter 키로 인해 폼이 제출되는 것을 방지
	            }
	        });

	    });
	    
	    
	    // 되면 좋고 아님 말고 파일 업로드 기능 ㄱㄱ
		$('#fileUploadIcon').on('click', function() {
		    $('#fileInput').click(); // 파일 선택 창 열기
		});
		
		$('#fileInput').on('change', function(event) {
		    const files = event.target.files; // 선택된 파일들
		    console.log('Selected files:', files); // 선택된 파일들 콘솔 출력
		    
		    // 파일이 선택되었는지 확인
		    if (files.length === 0) {
		        console.log('No files selected.'); // 파일이 선택되지 않았을 경우 로그 출력
		        return; // 선택된 파일이 없으므로 이후 처리 중지
		    }
		
		    for (let i = 0; i < files.length; i++) {
		        console.log('Added file: ' + files[i].name + ', Size: ' + files[i].size + ', Type: ' + files[i].type);
		    }
		
		    if (files.length > 0) {
		        // FormData에 여러 파일 담기
		        const formData = new FormData();
		        formData.append('userNo', userNo); // 유저 넘버 추가
		        for (let i = 0; i < files.length; i++) {
		            formData.append('files', files[i]); // 여러 파일 추가
		            console.log(`Added file: ${files[i].name}`); // 각 파일 이름 출력
		        }
		        
		        formData.forEach((value, key) => {
		            console.log(`${key}: ${value}`);
		        });
		        console.log('User No:', userNo); // userNo 값 확인
		
		        // AJAX로 서버에 파일 전송
		        $.ajax({
		            url: '/fitguardians/chat/fileUpload',  // 서버의 업로드 처리 URL
		            type: 'POST',
		            data: formData,
		            processData: false, // 파일 데이터를 전송할 때는 false로 설정
		            contentType: false, // 기본적으로 설정되는 Content-Type 헤더를 사용하지 않음
		            success: function(response) {
		                console.log('서버 응답:', response); // 서버에서 받은 응답을 콘솔에 출력
		                try {
		                    const jsonResponse = JSON.parse(response); // JSON 문자열을 객체로 변환
		                    if (jsonResponse.success) {
		                        alert('파일 업로드 성공!');
		
		                        // 업로드된 파일 링크를 채팅 메시지로 전송
		                        const uploadedFiles = jsonResponse.uploadedFiles.split(", "); // 파일 이름들 분리
		                        const uploadedFileUrls = jsonResponse.uploadedFileUrls.split(", "); // 파일 URL들 분리
		                        
		                        uploadedFiles.forEach(function(fileName, index) {
		                            const fileUrl = uploadedFileUrls[index];
		                            const fileLinkMessage = "<a href='" + fileUrl + "' download class='file-link'>" + fileName + "</a>"; // 파일 링크 메시지 생성
		                            
		                            // 파일 링크를 sendMessage 함수로 전송
		                            sendMessage(fileLinkMessage);
		                        });
		                    } else {
		                        alert('파일 업로드 실패');
		                    }
		                } catch (error) {
		                    console.error('응답 파싱 중 오류 발생:', error);
		                    alert('응답 처리 중 오류가 발생했습니다.');
		                }
		            }
		        });
		    }
		});


	</script>
	
	
	
	
	
	<c:choose>
	    <c:when test="${not empty loginUser && not empty loginUser.api}">
	        <c:if test="${not hasAdditionalInfo && not hasBodyInfo}">
	            <script>
					$(function(){
						Swal.fire({
							title: '추가 정보 입력',
							html: `
								<input type="number" id="height" name="height" class="swal2-input" placeholder="키 (cm)">
								<input type="number" id="weight" name="weight" class="swal2-input" placeholder="몸무게 (kg)">
								
								<select id="disease" name="disease" class="sumoselect_multiple mt-3" multiple=multiple>
									<option value="" hidden selected disabled>기저질환</option>
									<option value="없음">없음</option>
									<option value="혈압조절장애">혈압조절장애(고혈압, 저혈압)</option>
									<option value="고지혈증">고지혈증</option>
									<option value="당뇨">당뇨</option>
									<option value="대사증후군">대사증후군</option>
									<option value="디스크">디스크(목, 허리)</option>
									<option value="천식">천식</option>
									<option value="심혈관_질환">심혈관 질환</option>
									<option value="골다공증">골다공증</option>
									<option value="관절염">관절염(류마티스 등)</option>
									<option value="편두통_혹은_만성두통">편두통 혹은 만성두통</option>
									<option value="갑상선_장애">디스크(목, 허리)</option>
								</select>
								<select id="goal" class="custom-select">
									<option value="" hidden selected disabled>운동 목표</option>
									<option value="체중_감량">체중 감량</option>
									<option value="근력_증가">근력 증가</option>
									<option value="수술_후_재활">수술 후 재활</option>
									<option value="유연성_운동">유연성 운동</option>
									<option value="균형_증가">균형 증가</option>
									<option value="심혈관_기능증진">심혈관 기능증진</option>
								</select>
							`,
							confirmButtonText: '저장',
							customClass: {
								popup: 'custom-popup',    // 팝업 전체에 커스텀 스타일 적용
								content: 'custom-content' // 컨텐츠에 대한 스타일 적용
							},
							preConfirm: () => {
								return {
									height: $("#height").val(),
									weight: $("#weight").val(),
									disease: $("#disease").val(),
									goal: $("#goal").val(),
								}
							},
							showCancelButton: true,
							cancelButtonText: '나중에 하기',
						}).then((result) => {
						        if (result.isConfirmed) {
						            let info = result.value;
						            if (info.height && info.weight && info.disease && info.goal) {
						            	console.log(JSON.stringify(info))
						            	$.ajax({
						            	    type: 'POST',
						            	    url: 'addAdditionalInfo.me',
						            	    data: JSON.stringify(info),  // JSON 데이터로 전송
						            	    contentType: 'application/json',
						            	    success: function(response) {
						            	        if (response === "success") {
						            	            Swal.fire('저장되었습니다!', '', 'success');
						            	        } else {
						            	            Swal.fire('저장에 실패했습니다.', '', 'error');
						            	        }
						            	    }
						            	});
						            } else {
						                Swal.fire('모든 정보를 입력해 주세요', '', 'error');
						            }
						        }else if (result.dismiss === Swal.DismissReason.cancel) {
				                       // '나중에 하기' 버튼 클릭 시 세션에 값을 저장
				                       $.ajax({
				                           type: 'POST',
				                           url: 'delayAdditionalInfo.me',
				                       });
				                   }
						    });
				            $(".sumoselect_multiple").SumoSelect({
								placeholder: "Select options",
							});
					})
	            </script>
	        </c:if>
	    </c:when>
	    <c:otherwise>
	    	<c:if test="${ not empty socialLoginError }">
				<script>
					Swal.fire({
						icon: 'error',
						title: '소셜 로그인 오류',
						text: "${socialLoginError}",
						confirmButtonText: '확인',
					})
				</script>
			</c:if>
	    </c:otherwise>
	</c:choose>




</body>
</html>