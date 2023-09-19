<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<script type="text/javascript">
$(function(){

	// 이미지의 표시 사이즈 지정 처리
	resize();

	// 브라우저의 창의 사이즈가 조정이 되면 이미지 높이도 다시 계산되서 표시되어야한다.
	$(window).resize(function(){
		// 이미지의 표시 사이즈 지정 처리
		resize();
	});
	
	// 검색(key, word-input.value) & perPageNum 데이터 세팅 -- select tag의 데이터 세팅
	$("#key").val("${(empty pageObject.key)?"t":pageObject.key}");
	$("#perPageNum").val("${pageObject.perPageNum}");
	
	// 이벤트 처리
	$(".dataRow").click(function(){
		// click한 태그 안에 data-no="1" 세팅해 둔다.
		let no = $(this).data("no");
		location = "/product/view.do?no=" + no 
		+ "&${pageObject.pageQuery}";
	});

	$("#perPageNum").change(function(){
		// alert("페이지당 데이터의 개수를 변경했습니다.");
		location = "list.do?page=1&perPageNum=" + $("#perPageNum").val()
			+ "&key=${pageObject.key}&word=${pageObject.word}";
	});

	$(".dataRow").mouseover(function(){
		// 선택되어진 이미지 태그의 불투명도 조정 - 마우스가 올라가면 투명하게
		$(this).find("img").css("opacity", 0.5);
	}).mouseout(function(){
		// 선택되어진 이미지 태그의 불투명도 조정 - 마우스가 빠져나가면 불투명하게
		$(this).find("img").css("opacity", 1);
	});
	
});

// 이미지의 높이를 처리하는 함수.
function resize(){
	// 이미지의 너비를 구해보자.
	// select "a b" --> a안에 있는 b 객체를 선택. :first - 처음 것 --> .first()
	let width = $(".thumbnail .imgDiv:first").width();
	// alert(width);
	$(".thumbnail .imgDiv").height();
}
</script>
<style type="text/css">
.css-mainitem-contain {
	display: flex;
	flex-direction: column;
}

.css-mainitem-row {
	display: flex;
}

.css-mainitem-title {
	margin-left: 15px;
	margin-bottom: 20px;
}

.css-mainitem-linck {
	display: flex;
}

.plus-link {
	padding-top: 20px;
	margin-left: auto;
	margin-right: 20px;
}

.css-h3text {
	margin-top: 0px;
	margin-left: 5px;
}

</style>
</head>
<body>
	<div style="margin-bottom: 30px; text-align: center;">
		<img class="animate__animated animate__bounce animate__bounceInDown" alt="#" src="/resources/img/log/logo.png">
	</div>
	<div class="css-mainitem-contain">
		<div class="css-mainitem-linck">
			<h2 class="animate__animated animate__bounce animate__bounceInLeft"># 모아봐요 👀 Weekly best</h2>
			<h4 class="plus-link">
				<a href="/product/list.do?category_no=1&category_name=의자">> 더보기</a>
			</h4>
		</div>
		<div class="css-mainitem-row">
			<c:forEach items="${category01 }" var="vo" varStatus="vs">
				<div class="col-md-3 dataRow" data-no="${vo.item_no }">
					<div  class="thumbnail animate__animated animate__bounce animate__zoomInLeft" style="margin-bottom: 0px;">
						<div class="imgDiv" style="width: 100%; height: 100%;">
							<img src="${vo.item_thum }" style="width: 100%">
						</div>
					</div>
					<h3 class="css-h3text">${vo.item_title }</h3>
				</div>
			</c:forEach>
		</div>
	</div>

	<div>
		<div class="css-mainitem-linck">
			<h2 class="animate__animated animate__bounce animate__bounceInRight"># 10만 조회 돌파 📈 아직 못봤다면?</h2>
			<h4 class="plus-link">
				<a href="/product/list.do?category_no=2&category_name=책상">> 더보기</a>
			</h4>
		</div>
		<div class="css-mainitem-row">
			<c:forEach items="${category02 }" var="vo" varStatus="vs">
				<div class="col-md-3 dataRow" data-no="${vo.item_no }">
					<div class="thumbnail animate__animated animate__bounce animate__zoomInLeft" style="margin-bottom: 0px;">
						<div class="imgDiv" style="width: 100%; height: 100%;">
							<img src="${vo.item_thum }" style="width: 100%">
						</div>
					</div>
					<h3 class="css-h3text">${vo.item_title }</h3>
				</div>
			</c:forEach>
		</div>
	</div>

	<div>
		<div class="css-mainitem-linck">
			<h2 class="animate__animated animate__bounce animate__bounceInLeft"># 이번주 인기 집들이 best 4 👑</h2>
			<h4 class="plus-link">
				<a href="/product/list.do?category_no=3&category_name=침대">> 더보기</a>
			</h4>
		</div>
		<div class="css-mainitem-row">
			<c:forEach items="${category03 }" var="vo" varStatus="vs">
				<div class="col-md-3 dataRow" data-no="${vo.item_no }">
					<div class="thumbnail animate__animated animate__bounce animate__zoomInLeft" style="margin-bottom: 0px;">
						<div class="imgDiv" style="width: 100%; height: 100%;">
							<img src="${vo.item_thum }" style="width: 100%">
						</div>
					</div>
					<h3 class="css-h3text">${vo.item_title }</h3>
				</div>
			</c:forEach>
		</div>
	</div>

	<div>
		<div class="css-mainitem-linck">
			<h2 class="animate__animated animate__bounce animate__bounceInRight"># 주방 분위기 바꿔보세요 ✨</h2>
			<h4 class="plus-link">
				<a href="/product/list.do?category_no=4&category_name=소파">> 더보기</a>
			</h4>
		</div>
		<div class="css-mainitem-row">
			<c:forEach items="${category04 }" var="vo" varStatus="vs">
				<div class="col-md-3 dataRow" data-no="${vo.item_no }">
					<div class="thumbnail animate__animated animate__bounce animate__zoomInLeft" style="margin-bottom: 0px;">
						<div class="imgDiv" style="width: 100%; height: 100%;">
							<img src="${vo.item_thum }" style="width: 100%">
						</div>
					</div>
					<h3 class="css-h3text">${vo.item_title }</h3>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>