<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- jsPDF 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>

<!-- jsPDF autoTable 플러그인 (테이블 변환용) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>

<!-- jsPDF 폰트 번들 (한글 지원을 위한 폰트) -->
<script src="https://cdn.jsdelivr.net/npm/jspdf-font-kr@latest/dist/jspdf-font-kr.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jspdf-font-notosanskorean@0.0.2/dist/NotoSansKR-normal.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.2/xlsx.full.min.js"></script>

    
<style>
.mealfoodlist tr{

	height: 30px;
}
.mealfoodlist tr :last-child{
	width: 30px;
}


.mealplantitle button{
	margin-top: 5px;
	background-color: white;
	border-radius: 5px;
}
.mealplantitle button:hover{
	background-color: #4285f4;
}
.leftbutton button{
	margin-right: 8px;
}
.rightbutton button{
	margin-left: 8px;
}
#pdfgo{
    width: 180px;
    height: 50px;
    text-align: center;
    line-height: 50px; 
	margin-bottom: 20px;
}
.mealReMsgbtn{
	width: 180px;
    height: 50px;
    text-align: center;
    line-height: 50px; 
	margin-bottom: 20px;
}
.mealMsg{
	margin-bottom: 20px;
}
.mealReMsg{
	margin-bottom: 20px;
}
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    overflow: hidden; /* 전체 페이지에 스크롤이 발생하지 않도록 설정 */
}

#wrapper {
    height: 100vh; /* 뷰포트의 높이에 맞게 설정 */
    overflow: auto; /* 콘텐츠가 넘칠 경우에만 스크롤 발생 */
}

#content-wrapper {
    height: 100%; /* 컨텐츠 래퍼에 높이를 명확하게 설정 */
    display: flex;
    flex-direction: column; /* 요소들이 세로로 배치되도록 설정 */
}

</style>
</head>

    <body id="page-top">
        <!-- Page Wrapper -->
        <div id="wrapper">
         <jsp:include page="../common/sideTrainer.jsp" />
         <div id="content-wrapper" class="d-flex flex-column">
         <!-- Main Content -->
                  <div id="content">
					<div class="card shadow mb-4" style="width: 98%; height: 100%; margin-left: 10px ;" align="center">
								<c:choose>
				<c:when test="${empty loginUser }">
					<h2>로그인 후 이용 아마 가능합니다</h2>
				</c:when>
				<c:otherwise>
					

			
                 <jsp:include page="../common/topBar.jsp"/>
				 <div class="plantitle card-header py-3" style="display: flex; " >
					 <select id="getmeallist"></select>
					 <h3 class="m-0 font-weight-bold text-primary">
						님이 보낸 식단 
					</h3>

				 </div>
                    <div class="mealplantitle " style="display: flex; margin-top: 20px;  justify-content: center;" align="center"  >
						<div class="leftbutton"> <button><</button> </div>
						<div class="today">
							<h2></h2>
						</div>
						<div class="rightbutton"> <button>></button> </div>
					</div>
				<div class="selectday" style="margin-bottom: 30px; margin-top: 20px;"> <input type="date"> </div>
					<div class='tabledivno'> </div>
                   <div class="tablediv table-responsive">
					<table id="pdftable" class="table table-bordered" style="margin-top: 20px; margin-bottom: 20px; background-color: white;"> 
						<thead> 
							<tr> 
								<th >번호</th> 
								<th  >음식명</th>
	                           	<th >칼로리(kcal)</th>
	                           	<th > 당(g)</th>
	                           	<th >탄수화물(g)</th>
	                           	<th >단백질(g)</th>
	                           	<th >지방(g)</th>
							</tr>
						</thead>
						
						<tbody>
							
						</tbody>
						
					</table>
				</div>
				<div class="mealMsg"></div>
				<div class="mealReMsgdiv">
					<h2>답장하기</h2>
					<textarea rows="10" cols="50" class="meaRelMsg" style="resize: none" placeholder="아직 답장이 작성되지 않았습니다"></textarea> <br>
					<button id="pdfgo" class="btn btn-primary btn-icon-split btn-lg">  Excel로 저장  </button>
					<button class="mealReMsgbtn btn btn-primary btn-icon-split btn-lg" style="padding: 10px;">  답장하기  </button>
				</div>

<script>
// 오늘 날짜 확인
let today = new Date();

// 날짜 형식 변경 함수
function formatDate(date) {
    // yyyy-mm-dd 형식으로 변환
    let fomartday = date.getFullYear() + "-" + ((date.getMonth() + 1).toString().padStart(2, '0')) + "-" + (date.getDate().toString().padStart(2, '0'));
    // input에 value 넣어주기
    $('.selectday input').val(fomartday);
    return fomartday;
}

$(document).ready(function() {
    // 페이지 로딩 시 첫 화면에 날짜 표시
    let day = formatDate(today);
    $('.today h2').text(day);

    // 회원 목록 불러오기 (check 함수 역할을 하는 AJAX)
    check(function() {
        // 회원 목록 불러온 후 첫 번째 회원으로 식단 로드
        mealplan(day);
    });
});

// 어제를 불러오는 함수
$('.leftbutton button').click(function() {
    today.setDate(today.getDate() - 1);
    let day = formatDate(today);
    $('.today h2').text(day);
    mealplan(day); // 날짜 변경 시 식단 로드
});

// 다음날 함수
$('.rightbutton button').click(function() {
    today.setDate(today.getDate() + 1);
    let day = formatDate(today);
    $('.today h2').text(day);
    mealplan(day); // 날짜 변경 시 식단 로드
});

// 날짜 선택 함수
$('.selectday input').on('change', function() {
    let selectday = new Date($('.selectday input').val());
    today = selectday;
    let day = formatDate(today);
    $('.today h2').text(day);
    mealplan(day); // 날짜 선택 시 식단 로드
});

// 식단 데이터를 불러오는 함수
function mealplan(day) {
    $.ajax({
        url: 'mealPlanTrainerList.bo',
        data: { day: day, sendUser: $('#getmeallist option:selected').val() },
        success: function(data) {
            let value = "";
            if (data == "") {
                $('.tablediv').css('display', 'none');
                $('.mealReMsgdiv').css('display', 'none');
                if ($('#getmeallist option:selected').text() == 'pt를 받는 회원이 없습니다') {
                    value = "<h2>" + $('#getmeallist option:selected').text();
                } else {
                    value = "<h2>" + $('#getmeallist option:selected').text() + '님이 ' + day + ' 에 보낸 식단이 없습니다</h2>';
                }
                $('.mealMsg').html("");
                $('.tabledivno').html(value);
            } else {
                $('.tablediv').css('display', 'block');
                $('.mealReMsgdiv').css('display', 'block');
                for (let i in data) {
                    let num = parseInt(i) + 1;
                    value += "<tr>" +
                                "<td>" + num + "</td>" +
                                "<td>" + data[i].foodName + "</td>" +
                                "<td>" + data[i].kcal + "</td>" +
                                "<td>" + data[i].sugar + "</td>" +
                                "<td>" + data[i].carbs + "</td>" +
                                "<td>" + data[i].protein + "</td>" +
                                "<td>" + data[i].fat + "</td>" +
                            "</tr>";
                    $('.tablediv tbody').html(value);
                }
                let mealRemsg = data[0].mealRemsg || "";
                $('.meaRelMsg').val(mealRemsg);

                let value2 = "<h2>" + data[0].sendUserId + "님이 보낸 " + day + " 식단입니다</h2>";
                $('.tabledivno').html(value2);

                let value3 = data[0].mealMsg ? "<h2>" + data[0].sendUserId + "님의 한마디</h2>" + data[0].mealMsg : "<h2>" + data[0].sendUserId + "님의 한마디</h2> 따로 남긴 말이 없습니다";
                $('.mealMsg').html(value3);
            }
        },
        error: function() {
            console.log("회원의 식단 정보 불러오기 실패");
        }
    });
}

// 엑셀 다운로드 버튼 이벤트
document.getElementById('pdfgo').addEventListener('click', function() {
    var table = document.getElementById('pdftable');
    var wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
    XLSX.writeFile(wb, formatDate(today) + '식단.xlsx');
});

// 답장 전송 버튼 이벤트
$('.mealReMsgbtn').on('click', function() {
    if ($('.meaRelMsg').val() == "") {
        alert("답장이 작성되지 않았습니다");
        return false;
    } else {
        $.ajax({
            url: 'trainersendReMsg.bo',
            data: { day: formatDate(today), sendUser: $('#getmeallist option:selected').val(), mealRemsg: $('.meaRelMsg').val() },
            success: function() {
                alert("답장이 성공적으로 전달되었습니다");
                setTimeout(function() {
                    location.reload(); // 1초 후 새로고침
                }, 1000);
            },
            error: function() {
                console.log("ajax 마지막 버튼 오류");
            }
        });
    }
});

// 회원 목록 불러오기 함수 (check 함수 역할)
function check(callback) {
    let value = "";
    $.ajax({
        url: 'gettrainelist.bo',
        data: { userId: '${loginUser.userId}' },
        success: function(date) {
            if (date == null || date.length === 0) {
                value += '<option value="">pt를 받는 회원이 없습니다</option>';
                $('#getmeallist').html(value);
            } else {
                for (let i in date) {
                    value += "<option value=" + date[i].userId + ">" + date[i].userName + "</option>";
                }
                $('#getmeallist').html(value);
            }
            // 회원 목록 불러온 후 콜백 실행
            if (callback) callback();
        },
        error: function() {
            console.log("ajax 오류");
        }
    });
}

// 회원 목록 변경 시 식단 로드
$('#getmeallist').on('change', function() {
    let day = formatDate(today); // 현재 날짜 가져오기
    mealplan(day); // 날짜와 선택된 회원으로 AJAX 호출
});
</script>
				</c:otherwise>
			</c:choose>
             
			</div>
			</div>
			</div>
			</div>
			

             

</body>
</html>