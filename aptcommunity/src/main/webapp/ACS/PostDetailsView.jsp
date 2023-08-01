<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>글 세부 화면</title>
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
				<!-- 회원가입 버튼 -->
				<li class="nav-item"><a id="btnSignup" class="nav-link"
					href="#">회원가입</a></li>
				<!-- 로그인 버튼 -->
				<li class="nav-item"><a id="btnLogin" class="nav-link" href="#">로그인</a></li>
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
		<div class="card">
			<div class="card-header">
				<div class="row">
					<div class="col-md-3">
						<p>
							<strong>타입:</strong> [데이터베이스에서 받아온 타입]
						</p>
					</div>
					<div class="col-md-3">
						<p>
							<strong>제목:</strong> [데이터베이스에서 받아온 제목]
						</p>
					</div>
					<div class="col-md-3">
						<p>
							<strong>작성자:</strong> [데이터베이스에서 받아온 작성자]
						</p>
					</div>
					<div class="col-md-3">
						<p>
							<strong>조회수:</strong> [데이터베이스에서 받아온 조회수]
						</p>
					</div>
				</div>
			</div>
			<div class="card-body">
				<div class="col">
					<p>[데이터베이스에서 받아온 글]</p>
					<div class="text-center">
						<p>
							<strong>추천수:</strong> <span id="recommendCount">0</span>
							<button class="btn btn-success" onclick="recommend()">추천</button>
						</p>
					</div>
				</div>
			</div>
			<div class="card-body">
				<div class="col">
					<!-- 댓글 라벨 -->
					<label for="comment"><strong>댓글:</strong></label>
					<!-- 댓글을 입력할 수 있는 텍스트 박스 -->
					<textarea class="form-control" id="comment" rows="3"
						placeholder="댓글을 입력하세요"></textarea>
					<div class="text-end">
						<!-- 확인 버튼 -->
						<button class="btn btn-primary mt-2" onclick="submitComment()">확인</button>
					</div>
				</div>
			</div>
			<div class="card-body">
				<div class="row mt-4">
					<div class="col">
						<!-- 댓글 작성자, 내용, 작성일 라벨 -->
						<p>
							<strong>댓글 작성자:</strong> [데이터베이스에서 받아온 댓글 작성자]
							<strong>댓글 내용:</strong> [데이터베이스에서 받아온 댓글 내용]
							<strong>작성일:</strong> [데이터베이스에서 받아온 작성일]
						</p>
					</div>
				</div>
			</div>

		</div>
	</div>

	<script>
		$(document).ready(function() {
			// 초기 로그인 상태는 회원가입 버튼만 보이도록 설정
			$("#btnMyInfo").hide();
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
				$("#btnLogin").show();
			});
		});

		// 추천 버튼을 누르면 카운트 증가
		let recommendCount = 0;

		function recommend() {
			recommendCount++;
			document.getElementById("recommendCount").textContent = recommendCount;
		}
	</script>
</body>
</html>