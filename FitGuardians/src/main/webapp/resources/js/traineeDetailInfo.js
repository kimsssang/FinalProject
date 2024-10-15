$(document).ready(function(){
    
    // 데이터 출력하는 메소드
    $("#saveButton").on("click",function(){
        
        let traineeId = traineeData.id;
        let traineeName = traineeData.name;
        let traineeGender = traineeData.gender;
        let traineeAge = traineeData.age;
        
        let height = $("#height").val();
        let heightMeter = height/100;
        let weight = $("#weight").val();

        let smm;
        let bmi;
        let fat;
        
        if(traineeGender == 'F'){ // 여자 측정
            // smm - 골격근량
            smm = 0.252 * weight + 0.473 * height - 48.3;
            // bmi - 체질량지수
            bmi = weight / (heightMeter ** 2);
            // fat - 체지방량
            fat = 1.20 * bmi + 0.23 * traineeAge - 5.4;
            
            let value = traineeName + "의 측정 결과입니다. <br />"
                        + "<span class='result' style='margin:10px'> · 골격근량 : </span> <span>" + smm.toFixed(1) + " </span> <br/> "
                        + "<span class='result' style='margin:10px'> · BMI(체질량지수) : </span> <span>" + bmi.toFixed(1) + " </span> <br/>"
                        + "<span class='result' style='margin:10px'> · 체지방량 : </span> <span>" + fat.toFixed(1) + " </span> ";
                        
            $('.bodyResult').attr('id', 'bodyResult');
            $('#bodyResult').html(value);
            $('#saveButton').text('저장하기');
       
        }else{ // 남자 측정
            // smm - 골격근량
           smm = 0.407 * weight + 0.267 * height - 19.2;
            // bmi - 체질량지수
           bmi = weight / (height ** 2);
            // fat - 체지방량
           fat = 1.20 * bmi + 0.23 * traineeAge - 16.2;

            let value = traineeName + "의 측정 결과입니다. <br />"
                        + "<span class='result' style='margin:10px'> · 골격근량 : </span> <span>" + smm.toFixed(1) + " </span> <br/> "
                        + "<span class='result' style='margin:10px'> · BMI(체질량지수) : </span> <span>" + bmi.toFixed(1) + " </span> <br/>"
                        + "<span class='result' style='margin:10px'> · 체지방량 : </span> <span>" + fat.toFixed(1) + " </span> ";
                        
            $('.bodyResult').attr('id', 'bodyResult');
            $('#bodyResult').html(value);
            $('#saveButton').text('저장하기');
            
        }

        // 저장 버튼 누르면 저장하기
        // 데이터 DB에 저장하는 ajax
        if($(this).text()==='저장하기'){
            $(this).click(function(){
             saveBodyInfo(traineeId, smm, bmi, fat);
            })
        }

    });

    // bodyInfo 저장하는 ajax함수
    function saveBodyInfo(traineeId, smm, bmi, fat){

        //console.log('saveBodyInfo 실행됨요');

        $.ajax({
            url : 'saveBodyInfo.me',
            method :'post',
            data : {
                userId : traineeId,
                smm : smm,
                fat : fat,
                bmi : bmi,
            },
            success : function(result){
                console.log(result);
                alert("성공적으로 저장하였습니다.");
                
                // 값 초기화
                $('#height').val();
                $('#weight').val();
                $('.bodyResult').val();
                
                },
            error : function(){
                console.log('bodyInfo 삽입 실패');
                },
        });
    }

    // 신체기록 삭제 ajax함수
    $('.deleteButton').on('click', function(){
        let bodyInfoNo = $(this).data("body-info-no");
        //console.log(bodyInfoNo); // 데이터 번호가 맞는지 확인함 (맞는걸 확인했음)

        let yes = confirm("정말로 삭제하시겠습니까?");

        if(yes){
            // 삭제 ajax 실행할 것
            $.ajax({
                url : 'deleteBodyInfo.me',
                method : 'post',
                data : {bodyInfoNo : bodyInfoNo},
                success: function(result){
                   alert('성공적으로 삭제하였습니다.');
                },
                error : function(){
                    console.log("error got occured");
                },
            });

        };

    })

   // 골격근량, 체질량지수, 체지방량 차트 표시(상위 6개의 데이터 얻을것)

					
   // 1) 대괄호를 제거한다.    대괄호 제거(slice) BodyInfo객체로 분리(split)  "BodyInfo("제거(replace) 및 공백 제거(trim) 
   let bodyInfoArr = recentBi.slice(1,-1).split('),').map(item=>item.replace('BodyInfo(', '').trim());
   
   // 외부 자바스크립트에 있는 labels[]과 data[]에 값을 삽입할 것이다.
   let labels = []; // measureDate가 들어갈 배열
   let smmArr= []; // smm이 들어갈 배열
   let bmiArr = []; // bmi가 들어갈 배열
   let fatArr = []; // fat이 들어갈 배열

   // 2) 각각의 bodyInfo를 출력한다.
   bodyInfoArr.forEach(info =>{
       
       let parts = info.split(', ');
       let bodyInfoNo = parts[0].split('=')[1];
       let userId = parts[1].split('=')[1];
       let measureDate = parts[2].split('=')[1];
       let bmi = parts[3].split('=')[1];
       let fat = parts[4].split('=')[1];
       let smm = parseFloat(parts[5].split('=')[1]); // 숫자로 형변환
       let biStatus = parts[6].split('=')[1];
   
       labels.unshift(formatData(measureDate)); // measureDate를 formatDate(외부자바스크립트에 있음)함수에 적용
       smmArr.unshift(Number(smm).toFixed(1)); // smm 
       bmiArr.unshift(Number(bmi).toFixed(1)); // bmi
       fatArr.unshift(Number(fat).toFixed(1)); // fat

   });
   
   function formatData(measureDate) {
    // 시간대를 KST에서 'GMT+9'로 대체(=JavaScript의 Date생성자에 대해 인식하는 형식)
    let formattedDateString = measureDate.replace("KST", "GMT+9");
    
    // 문자열을 Date객체로 전환
    let date = new Date(formattedDateString);

    // 연도, 월, 일 추출
    let year = date.getFullYear().toString().slice(-2); // 마지막 2자리 년도만 출력
    let month = date.toLocaleString('default', { month: 'long' }); // 전체 월 이름 가져옴
    let day = String(date.getDate()).padStart(2, '0'); // 월의 일 가져옴

    // Return the formatted date
    return `${year}년 ${month} ${day}일`; // 형식에 맞춰서 출력
}

   // 골격근량 차트 - area차트
    Chart.defaults.global.defaultFontFamily = 'Nunito, -apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif';
    Chart.defaults.global.defaultFontColor = '#858796';

    var ctx = document.getElementById("smmChart");
    var myAreaChart = new Chart(ctx, {
        type: 'line', // Keep it as 'line' for area chart
        data: {
            labels: labels, //measureDate가 들어갈 자리
            datasets: [{
                label: "골격근량",
                lineTension: 0.3,
                backgroundColor: "rgba(144, 238, 144, 0.3)", // Change to a semi-transparent color for area
                borderColor: "rgba(144, 238, 144, 1)",
                pointRadius: 3,
                pointBackgroundColor: "rgba(144, 238, 144, 1)",
                pointBorderColor: "rgba(144, 238, 144, 1)",
                pointHoverRadius: 3,
                pointHoverBackgroundColor: "rgba(144, 238, 144, 1)",
                pointHoverBorderColor: "rgba(144, 238, 144, 1)",
                pointHitRadius: 10,
                pointBorderWidth: 2,
                fill: true, 
                data: smmArr, // 골격근량 최근 6개 데이터 들어가기
            }]
        },
        options: {
            maintainAspectRatio: false,
            layout: {
                padding: {
                    left: 10,
                    right: 25,
                    top: 25,
                    bottom: 0
                }
            },
            scales: {
                xAxes: [{
                    gridLines: {
                        display: false,
                        drawBorder: false
                    },
                    ticks: {
                        maxTicksLimit: 6
                    }
                }],
                yAxes: [{
                    ticks: {
                        beginAtZero: true,
                        min:0,
                        max:50,
                        callback: function(value) {
                            if (value <= 19) return '~19%';
                            else if (value > 19 && value <= 23) return '23%';
                            else if (value > 23 && value <= 40) return '40%';
                            else if (value > 40 && value <= 45) return '45%';
                            else if (value > 45) return '45%~';
                            return null;
                        },
                        maxTicksLimit: 5
                    },
                    gridLines: {
                        color: "rgb(234, 236, 244)",
                        zeroLineColor: "rgb(234, 236, 244)",
                        drawBorder: false,
                        borderDash: [2],
                        zeroLineBorderDash: [2]
                    }
                }],
            },
            legend: {
                display: false
            },
            tooltips: {
                backgroundColor: "rgb(255,255,255)",
                bodyFontColor: "#858796",
                titleMarginBottom: 10,
                titleFontColor: '#6e707e',
                titleFontSize: 14,
                borderColor: '#dddfeb',
                borderWidth: 1,
                xPadding: 15,
                yPadding: 15,
                displayColors: false,
                intersect: false,
                mode: 'index',
                caretPadding: 10,
                callbacks: {
                    label: function(tooltipItem, chart) {
                        var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
                        return datasetLabel + ': ' + number_format(tooltipItem.yLabel) + '%'; // Add '%' sign
                    }
                }
            }
        }
    });

    // BMI(체질량지수) 차트 - bar차트
    var ctx = document.getElementById("bmiChart");
    var mybarChart = new Chart(ctx, {
        type: 'bar', 
        data: {
            labels: labels,
            datasets: [{
                label: "BMI",
                backgroundColor: "rgba(255, 105, 180, 0.6)", 
                borderColor: "rgba(255, 20, 147, 1)",
                pointRadius: 3,
                pointBackgroundColor: "rgba(255, 20, 147, 1)",
                pointBorderColor: "rgba(255, 20, 147, 1)",
                pointHoverRadius: 3,
                pointHoverBackgroundColor: "rgba(255, 20, 147, 1)",
                pointHoverBorderColor: "rgba(255, 20, 147, 1)",
                pointHitRadius: 10,
                pointBorderWidth: 2,
                fill: true, 
                data: bmiArr, // bmi 최근 6개 데이터 
            }],
        },
        options: {
            maintainAspectRatio: false,
            layout: {
                padding: {
                    left: 10,
                    right: 25,
                    top: 25,
                    bottom: 0
                }
            },
            scales: {
                xAxes: [{
                    gridLines: {
                        display: false,
                        drawBorder: false
                    },
                    ticks: {
                        maxTicksLimit: 6
                    }
                }],
                yAxes: [{
                    ticks: {
                        beginAtZero: true,
                        min:0,
                        max:60,
                        callback: function(value) {
                            if (value < 16.0) return '~16.0%';
                            else if (value < 18.5) return '18.5%';
                            else if (value < 30.0) return '30.0%'; 
                            else if (value < 35.0) return '35.0%';
                            else return '50.0%~'; 
                        },
                        maxTicksLimit: 5,
                        stepSize:1
                    },
                    gridLines: {
                        color: "rgb(234, 236, 244)",
                        zeroLineColor: "rgb(234, 236, 244)",
                        drawBorder: false,
                        borderDash: [2],
                        zeroLineBorderDash: [2]
                    }
                }],
            },
            legend: {
                display: false
            },
            tooltips: {
                titleMarginBottom: 10,
                titleFontColor: '#6e707e',
                titleFontSize: 14,
                backgroundColor: "rgb(255,255,255)",
                bodyFontColor: "#858796",
                borderColor: '#dddfeb',
                borderWidth: 1,
                xPadding: 15,
                yPadding: 15,
                displayColors: false,
                caretPadding: 10,
                callbacks: {
                    label: function(tooltipItem, chart) {
                        var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
                        return datasetLabel + ': ' + tooltipItem.yLabel; // Show the raw value in tooltip
                    }
                }
            },
        }
    });

    // FAT(체지방량) 차트 - bar차트
     var ctx = document.getElementById("fatChart");
     var mybarChart = new Chart(ctx, {
         type: 'bar', 
         data: {
             labels: labels,
             datasets: [{
                 label: "체지방률",
                 backgroundColor: "rgba(255, 191, 0, 0.7)", 
                 borderColor: "rgba(255, 191, 0, 1)",
                 pointRadius: 3,
                 pointBackgroundColor: "rgba(255, 191, 0, 1)",
                 pointBorderColor: "rgba(255, 191, 0, 1)",
                 pointHoverRadius: 3,
                 pointHoverBackgroundColor: "rgba(255, 191, 0, 1)",
                 pointHoverBorderColor: "rgba(255, 191, 0, 1)",
                 pointHitRadius: 10,
                 pointBorderWidth: 2,
                 fill: true, 
                 data: fatArr, // 체지방량 최근 6개 데이터
             }],
         },
         options: {
             maintainAspectRatio: false,
             layout: {
                 padding: {
                     left: 10,
                     right: 25,
                     top: 25,
                     bottom: 0
                 }
             },
             scales: {
                 xAxes: [{
                     gridLines: {
                         display: false,
                         drawBorder: false
                     },
                     ticks: {
                         maxTicksLimit: 6
                     }
                 }],
                 yAxes: [{
                    ticks: {
                        min:0,
                        max:40,
                        beginAtZero: true,
                        maxTicksLimit: 5,
                        callback: function(value) {
                            if (value <= 5) return '~ 5.0%'; 
                            else if (value > 5 && value <= 14) return '14.0%'; 
                            else if (value > 14 && value <= 25) return '25.0%'; 
                            else if (value > 25 && value <= 30) return '30.0%'; 
                            else return '30.0% ~'; 
                        }
                     },
                     gridLines: {
                         color: "rgb(234, 236, 244)",
                         zeroLineColor: "rgb(234, 236, 244)",
                         drawBorder: false,
                         borderDash: [2],
                         zeroLineBorderDash: [2]
                     }
                 }],
             },
             legend: {
                 display: false
             },
             tooltips: {
                 titleMarginBottom: 10,
                 titleFontColor: '#6e707e',
                 titleFontSize: 14,
                 backgroundColor: "rgb(255,255,255)",
                 bodyFontColor: "#858796",
                 borderColor: '#dddfeb',
                 borderWidth: 1,
                 xPadding: 15,
                 yPadding: 15,
                 displayColors: false,
                 caretPadding: 10,
                 callbacks: {
                     label: function(tooltipItem, chart) {
                         var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
                         return datasetLabel + ': ' + tooltipItem.yLabel; // Show the raw value in tooltip
                     }
                 }
             },
         }
     });
 
    
    })

