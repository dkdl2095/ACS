<%@page import="dbsql.Insert"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date"%>
<%@ page import="dbsql.DBSQL"%>
<%@ page import="table.Post"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>댓글 생성</title>
</head>
<body>
<%-- Java 코드 작성 (스크립트릿) --%>
<%
// 클라이언트로부터 전송된 댓글 내용 받기
// 댓글 작성 요청 파라미터에서 confirm 값을 확인하여 데이터 삽입 여부를 결정
String commentPostId = request.getParameter("commentPostId");
String commentText = request.getParameter("commentText");
String btnConfirmComment = request.getParameter("btnConfirmComment");
System.out.println(commentPostId + commentText + btnConfirmComment); //테스트 코드
if (btnConfirmComment != null && btnConfirmComment.equals("true")) {
    // DBSQL 객체 생성
    Post post = new Post();
    Insert dbsqlInsert = new Insert("post"); // 댓글 데이터를 POST 테이블에 저장합니다.
	
    // 세션으로부터 가져온 name 변수를 comment의 writer로 설정
    String name = (String) session.getAttribute("NAME");
    post.setName(name);
    String id = (String) session.getAttribute("ID");
    post.setId(id);
    post.setTitle(commentPostId);
    post.setText(commentText);
    post.setWritingdate(new Date(System.currentTimeMillis()));
	post.setType("댓글");
	System.out.println("name: "+name+", id: "+id+", commentPostId: "+commentPostId+", commentText: "+commentText); //테스트 코드
    // 댓글 데이터를 삽입합니다.
    dbsqlInsert.DBInsert(post);

    // Send the response to the Eclipse console using JSP's 'out' object
    out.println("요청이 성공적으로 처리되었습니다.");
    out.println("서버 응답: " + "댓글이 성공적으로 저장되었습니다."); // You can customize this message as needed
}
%>
</body>
</html>