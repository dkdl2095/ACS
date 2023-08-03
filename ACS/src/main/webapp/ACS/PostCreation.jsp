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
    String postTitle = request.getParameter("postTitle");
    String btnConfirm = request.getParameter("btnConfirm");
    String notice = request.getParameter("notice");
    String Schedule = request.getParameter("Schedule");
    String Radio = "";

    // 라디오 버튼 값에 따라 글의 타입 설정
    if (notice.equals("true")) {
        Radio = "공지";
    } else if (Schedule.equals("true")) {
        Radio = "일정";
    } else {
        Radio = "잡담";
    }

    // 요청 파라미터에서 confirm 값을 확인하여 데이터 삽입 여부를 결정
    if (btnConfirm != null && btnConfirm.equals("true")) {
        // DBSQL 객체 생성
        Post post = new Post();
        DBSQL dbsql = new DBSQL("Post");
        post.setType(Radio);
        post.setTitle(postTitle);
        post.setText(postContent);
        post.setWritingdate(new Date(System.currentTimeMillis()));
        post.setName("name");
        post.setImg("img");
        post.setViewsnum(0);

        // 데이터를 삽입합니다.
        dbsql.DBInsert(post);

        // Eclipse 콘솔로 응답을 보냅니다. JSP의 'out' 객체를 사용합니다.
        out.println("요청이 성공적으로 처리되었습니다.");
        out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); 
    }
%>
</body>
</html>
