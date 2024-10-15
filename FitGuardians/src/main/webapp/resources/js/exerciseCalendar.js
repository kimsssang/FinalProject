   let calendar;

    // 캘린더 데이터 관리
    document.addEventListener('DOMContentLoaded', function() {
 
    // 캘린더 설정화면	
    const calendarEl = document.getElementById('calendar');
    const isDetailView = document.querySelector('.detail-view') !== null;
        calendar = new FullCalendar.Calendar(calendarEl, {
        themeSystem: 'bootstrap5',
        height: '600px',
        initialView: 'dayGridMonth',
        navLinks: true,
        editable: true,
        nowIndicator: true,
        dayMaxEvents: true,
        selectable: true,
        weekNumbers: true,
        displayEventTime: false,
        headerToolbar: {
            start: 'dayGridMonth,dayGridWeek,dayGridDay',
            center: 'title',
            end: 'today prev,next'+(isDetailView?'': ',addEventButton')
        },
        locale: 'ko',
        events: [], // 조회 시 추가됨
        customButtons: {
            addEventButton: {
                text: '일정 추가',
                click: function() {
                    $("#calendarModal").modal("show");
                }
            }
        },
        eventClick: function(info) {
            
            let plan = info.event;
           
            // 난이도에 대한 switch문 
            switch (plan.extendedProps.difficulty) {
            case 'M':
                difficultyLabel = '중간';
                break;
            case 'L':
                difficultyLabel = '쉬움';
                break;
            case 'H':
                difficultyLabel = '어려움';
                break;
            default:
                difficultyLabel = '없음';
            }
            
            // 표적에 대한 switch문 
            switch (plan.extendedProps.workoutCategory) {
            case 'UE':
                category = '상체';
                break;
            case 'ABS':
                category = '복부, 코어';
                break;
            case 'LE':
                category = '하체';
                break;
            default:
                category = '없음';
            }
            
            // 값 찍기
            $('#modalExerciseNo').text(plan.extendedProps.exerciseNo);
            $('#modalWorkoutTitle').text('제목: ' + plan.title);
            $('#modalWorkoutCategory').text(' 운동 표적: '+ category);
            $('#modalDifficulty').text('운동 난이도: ' + difficultyLabel);
            $('#modalDescription').text('운동 설명: '+ plan.extendedProps.description);
            
            // Show the modal
            $('#eventModal').modal('show');

        },
    }); // calendar 로드 스크립트

    calendar.render();

    $('.selectTrainee').change(function(){
        let userName = $(this).find('option:selected').text(); // 선택된 회원의 이름 표시. val()은 회원의 아이디 표시
        let userId = $(this).find('option:selected').val(); // 선택된 회원의 아이디

        $('#trainee').text(userName + "님의 운동 계획하기");
        $('#addExerciseList').text(userName + "님의 운동 플랜 등록하기");
        
        // 트레이너가 선택한 회원의 모든 운동 스케줄 조회
        // 전달값이 userId 하나이므로
        // 2) String 문자열로 값 보내고 받기
        if(userId !== "none"){
            $.ajax({
                url: "selectWorkout.ex",
                method : "post",
                // contentType:"application/json; charset=utf-8", // 이것만으론 JSON 문자열임을 알릴 수 없다. contentType + JSON.stringify()로 변환해야 한다.
                // JSON.stringify를 사용하지 않는다면?
                // 이 경우 컨트롤러에서 request.getParameter 방식으로 userId를 가져와야 한다.
                // @RequestParam 사용
                data : {userId : userId},
                success: function(response){
        
                    showWorkouts(response);
                    setWorkoutPlan(response);
                    
                },
                error : function(){
                    console.log("조회 실패");
                },
            })
        }
    })
    
    
    // 캘린더에 데이터 추가할 값 받기
    let ajaxRequest = null;

    $("#addCalendar").on("click", function() {
        let userId = $(".selectTrainee").find('option:selected').val();
        let title = $("#calendar_title").val();
        let difficulty = $(".difficulty:checked").val();
        let date = $("#calendar_date").val();
        let selectTarget = $(".target:checked").val();
        let description = $("#calendar_description").val();

        // 정규화
        if (!userId || userId === "none") {
        Swal.fire({
		  title: "회원을 먼저 선택해주세요.",
		  icon: "warning",
		});
        } else if (!title) {
        Swal.fire({
		  title: "제목을 입력하세요",
		  icon: "warning",
		});
        } else if (!difficulty) {
        Swal.fire({
		  title: "난이도를 선택하세요.",
		  icon: "warning",
		});
        } else if (!date) {
        Swal.fire({
		  title: "일자를 선택하세요.",
		  icon: "warning",
		});
        } else if (!description) {
        Swal.fire({
		  title: "설명을 작성하세요.",
		  icon: "warning",
		});
        } else if (!selectTarget) {
        Swal.fire({
		  title: "표적 부위를 선택하세요.",
		  icon: "warning",
		});
        } else {
            
            // 여기에 ajax 시전
            // ajax 2번 호출되고 있어서 abort 사용
            if(ajaxRequest !== null){
                ajaxRequest.abort();
            }
            
            // 1) JSON객체로 값 보내고 받기
            ajaxRequest = $.ajax({
                url : "addExercise.bo",
                method : "post",
                data: JSON.stringify({ // JSON.stringify와 
                        userId: userId,
                        title: title,
                        difficulty: difficulty,
                        date: date,
                        description: description,
                        selectTarget: selectTarget
                    }),
                contentType : "application/json; charset=utf-8", // contetntType이 같이 사용되야 JSON객체로 주고받을 수 있다.
                success: function(response){
                    
                    // Controller에서 삼항 연산자로 성공하면 "success"가 나오게, 실패하면 "error"가 나오게 설정했다.
                    // response가 success라는 단어로 나온다면
                    if(response.result === "success"){
                    Swal.fire({
						  title: "운동 계획이 성공적으로 추가되었습니다.",
						  icon: "success",
						});
                        
                        // 값 초기화
                        $("#calendarModal").modal("hide");
                        $("#calendar_title").val("");
                        $("#calendar_description").val("");
                        $("#calendar_date").val("");
                        $("input[type='checkbox']").prop('checked', false);
                        
                    }
                
                },
                error : function(){
                    //console.log("추가 실패");
                },
            });
        }
    });// 캘린더에 값 넣기(insert문)
    
    
});// document.addEventListener('DOMContentLoaded', function

function showWorkouts(response) {
    calendar.removeAllEvents(); // 이전 이벤트 제거

    if (Array.isArray(response) && response.length > 0) {
        response.forEach(event => {
            let eventDate = event.workoutDate;
            let eventDateObj = new Date(eventDate);
            let eventDateString = eventDateObj.toISOString().split('T')[0];

            calendar.addEvent({
                title: event.workoutTitle,
                start: eventDateObj,
                extendedProps: {
                    difficulty: event.difficulty,
                    workoutCategory: event.workoutCategory,
                    description: event.description,
                    exerciseNo: event.exerciseNo,
                }
            });
        });
    }
}
