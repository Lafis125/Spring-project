<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>상품 정보 업데이트</title>
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

.imgchange-btn {
	margin-bottom: 10px;
}
</style>
<script>
	// 옵션을 동적으로 추가하는 JavaScript 함수
	function addOption() {
		var optionContainer = document.getElementById("optionContainer");

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
	function thumUpload(thumId) {
		// Text 필드와 Hidden 필드를 가져옵니다.
		var optionDiv = document.createElement("div");
		var textField = document.getElementById(thumId);

		console.log(textField);
		// 새로운 File 필드를 생성합니다.
		var fileField = document.createElement('input');
		fileField.type = 'file';
		fileField.id = thumId;
		fileField.name = 'thum_File';

		console.log(fileField);
		// File 필드로 교체합니다.
		textField.parentNode.replaceChild(fileField, textField);
	}
	function imgUpload(imgId) {
		// Text 필드와 Hidden 필드를 가져옵니다.
		var optionDiv = document.createElement("div");
		var textField = document.getElementById(imgId);

		console.log(textField);
		// 새로운 File 필드를 생성합니다.
		var fileField = document.createElement('input');
		fileField.type = 'file';
		fileField.id = imgId;
		fileField.name = 'img_File';

		console.log(fileField);
		// File 필드로 교체합니다.
		textField.parentNode.replaceChild(fileField, textField);
	}
</script>
</head>
<body>
	<h1>상품 정보 업데이트</h1>
	<div>
		<form action="update.do" method="post" enctype="multipart/form-data">

			<!-- 상품 정보 입력 -->
			<h2>상품 정보</h2>
			<label for="item_no">상품 번호:</label> <input type="text" id="item_no"
				name="item_no" value="${vo.item_no }" readonly="readonly"><br>

			<label for="item_title">상품명:</label> <input type="text"
				id="item_title" name="item_title" value="${vo.item_title }" required><br>

			<label for="item_thum">썸네일 이미지:</label> <input type="text"
				id="item_thum" name="item_thum" value="${vo.item_thum }" required>
			<button type="button" class="imgchange-btn"
				onclick="thumUpload('item_thum')">썸네일 변경</button>

			<label for="item_img">상세 이미지:</label> <input type="text"
				id="item_img" name="item_img" value="${vo.item_img }" required>
			<button type="button" class="imgchange-btn"
				onclick="imgUpload('item_img')">상세이미지 변경</button>

			<label for="item_content">상품 설명:</label>
			<textarea id="item_content" name="item_content" rows="6" required>${vo.item_content }</textarea>
			<br> <label for="item_price">상품 가격:</label> <input type="text"
				id="item_price" name="item_price " value="${vo.item_price }"
				required><br> <label for="item_status">제품 상태
				선택:</label> <select id="item_status" name="item_status" required
				class="custom-select">
				<option value="${vo.item_status }">기본값 : ${vo.item_status }</option>
				<option value="재고있음">재고있음</option>
				<option value="재고없음">재고없음</option>
			</select>


			<!-- 옵션 정보 입력 -->
			<h2>기본 옵션 정보</h2>
			<div>
				<c:forEach items="${list }" var="vo" varStatus="loop">
					<h4>
						<label for="item_no">옵션 번호</label> <input type="text" id="item_no"
							name="option_nos" value="${vo.option_no }" readonly="readonly">
					</h4>
					<label for="item_name">옵션명:</label>
					<input type="text" id="item_name" name="option_names"
						value="${vo.option_name }" required>
					<label for="item_price">옵션 가격:</label>
					<input type="text" id="item_price" name="option_prices"
						value="${vo.option_price }" required>
					<label for="item_info">옵션 정보:</label>
					<input type="text" id="item_info" name="option_infos"
						value="${vo.option_info }" required>
				</c:forEach>
			</div>
			<h2>옵션 추가</h2>
			<div id="optionContainer"></div>
			<input type="button" value="+ 옵션 추가" onclick="addOption()">
			<!-- 등록 버튼 -->
			<input type="submit" value="등록">
		</form>
	</div>
</body>
</html>