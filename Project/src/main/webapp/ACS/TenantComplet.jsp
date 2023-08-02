<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date"%>
<%@ page import="dbsql.DBSQL"%>
<%@ page import="table.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수락</title>
</head>
<body>
<%-- Java 코드 작성 (스크립트릿) --%>
<%
    // 클라이언트로부터 전송된 데이터 받기
    String btnAccept = request.getParameter("btnAccept");
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String password = request.getParameter("password");
    Date accessiondate = Date.valueOf(request.getParameter("accessiondate"));
    String residence = request.getParameter("residence");
    
    // 요청 파라미터에서 confirm 값을 확인하여 데이터 삽입 여부를 결정
    if (btnAccept != null && btnAccept.equals("true")) {
        // DBSQL 객체 생성
        Tenant tenant = new Tenant();
        DBSQL dbsql = new DBSQL("TenantComplet");
        tenant.setId(id);
        tenant.setName(name);
        tenant.setPassword(password);
        tenant.setAccessiondate(accessiondate);
        tenant.setResidence(residence);

        // 데이터를 삽입합니다.
        dbsql.DBInsert(tenant);

        // Send the response to the Eclipse console using JSP's 'out' object
        out.println("요청이 성공적으로 처리되었습니다.");
        out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); // You can customize this message as needed
        
        // 성공적으로 테이블 삽입 후에 기존에 있던 테이블에서 정보 삭제

        dbsql = new DBSQL("TenantWait");
        
        // 데이터 삭제
        dbsql.DBDelete(tenant, id);
    }
%>
</body>
</html>