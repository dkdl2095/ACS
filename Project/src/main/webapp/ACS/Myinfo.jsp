<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>내 정보 관리 창</title>
<style>
    body {
        padding-top: 20px;
        background-color: #f9f9f9;
    }

    h2 {
        text-align: center;
    }

    label {
        width: 100px;
    }

    input[type="text"], input[type="password"] {
        width: 240px;
    }

    button {
        cursor: pointer;
    }

</style>
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
				<li class="nav-item"><a id="btnAdmin" class="nav-link" href="AdminView.jsp">관리자</a></li>
				<!-- 로그아웃 버튼 -->
				<li class="nav-item"><a id="btnLogout" class="nav-link"
					href="#">로그아웃</a></li>
			</ul>
		</div>
	</nav>
	
	

    <div class="container" id="MyInfoForm" style="display: none;">
        <h2>내 정보 관리</h2>
        <hr>
        <p>소중한 내 정보를 확인하세요.</p>
        <hr>
        <div class="mb-3">
            <label for="joinDate" class="form-label">가입날짜</label>
            <input type="text" id="joinDate" name="joinDate" class="form-control" readonly>
        </div>
        <div class="mb-3">
            <label for="ID" class="form-label">아이디</label>
            <input type="text" id="ID" name="ID" class="form-control" readonly>
        </div>        
        <div class="mb-3">
            <label for="name" class="form-label">이름</label>
            <input type="text" id="name" name="name" class="form-control">
        </div>        
        <div class="mb-3">
            <label for="address" class="form-label">거주지</label>
            <input type="text" id="address" name="address" class="form-control">
        </div>
        <div class="mb-3">
            <label for="myPosts" class="form-label">내가 쓴 글</label>
            <div class="input-group">
                <input type="text" id="myPosts" name="myPosts" class="form-control" readonly>
                <button class="btn btn-outline-secondary" type="button" id="btnEditPost">수정</button>
                <button class="btn btn-outline-secondary" type="button" id="btnDeletePost">삭제</button>
            </div>
        </div>
        <div class="mb-3">
            <label for="myComments" class="form-label">내가 쓴 댓글</label>
            <div class="input-group">
                <input type="text" id="myComments" name="myComments" class="form-control" readonly>
                <button class="btn btn-outline-secondary" type="button" id="btnEditComment">수정</button>
                <button class="btn btn-outline-secondary" type="button" id="btnDeleteComment">삭제</button>
            </div>
        </div>
        <button class="btn btn-primary">적용</button>
        <button class="btn btn-secondary">돌아가기</button>
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
			
			//회원가입 버튼 클릭 시 회원가입 창이 보여짐
			 $("#btnMyInfo").click(function() {
			        $("#MyInfoForm").show();
			    });
		});
	</script>
</body>
</html>
