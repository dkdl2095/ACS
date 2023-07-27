<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
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

    <div class="container">
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
</body>
</html>
