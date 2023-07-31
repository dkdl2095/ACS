<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dbsql.DBSQL"%>
<%@ page import="table.Post"%>
<%@page import="java.sql.Date"%>
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
<title>게시글 생성 및 수정 화면</title>
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
				<!-- 회원가입 버튼 -->
				<li class="nav-item"><a id="btnSignup" class="nav-link"
					href="#">회원가입</a></li>
				<!-- 로그인 버튼 -->
				<li class="nav-item"><a id="btnLogin" class="nav-link" href="#">로그인</a></li>
				<!-- 내 정보 버튼 -->
				<li class="nav-item"><a id="btnMyInfo" class="nav-link"
					href="#">내 정보</a></li>
				<!-- 관리자 버튼-->
				<li class="nav-item"><a id="btnAdmin" class="nav-link"
					href="AdminView.jsp">관리자</a></li>
				<!-- 로그아웃 버튼 -->
				<li class="nav-item"><a id="btnLogout" class="nav-link"
					href="#">로그아웃</a></li>
			</ul>
		</div>
	</nav>

	<div class="container mt-3">
		<!-- 글꼴, 크기, 글 색상 설정 -->
		<div class="row">
			<div class="col-md-3">폰트</div>
			<div class="col-md-3">사이즈</div>
			<div class="col-md-3">색</div>
			<div class="col-md-3">이미지 삽입</div>

			<div class="col-md-3">
				<select id="fontSelect" class="form-select form-select-sm"
					aria-label=".form-select-sm example">
					<option value="Font" selected>Font</option>
					<option value="'Arial, sans-serif'">Arial</option>
					<option value="'Times New Roman, serif'">Times New Roman</option>
					<option value="'Courier New, monospace'">Courier New</option>
				</select>
			</div>
			<div class="col-md-3">
				<select id="sizeSelect" class="form-select form-select-sm"
					aria-label=".form-select-sm example">
					<option value="Size" selected>Size</option>
					<option value="'12px'">12</option>
					<option value="'14px'">14</option>
					<option value="'16px'">16</option>
				</select>
			</div>
			<div class="col-md-3">
				<select id="colorSelect" class="form-select form-select-sm"
					aria-label=".form-select-sm example">
					<option value="Color" selected>Color</option>
					<option value="'black'">검정</option>
					<option value="'red'">빨강</option>
					<option value="'blue'">파랑</option>
				</select>
			</div>
			<div class="col-md-3">
				<!-- <label for="imageInput" class="form-label">이미지 삽입</label> -->
				<input type="file" class="form-control" id="imageInput"
					accept="image/*" onchange="insertImage()">
			</div>
		</div>
	</div>

	<div class="container mt-3">
		<!-- 텍스트 박스 -->
		<div class="mb-3">
			<label for="postContent" class="form-label">게시글 내용</label>
			<textarea class="form-control" id="postContent" rows="5"></textarea>
		</div>
		<button onclick="applyFontAndSize()">Apply Style</button>
		<button onclick="preview()">Preview</button>
	</div>
	<div id="previewArea"></div>
	<script>
		function applyFontAndSize() {
			var selectedFont = $("#fontSelect").val();
			var selectedSize = $("#sizeSelect").val();
			var selectedColor = $("#colorSelect").val();
			var textArea = document.getElementById("postContent");
			var selectedText = textArea.value.substring(
					textArea.selectionStart, textArea.selectionEnd);

			console.log("Selected font:", selectedFont);
			console.log("Selected size:", selectedSize);
			console.log("Selected color:", selectedColor);
			console.log("Selected text:", selectedText);

			if (selectedFont == "Font" && selectedSize == "Size"
					&& selectedColor == "Color") {
				alert("스타일을 선택해 주세요.");
				return;
			}

			if (!selectedText) {
				alert("텍스트를 선택해 주세요.");
				return;
			}

			var styleText = "";
			if (selectedFont != "Font") {
				styleText += 'font-family:' + selectedFont.replace(/'/g, "")
						+ ';'; // 따옴표 제거
			}
			if (selectedSize != "Size") {
				styleText += 'font-size:' + selectedSize.replace(/'/g, "")
						+ ';'; // 따옴표 제거
			}
			if (selectedColor != "Color") {
				styleText += 'color:' + selectedColor.replace(/'/g, "") + ';'; // 따옴표 제거
			}

			console.log("styleText:", styleText);

			if (styleText) {
				var styledText = '[style ' + styleText + ']' + selectedText
						+ '[/style]';
				console.log("styledText:", styledText);
				console.log("styleText:", styleText);
				console.log("selectedText:", selectedText);
				var updatedText = textArea.value.substring(0,
						textArea.selectionStart)
						+ styledText
						+ textArea.value.substring(textArea.selectionEnd);
				textArea.value = updatedText;
			}
		}

		function preview() {
			var textArea = document.getElementById("postContent");
			var content = textArea.value;
			content = content.replace(/\[style (.*?)\]/g, function(_, style) {
				return '<span style="' + style + '">';
			});
			content = content.replace(/\[\/style\]/g, '</span>');
			document.getElementById("previewArea").innerHTML = content;
		}
	</script>

	<div class="container mt-3">
		<!-- 확인 버튼 -->
		<a href="#" class="btn btn-primary" id="btnConfirm">확인</a>
		<% boolean Confirm = true;%>
	</div>
	<%-- Java 코드 작성 (스크립트릿) --%>
	<%
	// 요청 파라미터에서 confirm 값을 확인하여 데이터 삽입 여부를 결정
	if (Confirm == true) {
		// DBSQL 객체 생성	
		Post newPost = new Post();
		DBSQL dbsql = new DBSQL("Post",newPost,null,null,null);
		newPost.setPostid(1); // 원하는 값을 설정합니다.
		newPost.setType("type");
		newPost.setText(request.getParameter("postContent"));
		newPost.setWritingdate(new Date(System.currentTimeMillis()));
		newPost.setName("name");
		newPost.setImg("img");
		newPost.setViewsnum(0);
		
		System.out.println("12"+newPost);
		System.out.println("Post ID: " + newPost.getPostid());
		System.out.println("Type: " + newPost.getType());
		System.out.println("Text: " + newPost.getText());
		System.out.println("Date: " + newPost.getWritingdate());
		System.out.println("Name: " + newPost.getName());
		System.out.println("img: " + newPost.getImg());
		System.out.println("ViewsNum: " + newPost.getViewsnum());
		// 데이터를 삽입합니다.
		dbsql.DBInsert();
		
	}
	%>
	<script>
		// 확인 버튼 클릭 이벤트 처리
		document.getElementById("btnConfirm").addEventListener("click",
				function() {
					// 스크립트릿이 동작하도록 confirm 파라미터를 추가하여 현재 페이지를 리로드합니다.
					window.location.href = "MainView.jsp";
				});
	</script>
	<script>
		function insertImage() {
			var textArea = document.getElementById("postContent");
			textArea.value += "\n"; // 이미지 첨부 후 줄 바꿈 처리
		}

		$(document).ready(function() {
			// 초기 로그인 상태는 회원가입 버튼만 보이도록 설정
			$("#btnMyInfo").hide();
			$("#btnLogout").hide();
			$("#btnAdmin").hide();

			// 로그인 버튼을 클릭하면 내 정보와 로그아웃 버튼이 토글됨
			$("#btnLogin").click(function() {
				$("#btnMyInfo").toggle();
				$("#btnAdmin").toggle();
				$("#btnLogout").toggle();
				$("#btnLogin").hide();
				$("#btnSignup").hide();
			});

			// 로그아웃 버튼을 클릭하면 내 정보와 로그아웃 버튼이 사라짐
			$("#btnLogout").click(function() {
				$("#btnMyInfo").hide();
				$("#btnLogout").hide();
				$("#btnAdmin").hide();
				// 로그인 버튼과 회원가입 버튼을 보이게 함
				$("#btnSignup").show();
				$("#btnLogin").show();
			});
		})
	</script>
</body>
</html>