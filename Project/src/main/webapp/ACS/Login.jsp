<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="table.Tenant"%>
<%@ page import="java.util.List"%>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
	crossorigin="anonymous"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 창</title>
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

	<div class="container">
		<h2>로그인</h2>
		<hr>
		<p>아이디와 비밀번호를 입력하여 로그인하세요.</p>
		<hr>
		<div class="mb-3">
			<label for="ID" class="form-label">아이디</label> <input type="text"
				id="ID" name="ID" class="form-control"
				aria-describedby="btnCheckDuplicate">
		</div>
		<div class="mb-3">
			<label for="PW" class="form-label">비밀번호</label> <input
				type="password" id="PW" name="PW" class="form-control"
				aria-describedby="btnShowPassword">
		</div>
		<div class="d-grid gap-2">
			<a href="#" class="btn btn-primary">로그인</a> 
			<a href="Account.jsp" class="btn btn-secondary">회원가입</a>
		</div>
	</div>
	<script>
$(function () {
    $('#login').validate({
        rules: {
            id: {
                required: true
            },
            pw: {
                required: true,
                minlength: 4
            }
        },
        messages: {
            id: "아이디를 입력해주세요",
            pw: {
                required: "비밀번호를 입력해주세요",
                minlength: "비밀번호는 4자리 이상이어야 합니다"
            }
        }</script>

</body>
</html>
