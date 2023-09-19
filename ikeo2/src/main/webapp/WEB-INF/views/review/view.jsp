<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 보기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script src="/resources/js/jquery-3.6.4.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<style type="text/css">
@import
	url(//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);

#deleteDiv {
	display: none;
}

#data>.row>div {
	padding: 10px 20px;
}

#data>.row {
	border-bottom: 1px dotted #aaa;
}

#imageListDiv:hover {
	cursor: pointer;
}

#changeImageDiv {
	display: none;
}

/* 작은 이미지의 div의 크기가 정해지면 이미지가 넘치면 안보이게 처리한다. */
#imageListDiv .imgDiv {
	overflow: hidden;
}

.rate {
	display: inline-block;
	border: 0;
	margin-right: 15px;
}

.rate>input {
	display: none;
}

.rate>label {
	float: right;
	color: #ddd;
}

.rate>label:before {
	display: inline-block;
	font-size: 1rem;
	padding: 0.3rem 0.2rem;
	margin: 0;
	cursor: pointer;
	font-family: FontAwesome;
	content: "\f005 ";
}

.rate .half:before {
	content: "\f089 ";
	position: absolute;
	padding-right: 0;
}

#stars {
	pointer-events: none; /* hover를 비활성화합니다 */
}

.rate input:checked ~ label, .rate label:hover, .rate label:hover ~
	label {
	color: #f73c32 !important;
}

.rate input:checked+.rate label:hover, .rate input input:checked ~ label:hover,
	.rate input:checked ~ .rate label:hover ~ label, .rate label:hover ~
	input:checked ~ label {
	color: #f73c32 !important;
}

/* Define color classes for different ratings */
.rate input:checked[value="5"] ~ label, .rate input:checked[value="5"] 
	 ~ label ~ label, .rate input:checked[value="4"] ~ label, .rate input:checked[value="4"] 
	 ~ label ~ label, .rate input:checked[value="3"] ~ label, .rate input:checked[value="3"] 
	 ~ label ~ label, .rate input:checked[value="2"] ~ label, .rate input:checked[value="2"] 
	 ~ label ~ label, .rate input:checked[value="1"] ~ label, .rate input:checked[value="1"] 
	 ~ label ~ label {
	color: #f7d032 !important;
}
</style>

<script type="text/javascript">
	// 파라메터로 넘어가는 showImage 변수는 img 태그이다.
	function showImage(showImage){
		let alt = showImage.attr("alt");
		let src = showImage.attr("src");
		$("#bigImage").attr("alt", alt).attr("src", src);
		// 작은 이미지 fno -> 큰 이미지의 fno
		$("#bigImage").data("fno", showImage.data("fno"));
		// download를 위해서 a href에도 넣준다.
		$("#imageDownload").attr("href", src);
		$("#imageListDiv").find("img").css("opacity", 1);
		showImage.css("opacity", 0.5);

		// 이미지 바꾸기 폼 사라지게 한다.
		$("#changeImageDiv").slideUp();

		// 주이미지인 경우에는 삭제 버튼은 없앤다. -> 내가 작성한 이미지에서만 동작이 된다.
		if(showImage.data("pr") == 1) $("#deleteImageBtn").hide();
		else $("#deleteImageBtn").show();
		
	}
	
	$(function(){

		// 작은 이미지 비율 조정
		resize();
		
		// 큰이미지에 메인 이미지를 보이게 한다.
		showImage($("#imageListDiv").find("img:first"));
		// 이미지 삭제 버튼은 안보이게 한다.
		$("#deleteImageBtn").hide();

		// 이벤트 처리
		
		// 브라우저의 창의 사이즈가 조정이 되면 이미지 높이도 다시 계산되서 표시되어야한다.
		$(window).resize(function(){
			// 이미지의 표시 사이즈 지정 처리
			resize();
		});
		
		$("#deleteBtn").click(function(){
			if(!confirm("정말 삭제하시겠습니까?")) return false;
		});

		// 작은 이미지 div를 클릭하면 큰 이미지에 보여야 한다.
		$("#imageListDiv > div").click(function(){
			showImage($(this).find("img"));
		});

		// 이미지 변경
		$("#changeImageBtn").click(function(){
			let fno = $("#bigImage").data("fno");
			// alert("이미지 변경. fno = " + fno);
			$("#changeFno").val(fno);
			$("#deleteFileName").val($("#bigImage").attr("src"));
			$("#changeImageDiv").slideToggle(); // 수정 div는 사라지게 한다.
			$("#changeImage").val(""); // 선택한 파일은 없앤다.
		});

		// 이미지 삭제
		$("#deleteImageBtn").click(function(){
			// alert("이미지 삭제 버튼");
			if(confirm("이미지를 정말 삭제하시겠습니까?")){
				// alert("이미지 삭제 처리");
				let fno = $("#bigImage").data("fno");
				let deleteFile = $("#bigImage").attr("src");
				// alert("fno = " + fno + ", deleteFile = " + deleteFile);
				location = "deleteImage.do?fno=" + fno
					+ "&deleteFile=" + deleteFile
					// encodeURI : 한글등 encode한다. 단, 특수문자(= , & 등)는 제외한다.
					// encodeURIComponent : 한글, 특수문자(= , & 등) 등을 encode한다.
					+ "&query=" + encodeURIComponent("<%=request.getQueryString()%>
	");
								;
							}
						});
	});

	// 이미지의 높이를 처리하는 함수.
	function resize() {
		// 이미지의 너비를 구해보자.
		// select "a b" --> a안에 있는 b 객체를 선택. :first - 처음 것 --> .first()
		let width = $("#imageListDiv .imgDiv:first").width();
		// alert(width);
		let height = width / 3 * 2.4;
		$("#imageListDiv .imgDiv").height(height + "px");
	}
</script>
</head>
<body>
	<div class="container">
		<h2>리뷰 글보기</h2>
		<div id="data">
			<div class="row">
				<div class="col-sm-3">번호</div>
				<div class="col-sm-9">${vo.reNo }</div>
			</div>
			<div class="row">
				<div class="col-sm-3">제목</div>
				<div class="col-sm-9">${vo.title }</div>
			</div>
			<!-- 큰 이미지 표시 -->
			<div class="row">
				<div class="col-sm-3">리뷰 이미지</div>
				<div class="col-sm-12">
					<img class="img-thumbnail" id="bigImage" src="${vo.fileName }">
					<div>
						<div class="btn-group">

							<a type="button" class="btn btn-success btn-sm" download
								id="imageDownload">다운로드</a>
						</div>
					</div>
					<div id="changeImageDiv">
						<form action="changeImage.do" method="post"
							enctype="multipart/form-data">
							
						</form>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-sm-3">내용</div>
				<div class="col-sm-9">${vo.content }</div>
			</div>
			<div class="row">
				<div class="col-sm-3">아이디</div>
				<div class="col-sm-9">${vo.id }</div>
			</div>
			<div class="row">
				<div class="stars">
					<div class="col-sm-3">별점</div>
					<fieldset class="rate" id="stars">
						<c:forEach begin="1" end="5" var="rating" varStatus="vs">
							<input type="radio" id="rating${6-vs.current }" name="stars"
								value="${6-vs.current }"
								<c:if test="${vo.stars eq 6-vs.current }">checked</c:if>
								readonly disabled>
							<label for="rating${6-vs.current }" title="${6-vs.current }점"></label>
						</c:forEach>
					</fieldset>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">작성일</div>
				<div class="col-sm-9">
					<fmt:formatDate value="${vo.reviewDate }" pattern="yyyy-MM-dd" />
				</div>
			</div>
		</div>
		<div style="margin-top: 15px;">
			<c:if test="${vo.id == login.id || login.grade_no == 9}">
				<a
					href="update.do?no=${vo.reNo }"
					class="btn btn-default">수정</a>
				<a href="delete.do?reNo=${vo.reNo }&itemNo=${vo.item_No}"
					class="btn btn-default" id="deleteBtn">삭제</a>
			</c:if>
			<a
				href="/product/view.do?no=${vo.item_No}"
				class="btn btn-default">리스트</a>
		</div>
		<!-- 댓글 인클루드 -->
		 <%@include file="../reviewreply/list.jsp"%>
	</div>
</body>
</html>