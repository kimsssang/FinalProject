<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
					<div class="card shadow mb-4" style="width: 98%; height: 100%;" align="center">

			
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
			</div>
			</div>
			</div>
			</div>
				<script >
			
				
				//오늘날짜 확인 
				
				 let today = new Date();
				
				//날짜 형식 변경 함수
				 function formatDate(date) {
					//이제 이 함수값 넣고 리턴하면 날짜가 yyyy-mm-dd형식으로 변할거임
					let fomartday =  date.getFullYear() + "-" + ((date.getMonth() + 1).toString().padStart(2, '0')) + "-" + (date.getDate().toString().padStart(2, '0'));
						//input에 value 넣어주기용도
					$('.selectday input').val(fomartday);
						//이제 식단 나와야하니 밑에 함수 하나 새로 보내주기
					 mealplan(fomartday); 
				        return fomartday;
				    }
					
				
				
				$(document).ready(function(){
					//일단 페이지 로딩시 보여줄 첫 화면
				
					let day = formatDate(today);
				
					$('.today h2').text(day);
				
					
				})
				
				
				//어제를 불러오는 함수
				
					
				$('.leftbutton button').click(function(){
					today.setDate(today.getDate() - 1);
					let day = formatDate(today);
				
					$('.today h2').text(day);
				
				});
				
				
				
					//다음날 함수
				$('.rightbutton button').click(function(){
					 
					today.setDate(today.getDate() + 1);
					let day = formatDate(today);
					
					$('.today h2').text(day);
				
					
				});
					
					//마지막으로 원하는 날짜로 바꿀 수 있는 input 함수 만들자
					$('.selectday input').on('change',function(){
						let selectday = new Date($('.selectday input').val());
						today = selectday;
						let day = formatDate(today);
							$('.today h2').text(day);
					});
					
					function mealplan(day){
						//변경시마다 파일 가지고와야하니까 슬슬 ajax 준비하자
					
						$.ajax({
							url : 'mealPlanTrainerList.bo',
							data : {day : day , sendUser : $('#getmeallist option:selected').val() },
							success : function(data){
							//이건 성공시 받아올 파일
							let value = "";
							if(data == ""){
								
								$('.tablediv').css('display','none');
								$('.mealReMsgdiv').css('display','none');
								
								if($('#getmeallist option:selected').text() == 'pt를 받는 회원이 없습니다'){
									value = "<h2>"+ $('#getmeallist option:selected').text()
								}else{
								value = "<h2>"+ $('#getmeallist option:selected').text()  +'님이'+ day +' 에 보낸 식단이 없습니다'+"</h2>"
									
								}
								value3 =""
									$('.mealMsg').html(value3)
							$('.tabledivno').html(value);
							}else{
								for(let i in data){
									$('.tablediv').css('display','block');
									$('.mealReMsgdiv').css('display','block');
								
									console.log(data[i])
									let num = parseInt(i)+1
								value += "<tr>"+
											"<td>"+ num +"</td>" + 
											"<td>"+ data[i].foodName +"</td>" + 
											"<td>"+ data[i].kcal +"</td>" + 
											"<td>"+ data[i].sugar +"</td>" + 
											"<td>"+ data[i].carbs +"</td>" + 
											"<td>"+ data[i].protein +"</td>" + 
											"<td>"+ data[i].fat +"</td>" + 
								
										 "</tr>"
										 	$('.tablediv tbody').html(value)
								}
								let value5 = ""
								value5 = data[0].mealRemsg
								if(value5 == null){
									$('.meaRelMsg').val(value5)	
								
								}else{
										 	$('.meaRelMsg').val(value5)	
								
										 	
								}
								let value2 = "<h2>"+data[0].sendUserId +'님이 보낸'+ day +'식단입니다'+"</h2>"
								$('.tabledivno').html(value2);
								let value3 = ""
								if(data[0].mealMsg == null){
									value3 =  "<h2>"+data[0].sendUserId +'님의 한마디'+"</h2>" + data[0].sendUserId+'님이 따로 남긴 말이 없습니다'
								}else{
									value3 =  "<h2>"+data[0].sendUserId +'님의 한마디'+"</h2>" +data[0].mealMsg
								}
								$('.mealMsg').html(value3)
					
							}
							
							},
							error : function(){
								console.log("회원의 식단정보 불러오기 실패")
							}
						})
					}
					 document.getElementById('pdfgo').addEventListener('click', function() {
				            // HTML 테이블을 가져옴
				            var table = document.getElementById('pdftable');

				            // 테이블을 워크북으로 변환
				            var wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });

				            // Excel 파일로 다운로드
				            XLSX.writeFile(wb, formatDate(today)+'식단.xlsx');
				        });
						$('.mealReMsgbtn').on('click',function(){
							if($('.meaRelMsg').val() == ""){
								alert("답장이 작성되지 않았습니다")
								return false;
							}else{

								$.ajax({
									url : 'trainersendReMsg.bo' ,
									data : { day : formatDate(today), sendUser : $('#getmeallist option:selected').val() , mealRemsg :$('.meaRelMsg').val()  },
									success : function(){
										alert("답장이 성공적으로 전달되었습니다"); // 먼저 메시지를 보여줌

									setTimeout(function() {
										location.reload(); // 1초 후 새로고침
									}, 1000);
								},
								error : function(){
									console.log("ajax 마지막 버튼 오류")
								}
								})
							}
						})
						
						//회원목록용
					let value = ""
					$.ajax({
						url: 'gettrainelist.bo',
						data: {userId:'${loginUser.userId}'},
						success: function(date){
							if(date == null || date.length === 0 ){
								value += '<option value="">pt를 받는 회원이 없습니다</option>'
									$('#getmeallist').html(value);
							}else{
								
							for(let i in date){
							value += "<option value="+date[i].userId +">" +date[i].userName  +"</option>" 
							}
							$('#getmeallist').html(value);
							}
							
						
					
						},
						error: function(){
							console.log("ajax오류");
						}
						
					})
				    $('#getmeallist').on('change', function() {
					        let day = formatDate(today); // 현재 날짜 가져오기
					        mealplan(day); // 날짜와 선택된 회원으로 AJAX 호출
					    });
										
				</script>


             

</body>
</html>