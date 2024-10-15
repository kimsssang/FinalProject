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
                text: '기록하기',
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

            // target에 대한 switch문

            switch(plan.extendedProps.target){
                case 'biceps' : targetMuscle = '이두근'; break;
                case 'triceps' : targetMuscle = '삼두근'; break;
                case 'chest' : targetMuscle = '가슴근'; break;
                case 'abdominals' : targetMuscle = '복근'; break;
                case 'lats' : targetMuscle = '광배근'; break;
                case 'back' : targetMuscle = '등근'; break;
                case 'glutes' : targetMuscle = '엉덩이근'; break;
                case 'quadriceps' : targetMuscle = '사두근'; break;
                case 'hamstrings' : targetMuscle = '햄스트링근'; break;
            }
       
            // 값 찍기
            $('#modalExerciseNo').text(plan.extendedProps.exerciseNo);
            $('#modalWorkoutTitle').text('제목: ' + plan.title);
            $('#modalWorkoutTarget').text(' 운동 표적: '+ targetMuscle);
            $('#modalDifficulty').text('운동 난이도: ' + difficultyLabel);
            $('#modalDescription').text('운동 설명: '+ plan.extendedProps.description);
            
            // Show the modal
            $('#eventModal').modal('show');
    
        },
    }); // calendar 로드 스크립트
    
    // exPlanList 데이터 추출
    let workouts = exPlanList;



    workouts.forEach(workout => {
        calendar.addEvent({
            title: workout.workoutTitle,
            start: new Date(workout.workoutDate), // Convert to Date object
            extendedProps: {
                exerciseNo: workout.exerciseNo,
                difficulty: workout.difficulty,
                target: workout.workoutTarget,
                description: workout.description
            }
        });
    });
    
    
    // 캘린더 랜더링
    calendar.render();
    
    }); // document.addEventListener('DOMContentLoaded', function