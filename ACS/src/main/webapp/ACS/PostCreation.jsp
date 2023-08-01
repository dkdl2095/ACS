<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date"%>
<%@ page import="dbsql.DBSQL"%>
<%@ page import="table.Post"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 생성</title>
</head>
<body>
<%-- Java 코드 작성 (스크립트릿) --%>
<%
    // 클라이언트로부터 전송된 데이터 받기
    String postContent = request.getParameter("postContent");
    String btnConfirm = request.getParameter("btnConfirm");
    
    // 요청 파라미터에서 confirm 값을 확인하여 데이터 삽입 여부를 결정
    if (btnConfirm != null && btnConfirm.equals("true")) {
        // DBSQL 객체 생성
        System.out.println("1234");
        Post newPost = new Post();
        DBSQL dbsql = new DBSQL("Post", newPost, null, null, null);
        newPost.setPostid(4); // 원하는 값을 설정합니다.
        newPost.setType("type");
        newPost.setText(postContent);
        newPost.setWritingdate(new Date(System.currentTimeMillis()));
        newPost.setName("name");
        newPost.setImg("img");
        newPost.setViewsnum(0);

        // 데이터를 삽입합니다.
        dbsql.DBInsert();
        // 데이터 삽입 후 MainView 뷰로 이동
        //response.sendRedirect("MainView.jsp");

        // Send the response to the Eclipse console using JSP's 'out' object
        out.println("요청이 성공적으로 처리되었습니다.");
        out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); // You can customize this message as needed
    }
%>
</body>
</html>
