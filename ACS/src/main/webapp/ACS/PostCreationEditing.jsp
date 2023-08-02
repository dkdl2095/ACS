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

	<form id="postForm" action="PostCreationEditing.jsp" method="post">
		<div class="container mt-3">
			<!-- 체크박스를 게시글 내용 우측에 추가 -->
			<!-- 
			
			 -->
			<div class="col-md-3">
				<input type="radio" id="noticeRadio" name="postType" value="notice">
				<label for="noticeRadio">공지</label> <input type="radio"
					id="idlechatRadio" name="postType" value="idlechat" checked>
				<label for="idlechatRadio">잡담</label> <input type="radio"
					id="ScheduleRadio" name="postType" value="Schedule"> <label
					for="ScheduleRadio">일정</label>
			</div>
			<!-- 텍스트 박스 -->
			<div class="mb-3">
				<label for="postTitle" class="form-label">제목</label>
				<textarea class="form-control" id="postTitle" rows="1"></textarea>
			</div>
		</div>
	</form>
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
				<textarea class="form-control" id="postContent" rows="20"></textarea>
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
		/*
		 // 특정 ID를 확인하여 공지/잡담 체크박스를 보이거나 숨깁니다.
		 function showHideCheckboxes() {
		 // 여기서 특정 ID 확인을 위한 로직을 추가하십시오.
		 // 예를 들어, 로그인 상태를 확인하거나 특정 사용자 정보를 기반으로 처리할 수 있습니다.
		 // 이 예제에서는 특정 ID가 아니면 잡담만 보이도록 처리하겠습니다.
		 const idlechatCheckbox = document
		 .getElementById("idlechatCheckbox");
		 const noticeCheckbox = document.getElementById("noticeCheckbox");

		 // 특정 ID가 아닌 경우, 공지 체크박스를 숨기고, 잡담 체크박스를 보이도록 설정
		 // 여기에서는 단순히 예시로 ID를 확인하는 로직은 작성하지 않았습니다. 필요한 조건을 추가하여 로직을 완성하십시오.
		 const isSpecialUser = false; // 여기서 true인 경우 특정 ID라고 가정
		 if (!isSpecialUser) {
		 chitchatCheckbox.style.display = "block";
		 noticeCheckbox.style.display = "none";
		 }
		 }*/

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

		// 페이지가 unload 될 때, 입력된 내용을 저장합니다.
		/*window.onbeforeunload = function() {
			var selectedFont = $("#fontSelect").val();
			var selectedSize = $("#sizeSelect").val();
			var selectedColor = $("#colorSelect").val();
			var textArea = document.getElementById("postContent");
			var titleArea = document.getElementById("postTitle");
			localStorage.setItem("selectedFont", selectedFont);
			localStorage.setItem("selectedSize", selectedSize);
			localStorage.setItem("selectedColor", selectedColor);
			localStorage.setItem("postContent", JSON.stringify(textArea.value));
			localStorage.setItem("postTitle", JSON.stringify(titleArea.value));
			console.log("selectedFont:", selectedFont);
			console.log("selectedSize:", selectedSize);
			console.log("selectedColor:", selectedColor);
			console.log("textArea:", JSON.stringify(textArea.value));
			console.log("titleArea:", JSON.stringify(titleArea.value));
		};*/

		// 페이지 로드 시, 저장된 데이터를 텍스트 박스에 복원합니다.
		/*window.onload = function() {
			var savedFont = localStorage.getItem("selectedFont");
			var savedSize = localStorage.getItem("selectedSize");
			var savedColor = localStorage.getItem("selectedColor");
			var savedContent = localStorage.getItem("postContent");
			var savedTitle = localStorage.getItem("postTitle");
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
			if (savedTitle) {
				document.getElementById("postTitle").value = JSON
						.parse(savedTitle);
			}
			console.log("savedFont:", savedFont);
			console.log("savedSize:", savedSize);
			console.log("savedColor:", savedColor);
			console.log("savedContent:", JSON.parse(savedContent));
			console.log("savedTitle:", JSON.parse(savedTitle));
		};*/

		// 확인 버튼 클릭 이벤트 처리
		document
				.getElementById("btnConfirm")
				.addEventListener(
						"click",
						function() {
							var textArea = document
									.getElementById("postContent");
							var titleArea = document
									.getElementById("postTitle");
							var postContent = textArea.value;
							var postTitle = titleArea.value;
							var notice = document.getElementById("noticeRadio").checked;
							var Schedule = document.getElementById("ScheduleRadio").checked;
							var confirmed = confirm("확인 버튼을 누르면 게시글을 저장합니다. 계속하시겠습니까?");

							if (confirmed) {
								// AJAX 요청을 보냅니다.
								$
										.ajax({
											url : "PostCreation.jsp",
											method : "POST",
											data : {
												postContent : postContent,
												postTitle : postTitle,
												notice : notice,
												Schedule : Schedule,
												btnConfirm : "true"
											},
											success : function(response) {
												// 요청이 성공적으로 처리되었을 때 실행되는 코드
												console
														.log("요청이 성공적으로 처리되었습니다.");
												console
														.log("서버 응답: ",
																response); // 브라우저 콘솔에 서버 응답 기록
												// 폰트, 사이즈, 색상 선택을 초기화하고, 게시글 내용을 지웁니다.
												/*localStorage.setItem(
														"selectedFont", "Font");
												localStorage.setItem(
														"selectedSize", "Size");
												localStorage.setItem(
														"selectedColor",
														"Color");
												localStorage.setItem(
														"postContent", "");
												localStorage.setItem(
														"postTitle", "");
												$("#fontSelect").val("Font");
												$("#sizeSelect").val("Size");
												$("#colorSelect").val("Color");
												document
														.getElementById("postContent").value = "";
												document
														.getElementById("postTitle").value = "";*/
											},
											error : function(xhr, status, error) {
												// 요청이 실패하거나 에러가 발생했을 때 실행되는 코드
												console.error("요청이 실패하였습니다.");
												console.error(xhr, status,
														error);
											}
										});
							}
						});

		function insertImage() {
			var textArea = document.getElementById("postContent");
			textArea.value += "\n"; // 이미지 첨부 후 줄 바꿈 처리
		}
	</script>
</body>
</html>