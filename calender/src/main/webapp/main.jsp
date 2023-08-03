<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dbsql.DBSQL"%>
<%@ page import="table.Tenant"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 아래 스크립트는 달력 관련 -->
<meta http-equiv='X-UA-Compatible' content='IE=edge'> 
<meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.js"></script>
    <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
    <script type="text/javascript">
    
        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                timeZone: 'UTC',
                locale: 'ko', // 한국어 설정
                initialView: 'dayGridMonth', // 홈페이지에서 다른 형태의 view를 확인할  수 있다.
                
                events: <%= getEventsFromDB() %>,// 일정 데이터 추가 , DB의 event를 가져오려면 JSON 형식으로 변환해 events에 넣어주면된다.
                    
                eventClick: function(info) {//이벤트 클릭 시 알럿창으로 이벤트페이지 정보 및 링크 알림 후, 페이지이동
                    alert('Event: ' + info.event.title);
                    
                    // 보더(테두리) 색 바꾸기
                    info.el.style.borderColor = 'red';
                  },
                editable: false, //드래그로 수정하기 원할경우 true
                dayMaxEvents: true, //최대 이벤트 개수 초과 시 아래에 따로 기재
                expandRows: true //화면에 맞게 확장/축소
            });
            calendar.render();
        });
        function getEventsFromDB() {
            <%-- Java 코드 작성 (스크립트릿) --%>
            <%-- DBSQL 객체 생성 --%>
            var dbsql = new dbsql.DBSQL("CALENDER");
            <%-- 데이터베이스에서 일정 정보 가져오기 --%>
            var eventsData = dbsql.DBSelect("CALENDER");

            <%-- 가져온 회원 정보를 사용하여 JSON 형식으로 일정 데이터 생성 --%>
            var events = [];
            <% if (eventsData.size() > 0) {
                for (Object obj : eventsData) {
                    if (obj instanceof Calender) {
                        Tenant event = (Calender) obj; // Tenant로 캐스팅
            %>
            events.push({
                title: '<%= event.getName() %>', // 일정 제목으로 회원 이름 사용
                start: '<%= event.getStartDate() %>', // 일정의 시작 날짜
                end: '<%= event.getEndDate() %>', // 일정의 종료 날짜
                id: '<%= event.getId() %>' // 일정을 클릭했을 때 이동할 링크
            });
            <% }} %>

            <%-- 생성한 일정 데이터를 반환 --%>
            return events;
        }
    </script>
    <!--달력 스타일-->
    <style> 
        #calendarBox{
            width: 100%;
        }

    </style>
<title>메인 화면</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="MainView.jsp"> <!-- 로고 이미지 --> <!-- 
        로고 출처 
        https://pixabay.com/ko/vectors/%EB%8F%84%EC%8B%9C-%EB%8F%84%EB%A1%9C-%EC%A7%80%EC%97%AD-%EC%82%AC%ED%9A%8C-%EA%B1%B4%EB%AC%BC-2042634/
        pixabay - Ricinators
        --> <img src="Logo.png" alt="로고"
				style="width: 20%; height: auto; margin: 0 auto; display: block;">
			</a>
		</div>
	</nav>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<!-- 홈, 공지, 잡담, 일정 버튼 -->
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link" href="MainView.jsp">
						<!-- 홈 버튼 이미지 --> <img src="Home.png" alt="로고" height="30">
				</a></li>
				<li class="nav-item"><a class="nav-link" href="#">공지</a></li>
				<li class="nav-item"><a class="nav-link" href="#">잡담</a></li>
				<li class="nav-item"><a class="nav-link" href="#">일정</a></li>
			</ul>
			<!-- 내 정보, 로그아웃 버튼 -->
			<ul class="navbar-nav">
				<!-- 내 정보 버튼 -->
				<li class="nav-item"><a id="btnMyInfo" class="nav-link"
					href="#">내 정보</a></li>
				<!-- 관리자 버튼-->
				<li class="nav-item"><a id="btnAdmin" class="nav-link"
					href="AdminView.jsp">관리자</a></li>
				<!-- 로그아웃 버튼 -->
				<li class="nav-item"><a id="btnLogout" class="nav-link"
					href="#">로그아웃</a></li>
			</ul>
		</div>
	</nav>

	<div class="container mt-3">
		<!-- 그리드 시스템을 사용하여 달력의 정보, 일정의 글 목록, 로그인 시에만 보이는 회원정보를 한 줄로 배치 -->
		<div class="row">
			<div class="col-lg-4">
				<!-- 달력의 정보를 받아들이는 div -->
				<div class="card">
					<div class="card-body">
						<!-- 달력 정보를 표시하는 내용 -->
						<div id="calendarBox">
        					<div id="calendar"></div>
    					</div>
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<!-- 일정의 글 목록을 받아들이는 div -->
				<div class="card">
					<div class="card-body">
						<!-- 일정 글 목록을 표시하는 내용 -->
						일정
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<!-- 로그인 시에만 보이는 회원정보 div -->
				<div id="memberInfo" class="card">
					<div class="card-body">
						<%-- Java 코드 작성 (스크립트릿) --%>
						<!-- 회원정보를 표시하는 플레이스홀더 요소 -->
						<%
						// Java 코드 작성 (스크립트릿)
						// DBSQL 객체 생성
						DBSQL dbsql = new DBSQL("TENANTCOMPLET");

						// 데이터베이스에서 회원 정보 가져오기
						List<Object> members = dbsql.DBSelect("TENANTCOMPLET"); // 적절한 메서드를 호출하여 회원 정보를 가져오도록 수정해야 합니다.

						// 가져온 회원 정보를 사용하여 HTML 코드 작성
						if (members.size() > 0) {
							for (Object obj : members) {
								if (obj instanceof Tenant) {
							Tenant member = (Tenant) obj; // Tenant로 캐스팅
						%>
						<p>
							아이디:
							<%=member.getId()%>, 이름:
							<%=member.getName()%>, 가입날짜:
							<%=member.getAccessiondate()%>, 거주지:
							<%=member.getResidence()%></p>
						<%
						} else {
						// 적절한 타입이 아닌 경우 처리
						%>

						<p>회원 정보가 없습니다.</p>
						<%
						}
						}
						} else {
						%>
						<p>회원 정보가 없습니다.</p>
						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container mt-3">
		<div class="card">
			<div class="card-body">
				<!-- 게시글 목록을 표시하는 내용 -->
				<p>게시글 목록</p>
			</div>
		</div>
	</div>

	<!-- 페이지 -->
	<nav aria-label="Page navigation" class="mt-3">
		<ul class="pagination justify-content-center">
			<li class="page-item disabled"><a class="page-link" href="#"
				tabindex="-1" aria-disabled="true">&laquo;</a></li>
			<li class="page-item active"><a class="page-link" href="#">1</a></li>
			<li class="page-item"><a class="page-link" href="#">2</a></li>
			<li class="page-item"><a class="page-link" href="#">3</a></li>
			<li class="page-item"><a class="page-link" href="#">&raquo;</a>
			</li>
		</ul>
	</nav>

	<!-- 글쓰기 버튼과 검색 -->
	<div class="container mt-3">
		<div class="row">
			<div class="col-lg-8">
				<a href="PostCreationEditing.jsp" class="btn btn-primary">글쓰기</a>
			</div>
			<div class="col-lg-4">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="검색어를 입력하세요">
					<button class="btn btn-secondary" type="button">검색</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			// 초기 로그인 상태는 회원가입 버튼만 보이도록 설정
			/*$("#btnMyInfo").hide();
			$("#btnLogout").hide();
			$("#btnAdmin").hide();

			// 로그인 버튼을 클릭하면 내 정보와 로그아웃 버튼이 토글됨
			$("#btnLogin").click(function() {
				$("#btnMyInfo").toggle();
				$("#btnAdmin").toggle();
				$("#btnLogout").toggle();
				$("#btnLogin").hide();
				$("#btnSignup").hide();
			});

			// 로그아웃 버튼을 클릭하면 내 정보와 로그아웃 버튼이 사라짐
			$("#btnLogout").click(function() {
				$("#btnMyInfo").hide();
				$("#btnLogout").hide();
				$("#btnAdmin").hide();
				// 로그인 버튼과 회원가입 버튼을 보이게 함
				$("#btnSignup").show();
				$("#btnLogin").show();*/
			});
		});
	</script>
</body>
</html>
