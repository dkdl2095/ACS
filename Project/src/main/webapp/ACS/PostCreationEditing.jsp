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

	<form id="postForm" action="PostCreationEditing.jsp" method="post">
		<div class="container mt-3">
			<!-- 텍스트 박스 -->
			<div class="mb-3">
				<label for="postContent" class="form-label">게시글 내용</label>
				<textarea class="form-control" id="postContent" rows="5"></textarea>
			</div>
		</div>
	</form>
	<div class="container mt-3">
		<button onclick="applyFontAndSize()">Apply Style</button>
		<button onclick="preview()">Preview</button>
		<div id="previewArea"></div>
		<!-- 확인 버튼 -->
		<button type="submit" class="btn btn-primary" id="btnConfirm">확인</button>
	</div>


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

		// 페이지 로드 시, 저장된 데이터를 텍스트 박스에 복원합니다.
		window.onload = function() {
			var savedFont = localStorage.getItem("selectedFont");
			var savedSize = localStorage.getItem("selectedSize");
			var savedColor = localStorage.getItem("selectedColor");
			var savedContent = localStorage.getItem("postContent");
			if (savedFont) {
				$("#fontSelect").val(savedFont);
			}
			if (savedSize) {
				$("#sizeSelect").val(savedSize);
			}
			if (savedColor) {
				$("#colorSelect").val(savedColor);
			}
			if (savedContent) {
				document.getElementById("postContent").value = JSON
						.parse(savedContent);
			}
			console.log("savedFont:", savedFont);
			console.log("savedSize:", savedSize);
			console.log("savedColor:", savedColor);
			console.log("savedContent:", JSON.parse(savedContent));
		};

		// 페이지가 unload 될 때, 입력된 내용을 저장합니다.
		window.onbeforeunload = function() {
			var selectedFont = $("#fontSelect").val();
			var selectedSize = $("#sizeSelect").val();
			var selectedColor = $("#colorSelect").val();
			var textArea = document.getElementById("postContent");
			localStorage.setItem("selectedFont", selectedFont);
			localStorage.setItem("selectedSize", selectedSize);
			localStorage.setItem("selectedColor", selectedColor);
			localStorage.setItem("postContent", JSON.stringify(textArea.value));
			console.log("selectedFont:", selectedFont);
			console.log("selectedSize:", selectedSize);
			console.log("selectedColor:", selectedColor);
			console.log("textArea:", JSON.stringify(textArea.value));
		};

		// 확인 버튼 클릭 이벤트 처리
		document.getElementById("btnConfirm").addEventListener("click",
				function() {
					var textArea = document.getElementById("postContent");
					var postContent = textArea.value;

					// AJAX 요청을 보냅니다.
					$.ajax({
						url : "PostCreation.jsp",
						method : "POST",
						data : {
							postContent : postContent,
							btnConfirm : "true"
						},
						success : function(response) {
							// 요청이 성공적으로 처리되었을 때 실행되는 코드
							console.log("요청이 성공적으로 처리되었습니다.");
							console.log("서버 응답: ", response); // Log server response to browser console
							// 여기서 필요한 추가 작업 수행
						},
						error : function(xhr, status, error) {
							// 요청이 실패하거나 에러가 발생했을 때 실행되는 코드
							console.error("요청이 실패하였습니다.");
							console.error(xhr, status, error);
						}
					});
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