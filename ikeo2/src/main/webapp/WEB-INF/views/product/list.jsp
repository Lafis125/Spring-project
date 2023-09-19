<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			location = "view.do?no=" + no 
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
		let width = $(".dataRow .imgDiv:first").width();
		// alert(width);
		let height = width / 3 * 2.4;
		$(".dataRow .imgDiv").height(height + "px");
	}
  </script>
</head>
<body>
	<div class="css-product">
		<section class="css-product-side">
			<h2 class="animate__animated animate__bounce animate__fadeInLeft">
				<a href="/product/list.do">가구</a>
			</h2>
			<ul class="categoryList">
				<c:forEach items="${category }" var="vo">
					<li>
						<div>
							<a
								href="list.do?category_no=${vo.category_no }&category_name=${vo.category_name}">${vo.category_name}</a>
						</div>
					</li>
				</c:forEach>
			</ul>
		</section>
		<div class="css-main-productList container">
			<div class="css-product-text">
				<h3 class="animate__animated animate__bounce animate__fadeInDownBig">
					<span> #가구 > ${vo.category_name } </span>
				</h3>
				<div style="margin-left: auto; margin-top: 17px;">
					<div class="row">
						<div id="searchDiv">
							<form action="list.do" class="form-inline">
								<input name="page" value="1" type="hidden" />
								<div class="form-group">
									<select class="form-control" id="key" name="key">
										<option value="tc">전체</option>
										<option value="t">상품 이름</option>
										<option value="c">상품 내용</option>
									</select>
								</div>
								<div class="input-group">
									<input type="text" class="form-control" placeholder="Search"
										name="word" value="">
									<div class="input-group-btn">
										<button class="btn btn-default" type="submit">
											<i class="glyphicon glyphicon-search"></i>
										</button>
									</div>
								</div>
								<div class="input-group pull-right" style="margin-left: 465px;">
									<span class="input-group-addon">Rows/Page</span> <select
										class="form-control" id="perPageNum" name="perPageNum">
										<option>8</option>
										<option>12</option>
										<option>16</option>
										<option>20</option>
									</select>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="productList">
				<div class="row">
					<c:forEach items="${list }" var="vo" varStatus="vs">
						<c:if test="vs.index > 0 && vs.index % 4 == 0">
							<!-- 4개의 데이터가 찍히면 줄바꿈하는 처리 -> div를 마치고 다시 시작 - class=row -->
							<c:out value="</div>" />
							<c:out value="<div class='row'>" />
						</c:if>
						<div class="col-md-3 dataRow" data-no="${vo.item_no }">
							<div class="thumbnail">
								<div class="imgDiv" style="width: 100%">
									<img src="${vo.item_thum }" style="width: 100%; height: 200px;">
								</div>
								<div class="caption">
									<div class="product-title">${vo.item_title }</div>
									<div style="display: flex;">
										<div style="margin-top: 5px;">
											<svg class="icon" aria-label="무료배송" width="47" height="20"
												viewBox="0 0 47 20" preserveAspectRatio="xMidYMid meet">
										<g fill="none" fill-rule="evenodd">
										<rect width="47" height="20" fill="#000" fill-opacity=".07"
													fill-rule="nonzero" rx="4"></rect>
										<path fill="#757575"
													d="M12.73 5.38v3.96h-6.6V5.38h6.6zm-2.68 9.43H8.76v-3.25H5v-1.03h8.86v1.03h-3.81v3.25zm1.4-6.49V6.41H7.43v1.91h4.04zm11.08 2.7h-1.42v1.54h2.26v1.02h-8.86v-1.02h2.24v-1.53h-1.1V7.78h5.32V6.65H15.6V5.63h6.66V8.8h-5.33v1.18h5.61v1.04zm-4.53 0v1.54h1.87v-1.53H18zm14.37 3.78h-1.23V9.86h-.8v4.49h-1.2V5.18h1.2v3.66h.8V5h1.23v9.8zm-4.2-2.54h-3.9V6.01h1.27v2.26h1.36V6h1.28v6.26zm-1.27-1.01v-2h-1.36v2h1.36zm14.49 1.71c0 1.13-1.25 1.82-3.41 1.82s-3.42-.7-3.42-1.82 1.25-1.82 3.4-1.82c2.18 0 3.43.7 3.43 1.82zm-3.41-6.05c-.5 1.13-2.1 1.9-3.51 2.1l-.54-1c1.64-.17 3.39-1.06 3.39-2.54V5.2h1.33v.28c0 1.48 1.99 2.47 3.4 2.53l-.55 1.01c-1.31-.18-3.03-.97-3.52-2.1zm4.42 3.78h-8.86V9.66h3.79V8.4h1.29v1.26h3.78v1.03zm-2.33 2.27c0-.5-.83-.8-2.1-.8s-2.08.3-2.08.8c0 .51.81.8 2.08.8s2.1-.29 2.1-.8z"></path></g></svg>
										</div>
										<div class="product-price">${vo.item_price }</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>

				<div class="css-pagetagbtn">
					<div style="margin-right: auto; margin-left: auto;">
						<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" query="&category_no=${param.category_no }&category_name=${param.category_name}"></pageNav:pageNav>
					</div>
					<div style="margin-top: 20px;">
						<a href="write.do?perPageNum=${pageObject.perPageNum }"
							id="writeA" class="btn btn-default">등록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>