<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
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
    <div class="container">
        <h2>로그인</h2>
        <hr>
        <p>아이디와 비밀번호를 입력하여 로그인하세요.</p>
        <hr>
        <div class="mb-3">
            <label for="ID" class="form-label">아이디</label>
            <input type="text" id="ID" name="ID" class="form-control" aria-describedby="btnCheckDuplicate">
        </div>
        <div class="mb-3">
            <label for="PW" class="form-label">비밀번호</label>
            <input type="password" id="PW" name="PW" class="form-control" aria-describedby="btnShowPassword">               
        </div>
        <div class="d-grid gap-2">
            <button class="btn btn-primary" type="button">로그인</button>
            <button class="btn btn-secondary" type="button">취소</button>
        </div>
    </div>
</body>
</html>
