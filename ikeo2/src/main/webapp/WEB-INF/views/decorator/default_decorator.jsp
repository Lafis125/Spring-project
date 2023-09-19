<!-- sitemesh 사용을 위한 설정 파일 -->
<!-- 작성자 : 이영환 -->
<!-- 작성일 : 2020-06-30 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>웹짱:<decorator:title /></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script src="/resources/js/jquery-3.6.4.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/css/main.css?v=9">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
	type="text/css">
<link
	href="http://mozilla.github.io/foundation-icons/assets/foundation-icons.css"
	type="text/css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<script type="text/javascript">
	$(document).ready(function() {
	});
</script>
<style type="text/css">
.widget-inner ul li a i {
	margin-left: 5px;
	padding-right: 8px;
	width: 60px;
	margin-bottom: 8px;
	padding-right: 10px;
}

.widget-inner p i {
	margin-left: 5px;
	margin-right: 10px;
	margin-bottom: 5px;
}

a {
    color: black;
    text-decoration: none;
}
</style>
<c:if test="${!empty msg }">
	<script type="text/javascript">
		$(function() {
			$("#msgModal").modal("show");
		});
	</script>
</c:if>
<script type="text/javascript">
	$.ajax({
		url : "/categoryAjax/category.action",
		type : 'GET',
		processData : true,
		success : function(list) {
			var categoryContainer = $("#categoryList-99"); // 해당 컨테이너를 jQuery로 선택

			for (var i = 0; i < list.length; i++) {
				var categoryName = list[i].category_name;
				var categoryNo = list[i].category_no;
				var newCategoryItem = '<span><div><a class="css-category"'
						+ ' href="/product/list.do?category_no=' + categoryNo
						+ '&category_name=' + categoryName + '"><div><p>'
						+ categoryName + '</p></div></a></div></span>';
				categoryContainer.append(newCategoryItem);
			}
		},
		error : function(xhr, status, error) {
			console.log("오류");
		}
	});
</script>

<decorator:head />
</head>
<body>
	<header>
		<div class="header-item01">
			<div class="header-item01-1">
				<div>
					<a href="/main.do"> <img alt="logo"
						src="/resources/img/log/logo.png"
						style="width: 65px; height: 65px;">
					</a>
				</div>
				<div class="itemsecond">
					<a href="/community/list.do" class="css-community"> <span>
							커뮤니티 </span>
					</a> <a href="/product/list.do" class="css-shoping"> <span>
							쇼핑 </span>
					</a> <a href="/event/list.do" class="css-event"> <span> 이벤트
					</span>
					</a>

				</div>
				<div class="itemthird" style="margin-right: 89px;">
					<div class="itemthird-1">
						<div>
							<a href="/cart/list.do" id="cartrider"><img alt="장바구니"
								src="/resources/img/dec/shopping-cart.png" style="width: 50px;" /></a>
						</div>
						<div class="css-navR">
							<div class="css-member">
								<!-- 로그인이 안되어 있을 때 -->
								<c:if test="${empty login }">
									<a href="/member/login.do" class="css-login"> 로그인 </a>
									<a href="/member/register.do" class="css-signup"> 회원가입 </a>
									<a href="/qna/list.do" class="css-signup"> 고객센터</a>
								</c:if>
								<!-- 로그인이 되어 있을 때 -->
								<c:if test="${!empty login }">
									<!-- 등급이 8 보다 작을 때 -->
									<c:if test="${login.grade_no < 8 }">
										<a href="/member/mypage.do" class="css-login"> 마이페이지 </a>
									</c:if>
									<!-- 등급이 8 이상 일 때 -->
									<c:if test="${login.grade_no >= 8 }">
										<a href="/member/list.do" class="css-login"> 회원관리 </a>
										<a href="/member/seller/list.do" class="css-login"> 판매자관리</a>
									</c:if>
										<a href="/member/logout.do" class="css-signup"> 로그아웃 </a>
								</c:if>
							</div>
							<span>
								<button class="nav-writebtn">글쓰기</button>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="header-item02">
			<div class="header-item02-1">
				<div class="item02one" id="categoryList-99">
					<span><div>
							<a class="css-category" href="/main.do">
								<div>
									<p>홈</p>
								</div>
							</a>
						</div> </span>
				</div>
				<div></div>
			</div>
		</div>
	</header>
	<main class="container main-container">
		<decorator:body />
	</main>
	<div class="footer">
		<div class="container">
			<div class="row">
				<div class="col-md-3 col-sm-3">
					<div class="single-widget">
						<h2 class="widget-title">About Us</h2>
						<div class="widget-inner">
							<p>
								<i class="fa fa-building fa-2x" aria-hidden="true"></i>Office:
								EZEN Academy
							</p>
							<p>
								<i class="fa fa-phone-square fa-2x" aria-hidden="true"></i>Phone:
								010-xxxx-xxxx
							</p>
							<p>
								<i class="fa fa-fax fa-2x" aria-hidden="true"></i>Fax:
								000-xxxx-xxxx
							</p>
							<p>
								<i class="fa fa-envelope-o fa-2x" aria-hidden="true"></i>Email:
								Ezen@google.com
							</p>
						</div>
					</div>
				</div>

				<div class="col-md-3 col-sm-3">
					<div class="single-widget">
						<h2 class="widget-title">Customer Care</h2>
						<div class="widget-inner">
							<ul style="padding-left: 0px;">
								<li><a href="/member/login.do"><i
										class="fa fa-user fa-2x" aria-hidden="true"></i>Ikeo Member</a></li>
								<li><a href="/cart/list.do"><i
										class="fa fa-cart-plus fa-2x" aria-hidden="true"></i>Ikeo Cart</a></li>
								<li><a href="/community/list.do"><i
										class="fa fa-bars fa-2x" aria-hidden="true"></i>Ikeo Community</a></li>
								<li><a href="/product/list.do"><i
										class="fa fa-product-hunt fa-2x" aria-hidden="true"></i>Ikeo
										Product</a></li>
								<li><a href="/event/list.do"><i
										class="fa fa-calendar fa-2x" aria-hidden="true"></i>Ikeo Event</a></li>
							</ul>
						</div>
					</div>
				</div>

				<div class="col-md-3 col-sm-3">
					<div class="single-widget">
						<h2 class="widget-title">information</h2>
						<div class="widget-inner">
							<ul style="padding-left: 0px;">
								<li><a href="/main.do"><i class="fa fa-info fa-2x"
										aria-hidden="true"></i>Contact Us</a></li>
								<li><a href="/main.do"><i class="fa fa-info fa-2x"
										aria-hidden="true"></i>Sitemap</a></li>
								<li><a href="/main.do"><i class="fa fa-info fa-2x"
										aria-hidden="true"></i>Gift Vouchers</a></li>
								<li><a href="/main.do"><i class="fa fa-info fa-2x"
										aria-hidden="true"></i>Live Chat</a></li>
							</ul>
						</div>
					</div>
				</div>

				<div class="col-md-3 col-sm-3">
					<div class="single-widget">
						<h2 class="widget-title">Our SNS</h2>
						<div class="widget-inner">
							<ul style="padding-left: 0px;">
								<li><a href="https://www.facebook.com/"> <i
										class="fa fa-facebook-official fa-2x" aria-hidden="true"></i>Facebook
								</a></li>
								<li><a href="https://www.google.com/"> <i
										class="fa fa-google fa-2x" aria-hidden="true"></i>Google
								</a></li>
								<li><a href="https://twitter.com/"> <i
										class="fa fa-twitter-square fa-2x" aria-hidden="true"></i>Twitter
								</a></li>
								<li><a href="https://kr.linkedin.com/"> <i
										class="fa fa-linkedin fa-2x" aria-hidden="true"></i>Linkedin
								</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:if test="${!empty msg }">
		<!-- 처리된 메시즈를 보이게 하는 모달 창 -->
		<div id="msgModal" class="modal fade" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">처리 결과</h4>
					</div>
					<div class="modal-body">
						<p>${msg }</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>

			</div>
		</div>
	</c:if>

</body>
</html>