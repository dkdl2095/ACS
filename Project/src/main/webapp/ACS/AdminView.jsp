<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dbsql.DBSQL"%>
<%@ page import="table.*"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>관리자 화면</title>
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
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<!-- 홈, 공지, 잡담, 일정 버튼 -->
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link" href="MainView.jsp">
						<!-- 홈 버튼 이미지 --> <img src="Home.png" alt="로고" height="30">
				</a></li>
				<li class="nav-item"><a class="nav-link" href="#">공지</a></li>
				<li class="nav-item"><a class="nav-link" href="#">잡담</a></li>
				<li class="nav-item"><a class="nav-link" href="#">일정</a></li>
			</ul>
			<!-- 내 정보, 로그아웃 버튼 -->
			<ul class="navbar-nav">
				<!-- 내 정보 버튼 -->
				<li class="nav-item"><a id="btnMyInfo" class="nav-link"
					href="Myinfo.jsp">내 정보</a></li>
				<!-- 관리자 버튼-->
				<li class="nav-item"><a id="btnAdmin" class="nav-link"
					href="AdminView.jsp">관리자</a></li>
				<!-- 로그아웃 버튼 -->
				<li class="nav-item"><a id="btnLogout" class="nav-link"
					href="Login.jsp">로그아웃</a></li>
			</ul>
		</div>
	</nav>

	<!-- 수락 대기중 라벨과 데이터베이스에서 받아온 정보를 표시하는 div -->
	<div class="container mt-2">
		<div class="card">
			<div class="card-header">수락 대기중</div>
			<div class="card-body">
				<div class="row">
					<%
					DBSQL dbsql = new DBSQL("TenantWait");
					Tenant t = new Tenant();

					// 데이터베이스에서 회원 정보 가져오기
					List<Object> TenantMembers = dbsql.DBSelect(t); // 적절한 메서드를 호출하여 회원 정보를 가져오도록 수정해야 합니다.

					// 가져온 회원 정보를 사용하여 HTML 코드 작성
					if (TenantMembers.size() > 0) {
						for (Object obj : TenantMembers) {
							if (obj instanceof Tenant) {
						Tenant TenantMember = (Tenant) obj; // Tenant로 캐스팅
					%>
					<div class="row">
						<div class="col-md-2">
							<p>
								<strong>입주자 아이디:</strong>
								<%=TenantMember.getId()%>
							</p>
						</div>
						<div class="col-md-2">
							<p>
								<strong>입주자 명:</strong>
								<%=TenantMember.getName()%>
							</p>
						</div>
						<div class="col-md-2">
							<p>
								<strong>거주지:</strong>
								<%=TenantMember.getAccessiondate()%>
							</p>
						</div>
						<div class="col-md-2">
							<p>
								<strong>가입일:</strong>
								<%=TenantMember.getResidence()%>
							</p>
						</div>
						<div class="col-md-2">
							<button class="btn btn-success btnAccept"
								data-id="<%=TenantMember.getId()%>"
								data-name="<%=TenantMember.getName()%>"
								data-password="<%=TenantMember.getPassword()%>"
								data-accessiondate="<%=TenantMember.getAccessiondate()%>"
								data-residence="<%=TenantMember.getResidence()%>">수락</button>
							<button class="btn btn-danger">거절</button>
						</div>
					</div>

					<%
					} else {
					%>
					<!-- 적절한 타입이 아닌 경우 처리 -->
					<p>회원 정보가 없습니다.</p>
					<%
					}
					}
					} else {
					%>
					<p>회원 정보가 없습니다.</p>
					<%
					}
					%>
				</div>
			</div>
		</div>
		<div class="col-lg-8">
			<a href="MemberManagement.jsp" class="btn btn-primary">회원 관리</a>
		</div>
		<nav aria-label="Page navigation" class="mt-3">
			<ul class="pagination justify-content-center">
				<li class="page-item disabled"><a class="page-link" href="#"
					tabindex="-1" aria-disabled="true">&laquo;</a></li>
				<li class="page-item active"><a class="page-link" href="#">1</a></li>
				<li class="page-item"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
			</ul>
		</nav>
	</div>

	<script>
		// 수락 버튼에 대한 클릭 이벤트 처리
		$(".btnAccept").on("click", function() {
			var id = $(this).data("id");
			var name = $(this).data("name");
			var password = $(this).data("password");
			var accessiondate = $(this).data("accessiondate");
			var residence = $(this).data("residence");

			// AJAX 요청을 보냅니다.
			$.ajax({
				url : "Tenant.jsp",
				method : "POST",
				data : {
					id : id,
					name : name,
					password : password,
					accessiondate : accessiondate,
					residence : residence,
					btnAccept : "true"
				},
				success : function(response) {
					// 요청이 성공적으로 처리되었을 때 실행되는 코드
					console.log("요청이 성공적으로 처리되었습니다.");
					console.log("서버 응답: ", response); // Log server response to browser console

					location.reload(); // 성공 후 페이지 새로 고침
				},
				error : function(xhr, status, error) {
					// 요청이 실패하거나 에러가 발생했을 때 실행되는 코드
					console.error("요청이 실패하였습니다.");
					console.error(xhr, status, error);
				}
			});
		});
	</script>
</body>
</html>