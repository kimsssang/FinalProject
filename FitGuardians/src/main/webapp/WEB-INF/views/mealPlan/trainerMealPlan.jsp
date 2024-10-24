<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>

input[type="checkbox"] {
    appearance: none; /* 기본 체크박스 스타일 제거 */
    -webkit-appearance: none; /* 웹킷 브라우저에서 기본 스타일 제거 */
    width: 25px;
    height: 25px;
    border: 2px solid #000; /* 체크박스 테두리 색상 */
    border-radius: 4px; /* 둥근 모서리 */
    cursor: pointer;
    align-items: center;
}
input[type="checkbox"]:checked {
    background-color: #4285f4 ; /* 체크박스 배경색 (체크된 상태) */
    border-color: rgb(245, 245, 245); /* 체크박스 테두리 색상 */
    position: relative;
}

/* 체크 표시 커스텀 (V자 표시를 생성) */
input[type="checkbox"]:checked::after {
    content: '';
    position: absolute;
    top: 5px;
    left: 10px;
    width: 5px;
    height: 10px;
    border: solid white;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg); /* 체크 표시 모양으로 회전 */
}

/* 페이징바 버튼 사이즈 */
.page-btn{
	width: 36px;
	height: 38px;
	border: 1px solid black;
	
	

}
.pageingdiv button{
    background-color: white;
    color: #4285f4;
    border: 1px solid rgb(241, 241, 241);
}
.pageingdiv button:hover{
	background-color: rgb(241, 241, 241);
}
.next{
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;
    width: 50px;
	height: 38px;
}
.prev{
    border-top-left-radius: 5px;
    border-bottom-left-radius: 5px;
    width: 50px;
	height: 38px;

}
.mealfoodlist tbody tr td:last-child{
     text-align: center; /* 가로 중앙 정렬 */
    vertical-align: middle; /* 세로 중앙 정렬 */
}
.sendDataBtn{
    width: 180px;
    height: 50px;
    text-align: center;
    line-height: 50px; 
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

<!-- 트레이너가 회원에게 식단 입력하는 페이지 -->
    <body >
        <!-- Page Wrapper -->
      
        <div id="wrapper"style="overflow: auto">
         <jsp:include page="../common/sideTrainer.jsp" />
         <div id="content-wrapper" class="d-flex flex-column" style="display: none" >
         <!-- Main Content -->
             <div id="container-fluid" >
                 <jsp:include page="../common/topBar.jsp"/>
                 <!-- Begin Page Content -->
                 
                      <div class="card shadow mb-4" style="width: 98%; margin-left: 10px ;height: 100%; align-items: center;" align="center">
                      
                      			<c:choose>
				<c:when test="${empty loginUser }">
					<h2>로그인 후 이용 가능합니다</h2>
				</c:when>
				<c:otherwise>
                      
                      
                      
                      
		              <div class="card-header py-3" style="display: flex; align-items: center; width: 100%;">
		              	<select name="" id="getmeallist">  
             		    
           				 </select>
		                <h3 class="m-0 font-weight-bold text-primary">
		                    식단 추천 
		                </h3>
		              </div>
	        
                    <div class="container-fluid" style="padding-top: 30px">
                
                    
                    <div class="inputdivcss" style="margin-bottom: 30px; align-items: center;">
                    
                        <div align="center" style="display: flex;  justify-content: flex-end;  align-items: center; margin-bottom: 20px;">
                        <input type="date" name="meallistDate" class="meallistDate" style="margin-right: 10px;">

                        검색 : 
                        <input type="text" name="foodName" class="foodName form-control form-control-sm" style="width: 200px; height: 35px;margin-left: 10px;">
                    
           				 
                    </div>
                    
                        <div class="table-responsive">

                            <table  class="mealfoodlist table table-bordered">
                                <thead>                          
                                    <tr>
                                        <th >음식명</th>
                                        
                                        <th>칼로리(kcal)</th>
                                        <th>당(g)</th>
                                        <th>탄수화물(g)</th>
                                        <th>단백질(g)</th>
                                        <th>지방(g)</th>
                                        <th> </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                                
                            </table>
                            
                        </div>
                        <!-- 페이징바 div -->
                        
                        <div class="pageingdiv" style="margin-top: 30px ; text-align: center; ">
                        
                        </div>
                 
                        
                         
                        
                   <h4 style="margin-top: 20px;">보낼식단</h4>
                    <table  class="sendmealfoodlist table table-bordered">
                     <thead>                          
                           	<tr>
                           	<th >음식명</th>
                           
                           	<th>칼로리(kcal)</th>
                           	<th>당(g)/th>
                           	<th>탄수화물(g)</th>
                           	<th>단백질(g)</th>
                           	<th>지방(g)</th>
                           	<th>합계</th>
                        	</tr>
                        </thead>
                          <tbody>
                        </tbody>
                        <tfoot>
                        </tfoot>
                        
                    </table>
                    <div>  <h4>회원에게 한마디</h4>
                    <textarea rows="10" class="mealMsg" style="resize: none; width: 80%;" ></textarea> </div>
                    </div>
               		 
               			<div align="center" style="margin-bottom: 20px">
               			
                    	   <button class="sendDataBtn btn btn-primary btn-icon-split btn-lg" style=" line-height: 50px; ">회원에게 보내기</button>
               		  </div>
               		 </div>
                    
             		<script >
          		
             			$.ajax({
             				url:"mealplanlist.bo",
             				data : {foodName : ""},
             				success:function(data){
             					//console.log(data.body.items[0])
             			
             					const itemsArr = data.body.items;
             					let value = "";
             				for(let i in itemsArr){
             					let item = itemsArr[i];
             					
             					value +="<tr>"
             							+"<td style='display: none;'>"+ item.FOOD_CD +"</td>" 
             							+"<td>"+ item.FOOD_NM_KR+"</td>" 
             							+"<td>"+ item.AMT_NUM1+"</td>" 
             							+"<td>"+ item.AMT_NUM8+"</td>" 
             							+"<td>"+ item.AMT_NUM7+"</td>" 
             							+"<td>"+ item.AMT_NUM3+"</td>" 
             							+"<td>"+ item.AMT_NUM4+"</td>" 
             							+"<td>"+ "<input type='checkbox' disabled>"+"</td>" 
             							+"</tr>"
             							
             						
             				}
             				
             				$(".mealfoodlist tbody").html(value);
             					
             				},
             				error:function(){
             					console.log("음식리스트 조회 ajax실패")
             				}});
             			//1번은 그냥 조회했을떄고 이제 변경시 같은 ajax를 실행해야함 단 변경값을 가지고
  
             			
$(document).ready(function() {
    let debounceTimer;
    let currentPage = 1; // 현재 페이지 번호
    let totalPages = 1;  // 전체 페이지 수

    // 입력 필드에서 값이 변경될 때마다 실행 (디바운스 적용)
    $('.foodName').on('input', function() {
        var inputVal = $(this).val().trim();

        clearTimeout(debounceTimer); // 이전 타이머 취소

        // 300ms 동안 추가 입력이 없을 때만 AJAX 요청 실행
        debounceTimer = setTimeout(function() {
        	currentPage = 1 ;
            loadPage(inputVal, currentPage);
        }, 300); // 300ms 지연
    });

    // 페이지 데이터를 로드하는 함수
    function loadPage(foodName, pageNo) {
        $.ajax({
            url: "mealplanlist.bo",
            data: { foodName: foodName, pageNo: pageNo },
            success: function(data) {
                const itemsArr = data.body.items;
                const totalCount = data.body.totalCount; // 전체 데이터 개수
                const numOfRows = data.body.numOfRows;   // 한 페이지에 보이는 데이터 수

                // 전체 페이지 수 계산
                totalPages = Math.ceil(totalCount / numOfRows);

                // 테이블 업데이트
                let value = "";
                for (let i in itemsArr) {
                    let item = itemsArr[i];

                    value += "<tr>"
                        + "<td style='display: none;'>" + item.FOOD_CD + "</td>"
                        + "<td>" + item.FOOD_NM_KR + "</td>"
                        + "<td>" + item.AMT_NUM1 + "</td>"
                        + "<td>" + item.AMT_NUM8 + "</td>"
                        + "<td>" + item.AMT_NUM7 + "</td>"
                        + "<td>" + item.AMT_NUM3 + "</td>"
                        + "<td>" + item.AMT_NUM4 + "</td>"
                        + "<td>" + "<input type='checkbox' disabled>" + "</td>"
                        + "</tr>";
                }
                $(".mealfoodlist tbody").html(value); // 테이블 업데이트

                // 페이징바 업데이트
                renderPagination(currentPage, totalPages);
            },
            error: function() {
                console.log("음식 리스트 조회 AJAX 실패");
            }
        });
    }

    // 페이징바 렌더링 함수
    function renderPagination(currentPage, totalPages) {
        let paginationHtml = "";
        let startPage = Math.floor((currentPage - 1) / 10) * 10 + 1;
        let endPage = Math.min(startPage + 9, totalPages);

        // 이전 버튼
        if (startPage > 1) {
            paginationHtml += `<button class="prev">이전</button>`;
        }

        // 현재페이지보다 작은 번호 버튼 생성
        for (let i = startPage; i < currentPage; i++) {
        	
            paginationHtml += "<button  class='page-btn' data-page="+i+">" + i + "</button>";
            		
        }
        paginationHtml += "<button class='page-btn' style='background-color: #4285f4 ; color:white;' data-page="+currentPage+">" + currentPage + "</button>";
        // 현재페이지보다 큰 번호 버튼 생성
        for (let i = currentPage + 1 ; i <= endPage; i++) {
        	
            paginationHtml += "<button class='page-btn' data-page="+i+">" + i + "</button>";
            		
        }

        // 다음 버튼
        if (endPage < totalPages) {
            paginationHtml += `<button  class="next">다음</button>`;
        }

        // 페이지네이션 영역에 버튼 추가
        $('.pageingdiv').html(paginationHtml);

        // 현재 페이지 버튼 활성화
      
        $(".page-btn[data-page='" + currentPage + "']").addClass("active");
    }

    // 페이지 버튼 클릭 이벤트 처리
    $(document).on('click', '.page-btn', function() {
        currentPage = $(this).data('page');
        let foodName = $('.foodName').val().trim(); // 현재 검색어 유지
        loadPage(foodName, currentPage); // 선택한 페이지로 이동
    });

    // 이전, 다음 버튼 클릭 이벤트 처리
    $(document).on('click', '.prev', function() {
        currentPage = Math.max(1, currentPage - 10);
        let foodName = $('.foodName').val().trim();
        loadPage(foodName, currentPage);
    });

    $(document).on('click', '.next', function() {
        currentPage = Math.min(totalPages, currentPage + 10);
        let foodName = $('.foodName').val().trim();
        loadPage(foodName, currentPage);
    });

    // 초기 페이지 로드
    loadPage("", currentPage);
    
});
             			
             			//변수 미리 만들어두기
             						let value2 ="" 
             						var sum1 = 0;	
    								var sum2 = 0;	
    								var sum3 = 0;	
    								var sum4 = 0;	
    								var sum5 = 0;	
    								 value3 = "";
    								//선택시작
$(document).on("click", ".mealfoodlist tbody tr", function() {
    var checkbox = $( $(this).children().eq(7).find('input[type="checkbox"]'));
    
    // 체크가 되어있을 때 (이미 추가된 상태)
    if (checkbox.prop('checked')) {
        var result = confirm(($(this).children().eq(1).text()) + "을(를) 취소하시겠습니까?");
        
        if (result) {
            // 체크박스 해제
            checkbox.prop('checked', false);

            var value5 = $(this).children().eq(0).text(); 
            
            // 해당 항목을 sendmealfoodlist에서 삭제
            $('.sendmealfoodlist tr').each(function() {
                var value6 = $(this).children().eq(0).text();
                if (value5 === value6) {
                    $(this).remove();
                    value2 = value2.replace(new RegExp("<tr><td style='display: none;'>" + $(this).children().eq(0).html() + ".*?</tr>", "g"), "");
                }
            });
            
            if (value2 == "") {
                $(".sendmealfoodlist tbody tr").remove();
            }

            // **합계를 다시 계산하여 반영**
            calculateAndUpdateTotal();
        } else {
            return false;
        }

    // 체크가 되어있지 않을 때 (즉, 추가하는 상태)
    } else {
        var result2 = confirm(($(this).children().eq(1).text()) + "을(를) 추가하시겠습니까?");

        if (result2) {
            checkbox.prop('checked', true);
            
            // 행 추가
            value2 += "<tr>" + 
                        "<td style='display: none;'>" + $(this).children().eq(0).html() + "</td>" +
                        "<td>" + $(this).children().eq(1).html() + "</td>" +
                        "<td>" + $(this).children().eq(2).html() + "</td>" +
                        "<td>" + $(this).children().eq(3).html() + "</td>" +
                        "<td>" + $(this).children().eq(4).html() + "</td>" +
                        "<td>" + $(this).children().eq(5).html() + "</td>" +
                        "<td>" + $(this).children().eq(6).html() + "</td>" +
                        "<td>" + "</td>" +
                      "</tr>";

            // **테이블에 행을 추가한 직후에 합계를 계산합니다**
         
            $(".sendmealfoodlist tbody").html(value2);

            // **합계를 다시 계산하여 반영**
            calculateAndUpdateTotal();
        } else {
            return false;
        }
    }
});

// **합계를 계산하고 테이블에 반영하는 함수**
function calculateAndUpdateTotal() {
    var sum1 = 0, sum2 = 0, sum3 = 0, sum4 = 0, sum5 = 0;

    // **기존 합계 행을 먼저 삭제**
      if ($(".sendmealfoodlist tbody tr").length > 0) {
        $(".sendmealfoodlist tfoot tr").remove(); 
    }

    $('.sendmealfoodlist tbody tr').each(function () {
        var num1 = parseFloat($(this).children().eq(2).text());
        var num2 = parseFloat($(this).children().eq(3).text());
        var num3 = parseFloat($(this).children().eq(4).text());
        var num4 = parseFloat($(this).children().eq(5).text());
        var num5 = parseFloat($(this).children().eq(6).text());

        if (!isNaN(num1)) sum1 += num1;
        if (!isNaN(num2)) sum2 += num2;
        if (!isNaN(num3)) sum3 += num3;
        if (!isNaN(num4)) sum4 += num4;
        if (!isNaN(num5)) sum5 += num5;
    });

    var sum6 = $('.sendmealfoodlist tbody tr').length;

    let value3 = "<tr>" +
                  "<td>" + '합계' + "</td>" +
                  "<td>" + Math.round(sum1 * 100) / 100 + "</td>" +
                  "<td>" + Math.round(sum2 * 100) / 100 + "</td>" +
                  "<td>" + Math.round(sum3 * 100) / 100 + "</td>" +
                  "<td>" + Math.round(sum4 * 100) / 100 + "</td>" +
                  "<td>" + Math.round(sum5 * 100) / 100 + "</td>" +
                  "<td>" + sum6 + "</td>" +
                  "</tr>";

    // **합계를 추가 (기존 테이블 업데이트)**

  
 
    $(".sendmealfoodlist tfoot").html(value3);
}

	//회원한테 보내는건 끝났어
	//일단 이제 누구한테 보낼지 검색하는 ajax만들자
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













	//회원정보 모아두는 배열
	$('.sendDataBtn').on('click',function(){
	console.log($('.sendmealfoodlist tbody tr').val());
	console.log("너냐");
    if ($(".meallistDate").val() == "") {
        alert("날짜를 입력해주세요");
        return false;
      }
        if ($(".sendmealfoodlist tbody tr").length == 0) {
            alert("식단을 입력해주세요");
            return false;
          }
		if($('#getmeallist option:selected').val() == ""){
		alert("식단을 받을 회원이 없습니다");
		return false
	}
	
		
		
		 var result = confirm($('#getmeallist option:selected').text() + " 회원에게"+$('.meallistDate').val()+"식단을 보내시겠습니까??");
		if(result){
			//이건 보낼때잖아 그냥 한번 동적으로 보내도 괜찮음 그게 확인도 편하고 대신 alertmsg로 ...님에게 ...일 식단을 보냈습니다 정도는 해주자
			
			//일단 식단 보내줄 비어있는 배열 하나 생성
		let foodCode = [];
		let foodName = [];
		let kcal = [];
		let sugar = [];
		let carbs = [];
		let protein = [];
		let fat = [];
		
	
		//그 배열에 음식 코드 넣어주기
		
		$('.sendmealfoodlist tbody tr').each(function(){
		
			let text1 = $(this).children().eq(0).text() || "0";
			let text2 = $(this).children().eq(1).text() || "0";
			let text3 = $(this).children().eq(2).text() || "0";
			let text4 = $(this).children().eq(3).text() || "0";
			let text5 = $(this).children().eq(4).text() || "0";
			let text6 = $(this).children().eq(5).text() || "0";
			let text7 = $(this).children().eq(6).text() || "0";
			foodCode.push(text1);
			foodName.push(text2);
			kcal.push(text3);
			sugar.push(text4);
			carbs.push(text5);
			protein.push(text6);
			fat.push(text7);
			
		})
	
		//이제부터 ajax로 update 짜기 시작
				$.ajax({
			url : 'trainercheckmealPlan.bo',
			data : {getUserId : $('#getmeallist option:selected').val() ,
				sendUserId : '${loginUser.userId}' ,
				mealDate : $('.meallistDate').val()				
			} ,
			success: function(data){
				if( data.length === 0){
					//데이터가 문제없이 비어있다면 이게 맞음
					test(foodCode,foodName,kcal,sugar,carbs,protein,fat);
				}else{					
					let result = confirm("현재 식단이 이미 있습니다 업데이트하시겠습니까?");
				if(result){
					//업데이트 한다고 하면?
							console.log("update 한다")
							//여기서 업데이트용 insert 준비해야 하지만
							//식단의 경우 같은 숫자가 나오는게 아니니까 전부 삭제하고 새로 insert하자
							$.ajax({
								url : 'trainerdleltemealPlan.bo',
							data : {getUserId : $('#getmeallist option:selected').val() ,
								sendUserId : '${loginUser.userId}' ,
								mealDate : $('.meallistDate').val()				
							},
							success : function(data){
								
							test(foodCode,foodName,kcal,sugar,carbs,protein,fat);
								console.log("update 완전성공")
							},
							error : function(){
								console.log("update 실패")
							}
									})
						}else{
									console.log("update 안함")
							//안할거면 나가
							return false
						}
					
				}
			}
			,error : function(){
				}
			})
			
		}else{
			//이건 보내지 않을때라 아무것도 없어도됨
		}
		 
		 
		 
		 
		 
	
	
	})
			function test(foodCode,foodName,kcal,sugar,carbs,protein,fat){
			
	$.ajax({
		url:'setmealplanList.bo',
		 traditional: true ,
		data: {
				foodCode : foodCode,
				foodName : foodName,
				kcal : kcal,
				sugar : sugar,
				carbs : carbs,
				protein : protein,
				fat : fat,
				getUserId : $('#getmeallist option:selected').val() ,
				sendUserId : '${loginUser.userId}' ,
				mealDate : $('.meallistDate').val(),
				mealMsg : $('.mealMsg').val()},
		success: function(date){
			alert("성공적으로 식단이 보내졌습니다")
			location.reload();
		},
		error: function(){
			alert("식단을 보내는 중 오류가 생겼습니다 다시 시도해주세요")
			console.log("ajax오류");
		}
		
			
	})
		}
    
	
	
	
	

	
             		</script>
             		
             						</c:otherwise>
			</c:choose>
             
             		
             		
             		
             
             </div>
             </div>
         </div>
        </div>

</body>
</html>