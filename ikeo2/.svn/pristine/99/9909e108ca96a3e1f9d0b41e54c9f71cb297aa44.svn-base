<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Event</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script src="/resources/js/jquery-3.6.4.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<style type="text/css">
#deleteDiv {
	display: none;
}

#data>.row>div {
	padding: 10px 20px;
}

#data>.row {
	border-bottom: 1px dotted #aaa;
}

#changeImageDiv {
	display: none;
}

/* 작은 이미지의 div의 크기가 정해지면 이미지 */
#imageListDiv .imgDiv {
	overflow: hidden;
}

.data-title {
	font-size: 32px;
	line-height: 1.4;
	color: #121212;
	font-weight: 500;
	text-align: center;
}

.data-date {
	margin: 8px 0 0 0;
	font-size: 16px;
	line-height: 1.4;
	color: #828282;
	text-align: center;
}

.data-content {
	font-size: 20px;
	margin-top: 10px;
}

.hearder-auth{
	font-size: 16px;
    padding-left: 10px;
    line-height: 27px;
}
</style>
<script type="text/javascript">
$(function(){
	$("#deleteBtn").click(function(){
		if(!confirm("정말 삭제하시겠습니까?")) return false;
	});
});
</script>
</head>
<body>
	<div class="container">
		<div id="data">
			<div class="head" style="margin-bottom: 35px;">
				<div>
					<h2 class="data-title">${vo.title }</h2>
				</div>
				<div class="data-date">
					<fmt:formatDate value="${vo.start_date }" pattern="yyyy-MM-dd" />
					-
					<fmt:formatDate value="${vo.end_date }" pattern="yyyy-MM-dd" />
				</div>
			</div>
			<div class="hearder-auth">
				<div class="data-writer">
					<div class="data-writer">
						<div style="display: flex; align-items: center;">
							<span class="glyphicon glyphicon-user"
								style="font-size: 13px; color: #828282;"></span>
							<div class="data-nick" style="margin-left: 5px;">${vo.id }</div>
						</div>
					</div>
					<div class="data-writeDate">
						<div style="display: flex; align-items: center;">
							<span class="glyphicon glyphicon-calendar"
								style="font-size: 13px; color: #828282;"></span> <span
								style="margin-left: 5px;"><fmt:formatDate
									value="${vo.write_date }" pattern="yy-MM-dd" /></span>
						</div>
					</div>
				</div>
			</div>

			<div class="img-content">
				<c:forEach items="${imageList }" var="imageVO">
					<c:if test="${imageVO.pr == 0}">
						<div class="imgDiv img-thumbnail"
							style="padding: 10px 3px 3px 3px;">
							<img alt="${imageVO.file_name }" src="${imageVO.file_name }"
								data-pr="${imageVO.pr }" style="width: 100%;"
								data-image_no="${imageVO.image_no }">
						</div>
					</c:if>
				</c:forEach>
			</div>

			<div class="data-content">${vo.content }</div>
		</div>
		<div style="margin-top: 30px">
			<a
				href="list.do?page=${param.page }&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}"
				class="btn btn-default">리스트</a>
			<c:if test="${vo.id == login.id && login.grade_no >= 8}">
				<a
					href="update.do?no=${vo.no }&page=${param.page }&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}"
					class="btn btn-default">수정</a>
				<a href="delete.do?no=${vo.no}&perPageNum=${param.perPageNum}"
					class="btn btn-default" id="deleteBtn">삭제</a>
			</c:if>
		</div>
	</div>
	<%@ include file="../eventReply/list.jsp"%>
</body>
</html>