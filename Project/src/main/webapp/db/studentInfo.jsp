<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
</head>
<body>
	<h2>회원정보</h2>[<a href="/Project/complet">새로고침</a>]
	<hr>
	<table border="1">
		<tr><th>아이디</th><th>이름</th><th>비밀번호</th><th>가입일</th><th>거주지</th></tr>
		<c:forEach items="${complets}" var="s">
			<tr>
				<td>${s.id}</td> <td>${s.name}</td> <td>${s.password}</td>
				<td>${s.accessiondate}</td> <td>${s.residence}</td>
			</tr>
		</c:forEach>
	</table>
	<h2>회원추가</h2>
	<hr>
	<form method="post" action="/Project/complet?action=insert">
		<label>아이디</label> <input type="text" name="id"><br>
		<label>이름</label> <input type="text" name="name"><br>
		<label>비밀번호</label> <input type="text" name="password"><br>
		<label>가입일</label> <input type="text" name="accessiondate"><br>
		<label>거주지</label> <input type="text" name="residence"><br>
		<button type="submit">등록</button>
	</form>
</body>
</html>