<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>주문 목록</h2>
<ul class="orderList">
 <c:forEach items="${list}" var="list">
 <li>
 <div>
  <p><span>주문번호</span>${list.orderNo}</p>
  <p><span>주문자</span>${list.id}</p>
  <p><span>수령인</span>${list.buyUser}</p>
  <p><span>주문 날짜</span>${list.orderDate}</p>
  <p><span>주소</span>(${list.addres1}) ${list.addres2} ${list.addres3}</p>
  <p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${list.allPrice}" /> 원</p>
  <button>주문취소</button> 
 </div>
 </li>
 </c:forEach>
</ul>
</body>
</html>