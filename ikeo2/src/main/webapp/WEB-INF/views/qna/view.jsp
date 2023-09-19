<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Qna View</title>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
  <script src="/resources/js/jquery-3.6.4.js"></script>
  <script src="/resources/js/bootstrap.min.js"></script>

	<style type="text/css">
		#deleteDiv{
			display: none;
		}
	</style>
</head>
<body>
<div class="container">
	<h2>Qna View</h2>
	<table class="table">
		<tr>
			<th>번호</th>
			<td>${vo.no }</td>
		</tr>
		<tr>
			<th>문의상품번호</th>
			<td>${vo.item_No }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${vo.title }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${vo.content }</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${vo.id}</td>
		</tr>
		<tr>
			<th>작성일</th>
		<td><fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd"/></td>
		</tr>
	</table>
		<c:if test="${vo.id == login.id || login.grade_no == 9}">
		<a href="update.do?no=${vo.no }&item_no=${vo.item_No}" class="btn btn-default">수정</a>
		<a href="delete.do?no=${vo.no }&item_No=${vo.item_No}" class="btn btn-default" id="deleteBtn">삭제</a>
	 </c:if>
	<a href="/product/view.do?no=${vo.item_No}"
	 class="btn btn-default">리스트</a>
	<div id="deleteDiv">
			<input name="no" type="hidden" value="${vo.no }">
			<div class="panel panel-default">
			  <div class="panel-footer">
			  	<button class="btn btn-default">삭제</button>
			  	<button id="cancelBtn" class="btn btn-default" type="button">취소</button>
			  </div>
			</div>
</div>
 <%@include file="../qnareply/list.jsp"%>
</div>
</body>
</html>


