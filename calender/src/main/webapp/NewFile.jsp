<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>calendar</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">
    
        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                timeZone: 'UTC',
                locale: 'ko', // 한국어 설정
                initialView: 'dayGridMonth', // 홈페이지에서 다른 형태의 view를 확인할  수 있다.
                
                events:[ // 일정 데이터 추가 , DB의 event를 가져오려면 JSON 형식으로 변환해 events에 넣어주면된다.
                    {
                        title:'에이펙스하기너무무섭다',
                        start:'2023-07-25',
                        end:'2023-08-08',
                   		url:'https://google.com'
                    },
                    {
                        title:'문명6달리는날',
                        start:'2023-07-26',
                        end:'2023-08-09',
                        url:'https://google.com'
                    },
                    {
                        title:'문명6달리는날',
                        start:'2023-07-26',
                        end:'2023-08-09',
                        url:'https://google.com'
                    }
                    
                ],
                eventClick: function(info) {//이벤트 클릭 시 알럿창으로 이벤트페이지 정보 및 링크 알림 후, 페이지이동
                    alert('Event: ' + info.event.title);
                    
                    // change the border color just for fun
                    info.el.style.borderColor = 'red';
                  },
                editable: false //치훈이형 일정 드래그해서 바꿀려면 이거 true로 바꿔. 근데 DB적용시키려면 코드 좀 건드려야할듯
            });
            calendar.render();
        });
    </script>
    <style>
        #calendarBox{
            width: 100%;
        }

    </style>
</head>
<body>
    <div id="calendarBox">
        <div id="calendar"></div>
    </div>

    <!-- 일정 추가/삭제(이건 관리자 뷰에서 추가) -->
    <div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="taskId" class="col-form-label">일정 내용</label>
                        <input type="text" class="form-control" id="calendar_content" name="calendar_content">
                        <label for="taskId" class="col-form-label">시작 날짜</label>
                        <input type="date" class="form-control" id="calendar_start_date" name="calendar_start_date">
                        <label for="taskId" class="col-form-label">종료 날짜</label>
                        <input type="date" class="form-control" id="calendar_end_date" name="calendar_end_date">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" id="addCalendar">추가</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"
                        id="sprintSettingModalClose">취소</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 일정 추가/삭제 끝 -->
</body>
</html>