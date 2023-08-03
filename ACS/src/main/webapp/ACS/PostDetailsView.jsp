<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date"%>
<%@ page import="dbsql.DBSQL"%>
<%@ page import="table.Post"%>
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
	<%-- Java 코드 작성 (스크립트릿) --%>
	<%
	// 클라이언트로부터 전송된 데이터 받기
	String postidStr = request.getParameter("postid");
	System.out.println(postidStr);

	int postid = 0; // 기본값으로 초기화
	// postidStr이 null이 아니고 숫자 형태일 경우에만 Integer로 변환
	if (postidStr != null && postidStr.matches("\\d+")) {
		postid = Integer.parseInt(postidStr);
	}

	// DBSQL 객체 생성
	Post post = new Post();
	DBSQL dbsql = new DBSQL("Post");
	Post PostMember = null;

	// 데이터베이스에서 글목록 가져오기
	List<Object> PostMembers = dbsql.DBSelect(post, postid); // 적절한 메서드를 호출하여 글목록 정보를 가져오도록 수정해야 합니다.

	// 가져온 글목록 정보를 사용하여 HTML 코드 작성
	if (PostMembers.size() > 0) {
		for (Object obj : PostMembers) {
			if (obj instanceof Post) {
				PostMember = (Post) obj; // Post로 캐스팅
			}
		}
	} else {
		// 데이터가 없을 때의 처리 (예: "데이터가 없습니다" 메시지 출력 등)
	}
	%>
	<div class="container mt-3">
		<div class="card">
			<div class="card-header">
				<div class="row">
					<div class="col-md-3">
						<p>
							<strong>타입:</strong>
							<%=(PostMember != null) ? PostMember.getType() : "데이터가 없습니다"%>
						</p>
					</div>
					<div class="col-md-3">
						<p>
							<strong>제목:</strong>
							<%=(PostMember != null) ? PostMember.getTitle() : "데이터가 없습니다"%>
						</p>
					</div>
					<div class="col-md-3">
						<p>
							<strong>작성자:</strong>
							<%=(PostMember != null) ? PostMember.getName() : "데이터가 없습니다"%>
						</p>
					</div>
					<div class="col-md-3">
						<p>
							<strong>조회수:</strong>
							<%=(PostMember != null) ? PostMember.getViewsnum() : "데이터가 없습니다"%>
						</p>
					</div>
				</div>
			</div>
			<div class="card-body">
				<div class="col">
					<div id="textArea">
						<p><%=(PostMember != null) ? PostMember.getText() : "데이터가 없습니다"%></p>
					</div>
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
							<strong>댓글 작성자:</strong> [데이터베이스에서 받아온 댓글 작성자] <strong>댓글
								내용:</strong> [데이터베이스에서 받아온 댓글 내용] <strong>작성일:</strong> [데이터베이스에서 받아온
							작성일]
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		// 추천 버튼을 누르면 카운트 증가
		let recommendCount = 0;

		function recommend() {
			recommendCount++;
			document.getElementById("recommendCount").textContent = recommendCount;
		}
		function textAreaView() {
	        var textArea = document.getElementById("textArea");
	        var content = textArea.innerHTML;
	        content = content.replace(/\[style (.*?)\]/g, function(_, style) {
	            return '<span style="' + style + '">';
	        });
	        content = content.replace(/\[\/style\]/g, '</span>');
	        textArea.innerHTML = content;
	    }

	    // 함수 호출
	    textAreaView();
	</script>
</body>
</html>