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
    // PostCreationEditing.jsp
    String postContent = request.getParameter("postContent");
	String postTitle = request.getParameter("postTitle");
    String btnConfirm = request.getParameter("btnConfirm");
    String notice = request.getParameter("notice");
    String Schedule = request.getParameter("Schedule");
    String Radio ="";
    
 	// PostManagement.jsp
    String btnPostDelete = request.getParameter("btnPostDelete");
   	int postid = Integer.parseInt(request.getParameter("id"));
    
    if(notice.equals("true")){
    	Radio = "공지";
    }else if(Schedule.equals("true")){
    	Radio = "일정";
    }else{
    	Radio = "잡담";
    }
    
    // 요청 파라미터에서 confirm 값을 확인하여 데이터 삽입 여부를 결정
    if (btnConfirm != null && btnConfirm.equals("true")) {
        // DBSQL 객체 생성
        Post post = new Post();
        DBSQL dbsql = new DBSQL("Post");
        //newPost.setPostid(2); // 원하는 값을 설정합니다.
        post.setType(Radio);
        post.setTitle(postTitle);
        post.setText(postContent);
        post.setWritingdate(new Date(System.currentTimeMillis()));
        post.setName("name");
        post.setImg("img");
        post.setViewsnum(0);
        
        // 데이터를 삽입합니다.
        dbsql.DBInsert(post);

        // Send the response to the Eclipse console using JSP's 'out' object
        out.println("요청이 성공적으로 처리되었습니다.");
        out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); // You can customize this message as needed
    }
    
    // 관리자가 글 삭제
    if (btnPostDelete != null && btnPostDelete.equals("true")) {
        // DBSQL 객체 생성
        Post post = new Post();
        DBSQL dbsql = new DBSQL("Post");
        
        // 데이터를 삽입합니다.
        dbsql.DBDelete(post, postid);

        // Send the response to the Eclipse console using JSP's 'out' object
        out.println("요청이 성공적으로 처리되었습니다.");
        out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); // You can customize this message as needed
    }
%>
</body>
</html>