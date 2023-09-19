<%@page import="java.time.format.TextStyle"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	LocalDate currentDate = LocalDate.now();

// 날짜를 3일 더하기
LocalDate newDate = currentDate.plusDays(3);

// 요일 텍스트 가져오기
String dayOfWeek = newDate.getDayOfWeek().getDisplayName(TextStyle.FULL, Locale.KOREAN);

// 날짜 포맷 지정
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd E", Locale.KOREAN);

// 날짜와 요일 출력
String formattedDate = newDate.format(formatter);
%>

<style type="text/css">
#product-img:focus, #product-review:focus, #product-coments:focus,
	#product-delivery:focus {
	outline: none;
}
</style>

<script type="text/javascript">
	$("#deleteBtn").click(function() {
		if (!confirm("정말 삭제하시겠습니까?"))
			return false;
	});
	var totalPrice = 0;
	// 선택한 옵션 item_no를 저장할 배열 초기화
	var selectedOptionItemNos = [];

	var itemCounts = {};

	// 각 옵션 <li> 요소를 숨김
	$(document)
			.ready(
					function() {

						// 옵션 선택 드롭다운 변경 시
						$("#optionsDropdown")
								.change(
										function() {
											var selectedOptionItemNo = $(this)
													.val(); // 선택한 옵션의 item_no 값
											var optionPrice = parseInt($(
													"#optionsDropdown option:selected")
													.data("price"));

											// 이미 선택한 옵션이 있는지 확인
											var index = selectedOptionItemNos
													.indexOf(selectedOptionItemNo);

											if (itemCounts[selectedOptionItemNo] != 1) {
												itemCounts[selectedOptionItemNo] = 1;
												$(
														".option-li[data-item-no='"
																+ selectedOptionItemNo
																+ "']")
														.find(".countbtn span")
														.text(
																itemCounts[selectedOptionItemNo]);
											}
											// 이미 선택한 옵션인 경우 중복 선택 방지
											if (index === -1) {
												// 배열에 선택한 옵션 item_no 추가
												selectedOptionItemNos
														.push(selectedOptionItemNo);

												// 배열에 선택한 옵션 가격 추가

												// 선택한 옵션에 해당하는 <li> 요소 보이기

												updateTotalPrice(optionPrice);
											}
											$(
													".option-li[data-item-no='"
															+ selectedOptionItemNo
															+ "']").show();

											// 선택한 옵션 배열 초기화
											$("#optionsDropdown")[0].selectedIndex = 0;
										});
						$(".option-li").hide();
						$(document)
								.on(
										"click",
										".option-li .optxbtn",
										function() {
											var optionItemNoToRemove = $(this)
													.closest(".option-li")
													.data("item-no");
											var optionPrice = -parseInt($(this)
													.closest(".option-li")
													.data("price"));
											var optionCount = itemCounts[optionItemNoToRemove];

											// 배열에서 선택한 옵션 item_no 제거
											var indexToRemove = selectedOptionItemNos
													.indexOf(optionItemNoToRemove
															.toString());
											if (indexToRemove != -1) {
												selectedOptionItemNos.splice(
														indexToRemove, 1);
												// 해당 <li> 요소 숨기기
												$(this).closest(".option-li")
														.hide();

												// 선택한 옵션 배열 초기화
												$("#optionsDropdown")[0].selectedIndex = 0;
												updateTotalPrice(optionPrice
														* optionCount);
											}

										});
						$(document).on(
								"click",
								".option-li .icon-plus",
								function() {
									var optionItemNo = $(this).closest(
											".option-li").data("item-no");
									var optionPrice = parseInt($(this).closest(
											".option-li").data("price"));
									itemCounts[optionItemNo]++;
									if (itemCounts[optionItemNo] > 9999) {
										itemCounts[optionItemNo] = 9999;
										alert("1~9999까지 만 입력이 가능합니다.");
									} else {
										updateTotalPrice(optionPrice);
									}

									// 각각의 <li> 요소에서 해당 옵션의 itemCount 업데이트
									$(this).closest(".option-li").find(
											".countbtn span").text(
											itemCounts[optionItemNo]);

								});

						$(document).on(
								"click",
								".option-li .icon-minus",
								function() {
									var optionItemNo = $(this).closest(
											".option-li").data("item-no");
									var optionPrice = -parseInt($(this)
											.closest(".option-li")
											.data("price"));
									itemCounts[optionItemNo]--;

									if (itemCounts[optionItemNo] < 1) {
										itemCounts[optionItemNo] = 1;
										alert("1~9999까지 만 입력이 가능합니다.");
									} else {
										updateTotalPrice(optionPrice);
									}
									// 각각의 <li> 요소에서 해당 옵션의 itemCount 업데이트
									$(this).closest(".option-li").find(
											".countbtn span").text(
											itemCounts[optionItemNo]);

								});

					});
	function updateTotalPrice(price) {
		// 선택한 옵션들의 가격을 합산
		totalPrice = totalPrice + price;

		// 총 가격을 "totalPrice" 요소에 업데이트
		$("#totalPrice span").text(totalPrice.toLocaleString('ko-KR'));
	}
</script>

<script type="text/javascript">
	$(document).on("click", "#cartbtn", function() {
		var option_nos = []; // data-no 값을 담을 배열 초기화
		var counts = [];

		var itemNo = $("#items-no").data("item");
		// 모든 li 요소를 순회하면서 data-no 값을 배열에 추가
		$(".option-li:not([style*='display: none'])").each(function() {
			var optionNo = $(this).data("item-no");
			var count = $(this).find(".countbtn span").text();
			option_nos.push(optionNo);
			counts.push(count);
		});

		$.ajax({
			url : "/cartAjax/addCart.action",
			method : "POST",
			traditional : true,
			data : {
				option_nos : option_nos,
				cnts : counts,
				itemNo : itemNo
			},
			dataType : "json",
			success : function(result) {
				if (result == 1) {
					alert("장바구니에 추가되었습니다.");
					location.reload();
				} else if (result == 0) {
					alert("로그인 후에 이용해주세요");
				}
			},
			error : function() {
				// AJAX 요청이 실패한 경우 실행할 코드
				alert("옵션을 선택해주세요");
			}
		});

	})
</script>
<script type="text/javascript">
	$(function() {
		$(".v-reviewBtn").click(function() {
			let itemNo = $("#items-no").data("item");
			alert(itemNo);
			location = "/review/write.do?itemNo=" + itemNo;

		});

	});
	$(function() {
		$(".v-qnaBtn").click(function() {
			let itemNo = $("#items-no").data("item");
			alert(itemNo);
			location = "/qna/write.do?item_no=" + itemNo;
		});

	});
</script>


<style type="text/css">
.production-selling-table tbody tr th {
	width: 18ch;
	color: #757575;
}

.production-selling-table tbody tr td {
	color: #424242;
	white-space: pre-line;
	word-break: break-all;
}

.production-selling-table tbody tr th {
	padding: 12px 6px;
	text-align: left;
	line-height: 1.38;
}

.production-selling-table tbody tr td {
	padding: 12px 6px 12px 30px;
	text-align: left;
	line-height: 1.38;
}

.v-review-css-01 {
	padding: 24px 0;
	display: flex;
	height: 148px;
	justify-content: center;
}

@import
	url(//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);

.custom-table {
	width: 100%;
	border-collapse: collapse;
	border-radius: 10px; /* 둥근 경계 적용 */
}

.custom-table th, .custom-table td {
	padding: 12px;
	text-align: left;
	vertical-align: top;
}

.title-col {
	width: 40%;
}

.custom-table th {
	border-top: solid #ededed;
	border-bottom: solid #ededed;
	background-color: white;
	color: black;
	background-color: white;
}

.custom-table tr:hover {
	background-color: #f5f5f5;
}

.review-button {
	text-align: right;
	margin-bottom: 60px;
}

.review-button .v-reviewBtn {
	background-color: #87CEEB; /* 하늘색 계열 배경색 */
	color: white;
	border: none;
	padding: 10px 20px;
	font-size: 18px;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.2s;
	margin-top: 30px;
}

.review-button .v-reviewBtn:hover {
	background-color: #5F9EA0;
}

.qna-button {
	text-align: right;
	margin-bottom: 60px;
}

.qna-button .v-qnaBtn {
	background-color: #dff0d8; /* 하늘색 계열 배경색 */
	color: #87CEEB;
	border: none;
	padding: 10px 20px;
	font-size: 18px;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.2s;
	margin-top: 30px;
}

.qna-button .v-qnaBtn:hover {
	background-color: #3c763d;
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

.rates>label:before {
	display: inline-block;
	font-size: 2rem;
	padding: 0.3rem 0.2rem;
	margin: 0;
	cursor: pointer;
	font-family: FontAwesome;
	content: "\f005 ";
}

.rates .half:before {
	content: "\f089 ";
	position: absolute;
	padding-right: 0;
	font-size: 2rem;
}

.stars {
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

.rate #rating_Ma_5 input:checked ~ label ~ label, .rate #rating_Ma_4 input:checked 
	 ~ label ~ label, .rate #rating_Ma_3 input:checked ~ label ~ label,
	.rate #rating_Ma_2 input:checked ~ label ~ label, .rate #rating_Ma_1 input:checked 
	 ~ label ~ label {
	/* 원하는 스타일을 여기에 적용하세요 */
	color: #f7d032 !important;
	/* 다른 스타일 속성도 추가하세요 */
}

.rates input:checked ~ label, .rate label:hover, .rate label:hover ~
	label {
	color: #f73c32 !important;
}

.rates input:checked+.rates label:hover, .rates input input:checked ~
	label:hover, .rate input:checked ~ .rate label:hover ~ label, .rate label:hover 
	 ~ input:checked ~ label {
	color: #f73c32 !important;
}

/* Define color classes for different ratings */
.rates input:checked[value="5"] ~ label, .rates input:checked[value="5"] 
	 ~ label ~ label, .rates input:checked[value="4"] ~ label, .rates input:checked[value="4"] 
	 ~ label ~ label, .rates input:checked[value="3"] ~ label, .rates input:checked[value="3"] 
	 ~ label ~ label, .rates input:checked[value="2"] ~ label, .rates input:checked[value="2"] 
	 ~ label ~ label, .rates input:checked[value="1"] ~ label, .rates input:checked[value="1"] 
	 ~ label ~ label {
	color: #87CEEB !important;
}

.rating {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	width: 200px; /* 게이지 전체 너비 조정 */
	margin-top: 5px;
}

.bar {
	width: 100%;
	height: 7px; /* 게이지 높이 조정 */
	background-color: #ddd; /* 게이지의 배경색 설정 */
	border-radius: 15px; /* 둥근 테두리 설정 */
	overflow: hidden; /* 내용이 테두리를 벗어나지 않도록 설정 */
	display: flex;
	align-items: center;
	width: 100%;
	margin-bottom: 14px;
}

.rating-label {
	color: #9e9e9e;
	font-weight: 400;
	margin-right: 10px; /* 별점 글자와 바 사이의 간격 설정 */
	font-size: 12px; /* 글자 크기 설정 */
	margin-bottom: 2px;
}

.bar-fill {
	height: 100%;
	width: 0;
	background-color: #35c5f0; /* 게이지의 채워진 색 설정 (예: 빨간색) */
	transition: width 0.5s ease-in-out; /* 애니메이션 효과 설정 */
}

/* 각 게이지 별로 클래스를 설정하여 게이지 색상 및 너비를 조절할 수 있습니다. */
.user-count {
	color: #9e9e9e;
	font-weight: 400;
	margin-left: 10px;
	font-size: 12px;
	margin-bottom: 2px;
}
</style>
<script type="text/javascript">
	$(function() {
		// 이벤트 처리
		$(".reviewRow").click(function() {
			let no = $(this).find(".reviewno").text();
			location = "/review/view.do?no=" + no;

		});
	});
</script>
<script type="text/javascript">
	$(function() {
		// 이벤트 처리
		$(".qnadataBtn").click(function() {
			let no = $(this).data("no");
			let item_no = $("#items-no").data("item");
			location = "/qna/view.do?no=" + no + "&item_no=" + item_no;
		});
	});
</script>

</head>
<body>

	<c:set var="fiveStarCount" value="0" />
	<c:set var="fourStarCount" value="0" />
	<c:set var="threeStarCount" value="0" />
	<c:set var="twoStarCount" value="0" />
	<c:set var="oneStarCount" value="0" />

	<c:forEach items="${reviewlist}" var="vo">
		<c:choose>
			<c:when test="${vo.stars == 5}">
				<c:set var="fiveStarCount" value="${fiveStarCount + 1}" />
			</c:when>
			<c:when test="${vo.stars == 4}">
				<c:set var="fourStarCount" value="${fourStarCount + 1}" />
			</c:when>
			<c:when test="${vo.stars == 3}">
				<c:set var="threeStarCount" value="${threeStarCount + 1}" />
			</c:when>
			<c:when test="${vo.stars == 2}">
				<c:set var="twoStarCount" value="${twoStarCount + 1}" />
			</c:when>
			<c:when test="${vo.stars == 1}">
				<c:set var="oneStarCount" value="${oneStarCount + 1}" />
			</c:when>
		</c:choose>
	</c:forEach>

	<%-- 리뷰 목록을 저장할 리스트 생성 --%>
	<c:set var="reviewList" value="${reviewlist}" />

	<%-- 리뷰 평점의 합과 리뷰 개수 초기화 --%>
	<c:set var="totalRating" value="0" />
	<c:set var="reviewCount" value="0" />

	<%-- 리뷰 목록을 순회하면서 평점 누적 --%>
	<c:forEach items="${reviewList}" var="vo">
		<c:set var="rating" value="${vo.stars}" />
		<c:if test="${not empty rating}">
			<c:set var="totalRating" value="${totalRating + rating}" />
			<c:set var="reviewCount" value="${reviewCount + 1}" />
		</c:if>
	</c:forEach>

	<%-- 평균 평점 계산 --%>
	<c:set var="averageRating"
		value="${reviewCount > 0 ? totalRating / reviewCount : 0}" />
	<c:choose>
		<c:when test="${averageRating <= 0.49}">
			<c:set var="averageRating" value="0" />
		</c:when>
		<c:when test="${averageRating <= 1.49}">
			<c:set var="averageRating" value="1" />
		</c:when>
		<c:when test="${averageRating <= 2.49}">
			<c:set var="averageRating" value="2" />
		</c:when>
		<c:when test="${averageRating <= 3.49}">
			<c:set var="averageRating" value="3" />
		</c:when>
		<c:when test="${averageRating <= 4.49}">
			<c:set var="averageRating" value="4" />
		</c:when>
		<c:when test="${averageRating <= 5}">
			<c:set var="averageRating" value="5" />
		</c:when>
	</c:choose>
	<div class="productview" style="margin-right: auto; margin-left: auto;">
		<div class="productview-item01">
			<div class="view-thum col-sm-8">
				<img alt="사진정보없음" src="${vo.item_thum }">
			</div>
			<div class="view-buy col-md-6">
				<div class="view-buytitle">
					<div class="view-titlelink-text">
						<input id="items-no" type="hidden" data-item="${vo.item_no }">
						<div>${vo.item_title }</div>

						<div class="view-textlink">
							<svg class="icon" aria-label="공유하기" width="24" height="24"
								viewBox="0 0 24 24" fill="currentColor"
								preserveAspectRatio="xMidYMid meet">
                  <path
									d="M9.64 14.646a4.5 4.5 0 1 1 0-5.292l4.54-2.476a4.5 4.5 0 1 1 .63.795l-4.675 2.55c.235.545.365 1.146.365 1.777s-.13 1.232-.365 1.777l4.675 2.55a4.5 4.5 0 1 1-.63.795l-4.54-2.476zM18 8a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7zM6 15.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7zM18 23a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"></path>
                </svg>
						</div>
					</div>
				</div>
				<div>
					<fieldset class="rate stars">
						<c:forEach begin="1" end="5" var="starConts" varStatus="vs">
							<input type="radio" style="font-size: 1em;"
								id="rating_Ma_${6-vs.current}" name="stars_Ma_${averageRating}"
								value="${6-vs.current}"
								<c:if test="${averageRating eq 6-vs.current }">checked</c:if>>
							<label for="rating_Ma_${6-vs.current}" title="${6-vs.current}점"></label>
						</c:forEach>
					</fieldset>
				</div>
				<div class="view-buyprice">${vo.item_price }원</div>

				<div class="view-buydelivery">
					<div class="view-buydelivery01">
						<span> 배송 </span>
					</div>
					<div class="delivery-column">
						<div class="free-del">
							<b> 무료배송 </b>
						</div>
						<div class="free-del">
							<span> 일반택배 </span>
						</div>
						<div class="delivery-pre">
							<span
								class="production-selling-header__delivery__expectation__header"><svg
									class="delivery-time-icon" width="24" height="24" fill="none"
									preserveAspectRatio="xMidYMid meet">
                    <path fill-rule="evenodd" clip-rule="evenodd"
										d="M13.303 5.04l.394.92L7 8.83V12a.5.5 0 01-1 0V8.17l7.303-3.13z"
										fill="#00B8F0"></path>
                    <path fill-rule="evenodd" clip-rule="evenodd"
										d="M10.197 4.628a.5.5 0 00-.394 0L4.269 7 10 9.456 15.73 7l-2.427-1.04-3.106-1.332zM3.5 14.341V7.758l6 2.572v6.912L3.803 14.8a.5.5 0 01-.303-.46zm7 2.9l1.534-.657a5 5 0 014.466-5.56V7.759l-6 2.572v6.912zm.09 1.05l1.664-.713A5.002 5.002 0 0022 16a5 5 0 00-4.5-4.975V7.659a1.5 1.5 0 00-.91-1.378l-2.893-1.24-3.106-1.332a1.5 1.5 0 00-1.182 0l-6 2.572A1.5 1.5 0 002.5 7.659v6.682c0 .6.358 1.142.91 1.378l6 2.572a1.5 1.5 0 001.18 0zM17 20a4 4 0 100-8 4 4 0 000 8zm.5-6.5a.5.5 0 00-1 0v2H15a.5.5 0 000 1h2a.5.5 0 00.5-.5v-2.5z"
										fill="#3F474D"></path>
                  </svg><span class="del-text"><span class="date"><%=formattedDate%>
								</span>도착 예정 80%</span></span>
						</div>
					</div>
				</div>
				<div class="css-texts">
					<svg width="24" height="24" fill="none"
						preserveAspectRatio="xMidYMid meet">
              <path
							d="M3.972 8.694c0-.26.212-.472.472-.472h12.278a.472.472 0 010 .945H4.444a.472.472 0 01-.472-.473z"
							fill="#35C5F0"></path>
              <path fill-rule="evenodd" clip-rule="evenodd"
							d="M17.51 5.5H6.492a1 1 0 00-.93.632l-.99 2.5A1 1 0 005.498 10h13.004a1 1 0 00.927-1.368l-.99-2.5a1 1 0 00-.93-.632zM3.642 8.263a2.002 2.002 0 001.397 2.684V17.5a2.5 2.5 0 002.5 2.5H16.474a2.5 2.5 0 002.487-2.5v-6.553a2.002 2.002 0 001.398-2.684l-.99-2.5a2 2 0 00-1.86-1.263H6.493a2 2 0 00-1.86 1.263l-.99 2.5zM6.04 17.5V11h11.921v6.5a1.5 1.5 0 01-1.487 1.5v-4a2 2 0 00-2-2h-.97a2 2 0 00-2 2v4H7.54a1.5 1.5 0 01-1.5-1.5zm6.464 1.5h2.97v-4a1 1 0 00-1-1h-.97a1 1 0 00-1 1v1h.847a.5.5 0 110 1h-.847v2zM8 13h1.5v1.5H8V13zm-1 0a1 1 0 011-1h1.5a1 1 0 011 1v1.5a1 1 0 01-1 1H8a1 1 0 01-1-1V13z"
							fill="#3F474D"></path>
            </svg>
					<div>
						<div class="css-158">
							<span>ikeo</span>
						</div>
					</div>
				</div>

				<div>
					<div>
						<select class="form-control options-list" id="optionsDropdown">
							<option selected="" value="" disabled="">옵션</option>
							<c:forEach items="${option }" var="vo" varStatus="optionStatus">
								<c:if test="${optionStatus.index < sumprice.size()}">
									<c:set var="sumpriceItem"
										value="${sumprice[optionStatus.index]}" />

									<fmt:formatNumber var="optionprice" pattern="###,###,###"
										value="${vo.option_price }" />
									<option value="${vo.option_no}" data-price="${sumpriceItem}">${vo.option_name }&nbsp;${vo.option_info}&nbsp;
										추가금 : +${optionprice}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div>
						<ul class="selling-option">
							<c:forEach items="${option}" var="optionItem"
								varStatus="optionStatus">
								<c:if test="${optionStatus.index < sumprice.size()}">
									<c:set var="sumpriceItem"
										value="${sumprice[optionStatus.index]}" />
									<li style="background-color: rgb(247, 249, 250);"
										class="option-li" data-item-no="${optionItem.option_no}"
										data-price="${sumpriceItem}">
										<article class="css-view-select">
											<div class="css-34drow">
												<h2 class="css-yak">${optionItem.option_name}&nbsp;${optionItem.option_info}</h2>
												<button type="button" aria-label="삭제"
													class="css-nr8 optxbtn" style="margin-left: auto;">
													<span class="icon-hamburger-menu-close css-nr8s"></span>
												</button>
											</div>
											<div class="css-1nrst">
												<div class="css-i2qw">
													<span class="icon-minus css-ptm5"></span>
													<button type="button" class="css-d84 countbtn">
														<span>1</span>
													</button>
													<span class="css-ptm5 icon-plus"></span>
												</div>
												<div class="css-sp8w">
													<fmt:formatNumber var="sumpriceItems" pattern="###,###,###"
														value="${sumpriceItem}" />
													<span class="css-1xrj">${sumpriceItems}원</span>
												</div>
											</div>
										</article>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div></div>
				</div>
				<div>
					<p class="css-49">
						<span class="css-7c">주문금액</span><span class="css-q02"
							id="totalPrice"><span><fmt:formatNumber
									pattern="###,###,###" value="${totalPrice}" /></span>원</span>
					</p>
				</div>
				<div class="buy-bottn">
					<button
						class="buy-btn buy-button buy-button--color-blue-inverted buy-button--size-55"
						type="button" id="cartbtn">장바구니</button>
					<button
						class="buy-btn buy-button buy-button--color-blue buy-button--size-55 "
						type="button">바로구매</button>
				</div>
			</div>
		</div>
	</div>
	</main>
	<div class="view-content">
		<div class="view-content-line" style="z-index: 30;">
			<nav class="view-nav">
				<ol class="view-row">
					<li id="view-contents"><a>상세 내용</a></li>
					<li id="view-reviews"><a>리뷰</a></li>
					<li id="view-coments"><a>문의</a></li>
					<li id="view-deliverys"><a>배송/환불</a></li>
				</ol>
			</nav>
		</div>
	</div>
	<section class="container secti">
		<div>
			<div id="product-img" class="product-view-info">상품정보</div>
			<div>
				<img alt="사진정보없음" src="${vo.item_img }" style="width: 80%;">
			</div>
			<div>
				<h3>
					<span>${vo.item_content }</span>
				</h3>
			</div>
		</div>
		<div style="width: 80%;">
			<div class="v-reivew-text" id="product-review">
				<div class="product-view-info">
					리뷰<span style="color: #35c5f0; margin-left: 4px;">${reviewlist.size()}</span>
				</div>

			</div>



			<div class="v-review">
				<div class="v-review-css-01">
					<div
						style="padding-top: 30px; display: flex; padding-right: 100px;">
						<%-- 평균 평점 출력 --%>
						<fieldset class="rate rates stars">
							<c:forEach begin="1" end="5" var="rating" varStatus="vs">
								<input type="radio" style="font-size: 1em;"
									id="rating_${averageRating}_${6-vs.current}"
									name="stars_${averageRating}" value="${6-vs.current}"
									<c:if test="${averageRating eq 6-vs.current }">checked</c:if>>
								<label for="rating_${averageRating}_${6-vs.current}"
									title="${6-vs.current}점"></label>
							</c:forEach>
						</fieldset>
						<div style="font-size: 34px; margin-left: 12px; font-weight: 700;">
							<span>${averageRating }</span>
						</div>
					</div>
					<div
						style="border-left: 1px solid #ededed; padding-left: 100px; display: flex;">
						<div style="display: flex; flex-direction: column;">
							<div class="rating-label">5점</div>
							<div class="rating-label">4점</div>
							<div class="rating-label">3점</div>
							<div class="rating-label">2점</div>
							<div class="rating-label">1점</div>
						</div>
						<c:set var="totalstarpp" value="${reviewList.size() }" />
						<c:set var="fiveStarWidth"
							value="${(fiveStarCount / totalstarpp) * 100}" />
						<c:set var="fourStarWidth"
							value="${(fourStarCount / totalstarpp) * 100}" />
						<c:set var="threeStarWidth"
							value="${(threeStarCount / totalstarpp) * 100}" />
						<c:set var="twoStarWidth"
							value="${(twoStarCount / totalstarpp) * 100}" />
						<c:set var="oneStarWidth"
							value="${(oneStarCount / totalstarpp) * 100}" />
						<div class="rating">
							<div class="bar">
								<div class="bar-fill" id="five-star"
									style="width: ${fiveStarWidth}%"></div>
							</div>
							<div class="bar">
								<div class="bar-fill" id="four-star"
									style="width: ${fourStarWidth}%"></div>
							</div>
							<div class="bar">
								<div class="bar-fill" id="three-star"
									style="width: ${threeStarWidth}%"></div>
							</div>
							<div class="bar">
								<div class="bar-fill" id="two-star"
									style="width: ${twoStarWidth}%"></div>
							</div>
							<div class="bar">
								<div class="bar-fill" id="one-star"
									style="width: ${oneStarWidth}%"></div>
							</div>
						</div>
						<div style="display: flex; flex-direction: column;">
							<div class="user-count">${fiveStarCount }명</div>
							<div class="user-count">${fourStarCount }명</div>
							<div class="user-count">${threeStarCount }명</div>
							<div class="user-count">${twoStarCount }명</div>
							<div class="user-count">${oneStarCount }명</div>
						</div>
					</div>
				</div>


			</div>
			<table class="custom-table">
				<thead>
					<tr>
						<th class="title-col">제목</th>
						<th>내용</th>
						<th>아이디</th>
						<th>작성일</th>
						<th>별점</th>
					</tr>
				</thead>
				<tbody>
					<!-- 게시글 아이템 -->
					<c:if test="${empty reviewlist}"> 해당상품의 리뷰가 존재하지 않습니다.</c:if>
					<c:if test="${!empty reviewlist}">
						<c:forEach items="${reviewlist}" var="vo">
							<tr class="dataRow reviewRow">
								<td style="display: none;" class="reviewno">${vo.reNo }</td>
								<td class="title-col">${vo.title}</td>
								<td>${vo.content}</td>
								<td>${vo.id}</td>
								<td><fmt:formatDate value="${vo.reviewDate}"
										pattern="yyyy-MM-dd" /></td>
								<td>
									<fieldset class="rate stars">
										<c:forEach begin="1" end="5" var="rating" varStatus="vs">
											<input type="radio" id="rating_${vo.reNo}_${6-vs.current}"
												name="stars_${vo.reNo}" value="${6-vs.current}"
												<c:if test="${vo.stars eq 6-vs.current }">checked</c:if>>
											<label for="rating_${vo.reNo}_${6-vs.current}"
												title="${6-vs.current}점"></label>
										</c:forEach>
									</fieldset>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
			<div class="review-button">
				<button class="v-reviewBtn">리뷰쓰기</button>
			</div>
		</div>


		<div id="product-coments" style="width: 80%;">
			<div class="product-view-info">문의</div>
			<div id="product-co">
				<c:if test="${empty qnalist}"> 해당상품의 대한 문의가 존재하지 않습니다.</c:if>
				<c:if test="${!empty qnalist}">
					<c:forEach items="${qnalist}" var="vo">
						<div class="panel panel-success dataRow qnadataBtn"
							data-no="${vo.no }">
							<div class="panel-heading">
								제목 : ${vo.title} <span class="badge pull-right">번호
									:${vo.no }</span>
							</div>
							<div class="panel-body">내용 : ${vo.content }</div>
							<div class="panel-footer">아이디 : ${vo.id }</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
			<div class="qna-button">
				<button class="v-qnaBtn">문의쓰기</button>
			</div>
		</div>
		<div id="product-delivery" class="product-view-info">
			<div class="product-view-info">배송/환불</div>
			<section class="production-selling-section" style="font-size: 13px;">
				<div class="product-view-info">#배송</div>
				<table class="production-selling-table">
					<tbody>
						<tr>
							<th>배송</th>
							<td>일반택배</td>
						</tr>
						<tr>
							<th>배송비</th>
							<td>무료배송</td>
						</tr>
						<tr>
							<th>도서산간 추가 배송비</th>
							<td>5,000원</td>
						</tr>
						<tr>
							<th>배송불가 지역</th>
							<td>배송불가 지역이 없습니다.</td>
						</tr>
						<tr>
							<th>지역별 차등 배송비</th>
							<td>지역에 따라 추가 배송비 발생 될 수 있습니다.</td>
						</tr>
					</tbody>
				</table>
			</section>
			<section class="production-selling-section" style="font-size: 13px;">
				<div class="product-view-info">#환불</div>
				<table class="production-selling-table">
					<tbody>
						<tr>
							<th>반품배송비</th>
							<td>3,000원 (최초 배송비가 무료인 경우 6,000원 부과)</td>
						</tr>
						<tr>
							<th>교환배송비</th>
							<td>6,000원</td>
						</tr>
						<tr>
							<th>보내실 곳</th>
							<td>Ezen확원~</td>
						</tr>
					</tbody>
				</table>
			</section>

		</div>
		<c:if test="${!empty login }">
			<c:if test="${login.grade_no >= 8 }">
				<div class="row" style="display: flex; gap: 20px;">
					<div style="margin-left: auto;">
						<a
							href="update.do?no=${vo.item_no }&page=${param.page }&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}"><button
								class="btn btn-default">수정</button></a>
					</div>
					<div>
						<a
							href="delete.do?item_no=${vo.item_no }&perPageNum=${param.perPageNum}"
							id="deleteBtn"><button class="btn btn-default">삭제</button></a>
					</div>
				</div>
			</c:if>
		</c:if>
	</section>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#view-contents").click(function() {
				$("#product-img").attr("tabindex", -1).focus();
			});

			$("#view-reviews").click(function() {
				$("#product-review").attr("tabindex", -1).focus();
			});

			$("#view-coments").click(function() {
				$("#product-co").attr("tabindex", -1).focus();
			});

			$("#view-deliverys").click(function() {
				$("#product-delivery").attr("tabindex", -1).focus();
			});
		});
	</script>

</body>
</html>