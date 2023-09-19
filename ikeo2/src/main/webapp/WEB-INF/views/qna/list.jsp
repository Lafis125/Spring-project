<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Qna list</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
#deleteDiv {
	display: none;
}

.dataRow:hover {
	cursor: pointer;
	background: #dddddd;
}

table {
	width: 300px;
	height: 200px;
}

th, td {
	text-align: center;
}
</style>

<script type="text/javascript">
	$(function() {
		$("#deleteBtn,#cancelBtn").click(function() {
			$("#deleteDiv").slideToggle();
			return false;
		});
		// 이벤트 처리
		$(".dataRow").click(function() {
			let no = $(this).data("no");
			let item_no = $(this).data("items");
			location = "view.do?no=" + no + "&item_no=" + item_no;
		});
	});
</script>

</head>
<body>

	<c:if test="${empty list}"> 해당상품의 대한 문의가 존재하지 않습니다.
		</c:if>
	<c:if test="${!empty list}">
		<div class="container">
			<c:forEach items="${list}" var="vo">
				<input type="hidden" data-items="${vo.item_No }">
				<div class="panel panel-success dataRow" data-no="${vo.no }">
					<div class="panel-heading">
						제목 : ${vo.title} <span class="badge pull-right">번호 :${vo.no }</span>
					</div>
					<div class="panel-body">내용 : ${vo.content }</div>
					<div class="panel-footer">
						아이디 : ${vo.id }<span class="badge pull-right">문의상품번호
							:${vo.item_No }</span>
					</div>

				</div>
			</c:forEach>


		</div>
	</c:if>

	<div>
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>
	</div>
	<a
		href="write.do?item_no=${param.item_no }&perPageNum=${pageObject.perPageNum }"
		class="btn btn-default">등록</a>
</body>
</html>