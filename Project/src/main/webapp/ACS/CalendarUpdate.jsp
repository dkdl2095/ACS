<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dbsql.*"%>
<%@ page import="table.*"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
a.btn-link {
	text-decoration: none;
	color: black;
}
</style>
<title>일정 수정</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="MainView.jsp"> <!-- 로고 이미지 --> <!-- 
        로고 출처 
        https://pixabay.com/ko/vectors/%EB%8F%84%EC%8B%9C-%EB%8F%84%EB%A1%9C-%EC%A7%80%EC%97%AD-%EC%82%AC%ED%9A%8C-%EA%B1%B4%EB%AC%BC-2042634/
        pixabay - Ricinator
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
					href="Myinfo.jsp">내 정보</a></li>
				<!-- 관리자 버튼-->
				<li class="nav-item"><a id="btnAdmin" class="nav-link"
					href="AdminView.jsp">관리자</a></li>
				<!-- 로그아웃 버튼 -->
				<li class="nav-item"><a id="btnLogout" class="nav-link"
					href="Login.jsp">로그아웃</a></li>
			</ul>
		</div>
	</nav>
	<!-- 글 목록을 표시하는 부분 -->
	<div id="searchResultsContainer" class="container mt-5">
		<div class="card">
			<div class="row justify-content-center">
				<div class="col-lg-1">
					<p>번호</p>
				</div>
				<div class="col-lg-1">
					<p>타입</p>
				</div>
				<div class="col-lg-5">
					<p>제목</p>
				</div>
				<div class="col-lg-1">
					<p>작성자</p>
				</div>
				<div class="col-lg-2">
					<p>작성일</p>
				</div>
				<div class="col-lg-1">
					<p>조회</p>
				</div>
				<div class="col-lg-1">
					<p>추천</p>
				</div>
			</div>

			<div class="card-body">
				<%-- Java 코드 작성 (스크립트릿) --%>
				<!-- 글목록 정보를 표시하는 플레이스홀더 요소 -->
				<%
				// Java 코드 작성 (스크립트릿)
				// DBSQL 객체 생성
				Select select = new Select("Calendar");
				Calendar calendar = new Calendar();
				int calid = Integer.parseInt(request.getParameter("calid"));

				// 데이터베이스에서 글목록 가져오기
				List<Calendar> CalendarMembers = select.DBSelect(calendar, calid); // 적절한 메서드를 호출하여 글목록 정보를 가져오도록 수정해야 합니다.

				// 가져온 글목록 정보를 사용하여 HTML 코드 작성
				if (CalendarMembers.size() > 0) {
					for (Calendar obj : CalendarMembers) {
						if (obj instanceof Calendar) {
							Calendar CalendarMember = obj; // Post로 캐스팅
				%>
				<div class="card">
					<div class="card-header">일정 추가</div>
					<div class="row">
						<div class="col-lg-1">기간:</div>
						<div class="col-lg-2">
							<input type="text" id="startdate" name="startdate" value="<%=CalendarMember.getStartdate()%>" readonly>
						</div>
						<div class="col-lg-1">~</div>
						<div class="col-lg-2">
							<input type="text" id="enddate" name="enddate" value="<%=CalendarMember.getEnddate()%>" readonly>
						</div>
						<div class="col-lg-1">내용:</div>
						<div class="col-lg-5">
							<input type="text" id="title" name="title" value="<%=CalendarMember.getText()%>">
						</div>
						<div class="col-lg-1">이미지:</div>
						<div id="postImg" contenteditable="true"></div>
						<div class="col-lg-3">
							<button class="btn btn-success btnCalendarInsert">일정 추가</button>
						</div>
					</div>
				</div>
				<%
				}
				}
				} else {
				%>
				<p>게시글이 없습니다.</p>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			$("#startdate").datepicker({
				dateFormat : "yy-mm-dd", // 선택된 날짜 형식
				minDate : 0, // 오늘 이전 날짜는 선택 불가능
			}).on("focus", function() {
				$(this).datepicker("show");
			});

			$("#enddate").datepicker({
				dateFormat : "yy-mm-dd", // 선택된 날짜 형식
				minDate : 0, // 오늘 이전 날짜는 선택 불가능
			}).on("focus", function() {
				$(this).datepicker("show");
			});
		});

		// 이미지 드래그 앤 드랍
		var editor = document.getElementById('postImg');

		editor.addEventListener('dragover', function(e) {
			e.stopPropagation();
			e.preventDefault();
			e.dataTransfer.dropEffect = 'copy';
		});

		editor.addEventListener('drop', function(e) {
			e.stopPropagation();
			e.preventDefault();

			var files = e.dataTransfer.files;
			var file = files[0];

			if (file.type.match('image.*')) {
				var reader = new FileReader();

				reader.onload = function(e) {
					var img = document.createElement('img');
					img.src = e.target.result;
					editor.appendChild(img);
				};

				reader.readAsDataURL(file);
			}
		});

		// 일정 추가 버튼에 대한 클릭 이벤트 처리
		$(".btnCalendarInsert").on("click", function() {
			var imgDiv = document.getElementById("postImg");
			var tilte = document.getElementById("title");
			var startdate = document.getElementById("startdate");
			var enddate = document.getElementById("enddate");
			var postImg = imgDiv.innerHTML;
			var postTitle = tilte.value;
			var calstartdate = startdate.value;
			var calenddate = enddate.value;
			// AJAX 요청을 보냅니다.
			$.ajax({
				url : "Calendar.jsp",
				method : "POST",
				data : {
					postImg : postImg,
					postTitle : postTitle,
					startdate : calstartdate,
					enddate : calenddate,
					btnCalendarInsert : "true"
				},
				success : function(response) {
					// 요청이 성공적으로 처리되었을 때 실행되는 코드
					console.log("요청이 성공적으로 처리되었습니다.");
					console.log("서버 응답: ", response); // Log server response to browser console

					window.location.href = "CalendarManagement.jsp";
				},
				error : function(xhr, status, error) {
					// 요청이 실패하거나 에러가 발생했을 때 실행되는 코드
					console.error("요청이 실패하였습니다.");
					console.error(xhr, status, error);
				}
			});
		});
	</script>
</body>
</html>