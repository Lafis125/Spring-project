<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 전체 페이지 스타일 */
body {
	font-family: Arial, sans-serif;
	background-color: #f0f0f0;
}

h1 {
	background-color: #333;
	color: #fff;
	padding: 10px;
	margin: 0;
}

.container {
	max-width: 800px;
	margin-bottom: 30px;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 5px;
	padding: 20px
}

form {
	margin: 20px 0;
}

label {
	display: block;
	font-weight: bold;
	margin-bottom: 10px;
}

input[type="text"], textarea {
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 3px;
	font-size: 16px;
	resize: none; /* 크기 조절 비활성화 */
}

input[type="file"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 3px;
	font-size: 16px;
}

h2 {
	margin-top: 20px;
}

.option {
	margin-bottom: 20px;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 3px;
}

input[type="button"] {
	background-color: #333;
	color: #fff;
	padding: 10px 20px;
	border: none;
	cursor: pointer;
	border-radius: 3px;
	font-size: 16px;
}

input[type="submit"] {
	background-color: #007bff;
	color: #fff;
	padding: 10px 20px;
	border: none;
	cursor: pointer;
	border-radius: 3px;
	font-size: 16px;
}

input[type="button"]:hover, input[type="submit"]:hover {
	background-color: #0056b3;
}
/* Content 영역 스타일 */
#item_content {
	max-height: 200px; /* Content 영역의 최대 높이 지정 */
	overflow-y: auto; /* 수직 스크롤바 표시 */
}
/* 셀렉트 박스 커스텀 스타일 */
.custom-select {
	display: inline-block;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color: #fff;
	font-size: 16px;
	color: #333;
	width: 100%;
	max-width: 300px; /* 필요한 경우 최대 너비 지정 */
	cursor: pointer;
}

.custom-select:focus {
	outline: none; /* 포커스 시 테두리 제거 */
}

/* 셀렉트 박스 화살표 스타일 */
.custom-select::after {
	content: "\f107"; /* 화살표 아이콘 (FontAwesome 사용) */
	font-family: FontAwesome;
	position: absolute;
	top: 50%;
	right: 10px;
	transform: translateY(-50%);
	pointer-events: none;
}
</style>
<script>
	// 옵션을 동적으로 추가하는 JavaScript 함수
	function addOption() {
		var optionContainer = document.getElementById("optionContainer");
		var optionIndex = optionContainer.children.length; // 현재 옵션 개수

		// 옵션 요소 생성
		var optionDiv = document.createElement("div");
		optionDiv.className = "option";

		var optionNameLabel = document.createElement("label");
		optionNameLabel.innerText = "옵션명:";
		var optionNameInput = document.createElement("input");
		optionNameInput.type = "text";
		optionNameInput.name = "option_names"; // 각각의 옵션에 고유한 이름 부여
		optionNameInput.required = true;

		var optionPriceLabel = document.createElement("label");
		optionPriceLabel.innerText = "옵션 가격:";
		var optionPriceInput = document.createElement("input");
		optionPriceInput.type = "text";
		optionPriceInput.name = "option_prices"; // 각각의 옵션에 고유한 이름 부여
		optionPriceInput.required = true;

		var optionInfoLabel = document.createElement("label");
		optionInfoLabel.innerText = "옵션 정보:";
		var optionInfoInput = document.createElement("input");
		optionInfoInput.type = "text";
		optionInfoInput.name = "option_infos"; // 각각의 옵션에 고유한 이름 부여
		optionInfoInput.required = true;

		// 생성한 요소를 옵션 컨테이너에 추가
		optionDiv.appendChild(optionNameLabel);
		optionDiv.appendChild(optionNameInput);
		optionDiv.appendChild(optionPriceLabel);
		optionDiv.appendChild(optionPriceInput);
		optionDiv.appendChild(optionInfoLabel);
		optionDiv.appendChild(optionInfoInput);

		optionContainer.appendChild(optionDiv);
	}
</script>
</head>
<body>
	<h1>상품 및 옵션 등록</h1>

	<div>
		<form action="write.do" method="post" enctype="multipart/form-data">
			<input name="perPageNum" value="${param.perPageNum}" type="hidden">
			<!-- 상품 정보 입력 -->
			<h2>상품 정보</h2>
			<label for="item_title">상품명:</label> <input type="text"
				id="item_title" name="item_title" required><br> <label
				for="item_thum">썸네일 이미지:</label> <input type="file" id="item_thum"
				name="thum_File" required><br> <label for="item_img">상세
				이미지:</label> <input type="file" id="item_img" name="img_File" required><br>

			<label for="item_content">상품 설명:</label>
			<textarea id="item_content" name="item_content" rows="6" required></textarea>
			<br> <label for="item_price">상품 가격:</label> <input type="text"
				id="item_price" name="item_price" required><br> <label
				for="category_no">카테고리 선택:</label> <select id="category_no"
				name="category_no" required class="custom-select">
				<option value="">카테고리를 선택하세요</option>
				<c:forEach items="${cateList}" var="vo">
					<option value="${vo.category_no}">${vo.category_name}</option>
				</c:forEach>
			</select>

			<!-- 옵션 정보 입력 -->
			<h2>옵션 정보</h2>

			<div id="optionContainer"></div>
			<input type="button" value="+ 옵션 추가" onclick="addOption()">

			<!-- 등록 버튼 -->
			<input type="submit" value="등록">
		</form>
	</div>

	</main>
</body>
</html>