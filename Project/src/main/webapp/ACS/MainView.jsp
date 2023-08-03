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
<!-- 아래 스크립트는 달력 관련 -->
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.css">
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.js"></script>
<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- FullCalendar 라이브러리를 이용하여 일정을 표시하는 부분 -->
<script type="text/javascript">
    // FullCalendar 라이브러리 초기화 및 설정
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            timeZone: 'UTC',
            locale: 'ko', // 한국어 설정
            initialView: 'dayGridMonth', // 달력 초기 뷰를 '월' 형태로 설정

            // 이벤트 데이터 설정 (임시 데이터)
            events: [
                {
                    title: '에이펙스하기너무무섭다',
                    start: '2023-07-25',
                    end: '2023-08-08',
                    url: 'https://google.com'
                },
                {
                    title: '문명6달리는날',
                    start: '2023-07-26',
                    end: '2023-08-09',
                    url: 'https://google.com'
                },
                {
                    title: '문명6달리는날',
                    start: '2023-07-26',
                    end: '2023-08-09',
                    url: 'https://google.com'
                }
            ],
            // 이벤트 클릭 시 동작하는 함수
            eventClick: function(info) {
                alert('Event: ' + info.event.title);
                info.el.style.borderColor = 'red'; // 이벤트를 클릭한 요소의 테두리 색상 변경
            },
            editable: false // 일정 드래그해서 변경할 수 있는 옵션 (true로 설정하면 일정을 드래그해 수정할 수 있습니다.)
        });
        calendar.render(); // 달력 표시
    });
</script>
<style>
#calendarBox {
	width: 100%;
}
</style>
<title>메인 화면</title>
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

	<div class="container mt-3">
		<!-- 그리드 시스템을 사용하여 달력의 정보, 일정의 글 목록, 로그인 시에만 보이는 회원정보를 한 줄로 배치 -->
		<div class="row">
			<div class="col-lg-8">
				<!-- 달력의 정보를 받아들이는 div -->
				<div class="card">
					<div class="card-body">
						<!-- 달력 정보를 표시하는 내용 -->
						<div id="calendarBox">
							<div id="calendar"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<!-- 회원정보 표시하는 부분 -->
				<!-- 로그인 시에만 보이는 회원정보 div -->
				<div id="memberInfo" class="card">
					<div class="card-body">
						<%-- Java 코드 작성 (스크립트릿) --%>
						<!-- 회원정보를 표시하는 플레이스홀더 요소 -->
						<%
						// Java 코드 작성 (스크립트릿)
						// DBSQL 객체 생성
						DBSQL dbsql = new DBSQL("TENANTCOMPLET");
						Tenant t = new Tenant();

						// 데이터베이스에서 회원 정보 가져오기
						List<Tenant> TenantMembers = dbsql.DBSelect(t); // 적절한 메서드를 호출하여 회원 정보를 가져오도록 수정해야 합니다.

						// 가져온 회원 정보를 사용하여 HTML 코드 작성
						if (TenantMembers.size() > 0) {
							for (Tenant obj : TenantMembers) {
								if (obj instanceof Tenant) {
							Tenant TenantMember = (Tenant) obj; // Tenant로 캐스팅
						%>
						<p>
							아이디:
							<%=TenantMember.getId()%>, 이름:
							<%=TenantMember.getName()%>, 가입날짜:
							<%=TenantMember.getAccessiondate()%>, 거주지:
							<%=TenantMember.getResidence()%></p>
						<%
						} else {
						// 적절한 타입이 아닌 경우 처리
						%>

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
				<!-- 일정의 글 목록을 받아들이는 div -->
				<div class="card">
					<div class="card-body">
						<!-- 일정 글 목록을 표시하는 내용 -->
						일정
						<%-- Java 코드 작성 (스크립트릿) --%>
						<!-- 글목록 정보를 표시하는 플레이스홀더 요소 -->
						<%
						// Java 코드 작성 (스크립트릿)
						// DBSQL 객체 생성
						DBSQL dbsqlScedule = new DBSQL("Post");
						Post pScedule = new Post();

						// 데이터베이스에서 글목록 가져오기
						List<Post> SceduleMembers = dbsqlScedule.DBSelect(pScedule, "일정"); // 적절한 메서드를 호출하여 글목록 정보를 가져오도록 수정해야 합니다.

						// 가져온 글목록 정보를 사용하여 HTML 코드 작성
						if (SceduleMembers.size() > 0) {
							for (Post obj : SceduleMembers) {
								if (obj instanceof Post) {
							Post SceduleMember = obj; // Post로 캐스팅
						%>
						<p>
							번호 :
							<%=SceduleMember.getPostid()%>, 타입:
							<%=SceduleMember.getType()%>, 타이틀:
							<%=SceduleMember.getTitle()%>, 이름:
							<%=SceduleMember.getName()%>, 조회수:
							<%=SceduleMember.getViewsnum()%>, 날짜:
							<%=SceduleMember.getWritingdate()%>, 텍스트:
							<%=SceduleMember.getText()%>
						</p>
						<%
						}
						}
						} else {
						%>
						<p>게시글이 없습니다.</p>
						<%
						}
						%>
					</div>
				</div>
			</div>


		</div>
	</div>

	<!-- 글 목록을 표시하는 부분 -->
	<div class="container mt-5">
		<div class="card">
			<div class="row justify-content-center">
				<div class="col-lg-1"><p>번호</p></div>
				<div class="col-lg-1"><p>타입</p></div>
				<div class="col-lg-5"><p>제목</p></div>
				<div class="col-lg-1"><p>작성자</p></div>
				<div class="col-lg-2"><p>작성일</p></div>
				<div class="col-lg-1"><p>조회</p></div>
				<div class="col-lg-1"><p>추천</p></div>
			</div>
			
			<div class="card-body">
				<%-- Java 코드 작성 (스크립트릿) --%>
				<!-- 글목록 정보를 표시하는 플레이스홀더 요소 -->
				<%
				// Java 코드 작성 (스크립트릿)
				// DBSQL 객체 생성
				DBSQL dbsqlPost = new DBSQL("Post");
				Post post = new Post();

				// 데이터베이스에서 글목록 가져오기
				List<Post> PostMembers = dbsqlPost.DBSelect(post); // 적절한 메서드를 호출하여 글목록 정보를 가져오도록 수정해야 합니다.

				// 가져온 글목록 정보를 사용하여 HTML 코드 작성
				if (PostMembers.size() > 0) {
					for (Post obj : PostMembers) {
						if (obj instanceof Post) {
					Post PostMember = obj; // Post로 캐스팅
				%>
				<div class="row">
                	<div class="col-lg-1"><p><%=PostMember.getPostid()%></p></div>
                	<div class="col-lg-1"><p><%=PostMember.getType()%></p></div>
                	<div class="col-lg-5"><button class="btn btn-link"
					onclick="viewPostDetails(<%=PostMember.getPostid()%>)"><p>
					<%=PostMember.getTitle()%></p></button></div>
                	<div class="col-lg-1"><p><%=PostMember.getName()%></p></div>
                	<div class="col-lg-2"><p><%=PostMember.getWritingdate()%></p></div>
                	<div class="col-lg-1"><p><%=PostMember.getViewsnum()%></p></div>
                	<div class="col-lg-1"><p>추천</p></div>
            	</div>
				
				<button class="btn btn-link"
					onclick="viewPostDetails(<%=PostMember.getPostid()%>)">
						
				</button>
				<%
				}
				}
				} else {
				%>
				<p>게시글이 없습니다.</p>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<!-- 페이지 -->
	<nav aria-label="Page navigation" class="mt-3">
		<ul class="pagination justify-content-center">
			<li class="page-item disabled"><a class="page-link" href="#"
				tabindex="-1" aria-disabled="true">&laquo;</a></li>
			<li class="page-item active"><a class="page-link" href="#">1</a></li>
			<li class="page-item"><a class="page-link" href="#">2</a></li>
			<li class="page-item"><a class="page-link" href="#">3</a></li>
			<li class="page-item"><a class="page-link" href="#">&raquo;</a>
			</li>
		</ul>
	</nav>

	<!-- 글쓰기 버튼과 검색 -->
	<div class="container mt-3">
		<div class="row">
			<div class="col-lg-8">
				<a href="PostCreationEditing.jsp" class="btn btn-primary">글쓰기</a>
			</div>
			<div class="col-lg-4">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="검색어를 입력하세요">
					<button class="btn btn-secondary" type="button">검색</button>
				</div>
			</div>
		</div>
	</div>

	<script>
    function viewPostDetails(postid) {
        // AJAX를 이용하여 서버에 글 상세 정보 요청
        console.log("ajax 보내기 전",postid);
        $.ajax({
            url: "PostDetailsView.jsp",
            type: "POST", // POST 메소드 사용
            data: { postid : postid },
            success: function(response) {
                // 성공시, 받은 응답으로 postdetailsview.jsp 페이지로 이동
                window.location.href = "PostDetailsView.jsp?postid=" + postid;
            },
            error: function(xhr, status, error) {
                // 필요한 경우 에러 처리
                console.error(error);
            }
        });
    }
</script>
</body>
</html>