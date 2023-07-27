<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 폼 만들기</title>
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
        <h2>회원가입</h2>
        <hr>
        <p>아래 내용을 기재하여 가입하세요.</p>
        <hr>
        <div class="mb-3">
            <label for="ID" class="form-label">아이디</label>
            <div class="input-group">
                <input type="text" id="ID" name="ID" class="form-control" aria-describedby="btnCheckDuplicate">
                <button class="btn btn-outline-primary" type="button" id="btnCheckDuplicate">중복확인</button>
            </div>
        </div>
        <div class="mb-3">
            <label for="PW" class="form-label">비밀번호</label>
            <div class="input-group">
                <input type="password" id="PW" name="PW" class="form-control" aria-describedby="btnShowPassword">
                <button class="btn btn-outline-primary" type="button" id="btnShowPassword">내용표시</button>
            </div>
        </div>
        <div class="mb-3">
            <label for="name" class="form-label">이름</label>
            <input type="text" id="name" name="name" class="form-control">
        </div>
        <div class="mb-3">
            <label for="address" class="form-label">거주지</label>
            <input type="text" id="address" name="address" class="form-control">
        </div>
        <div class="d-grid gap-2">
            <button class="btn btn-primary" type="button">가입승인요청</button>
            <button class="btn btn-secondary" type="button">취소</button>
        </div>
    </div>
</body>
</html>
