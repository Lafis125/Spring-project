<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
	<h2>리뷰 수정</h2>
	<form action="update.do" method="post">
		<div class="form-group">
			<label for="item_No">구매상품번호</label>
			<input id="item_No" name="item_No" required class="form-control" value="${vo.item_No }" readonly >
		</div>
		<div class="form-group">
			<label for="reNo">번호</label>
			<input id="reNo" name="reNo" required class="form-control" value="${vo.reNo }" readonly >
		</div>
		<div class="form-group">
			<label for="title">제목</label>
			<input id="title" name="title" required  class="form-control"  value="${vo.title }" >
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<textarea rows="5" id="content" name="content" required 
			 class="form-control" >${vo.content }</textarea>
		</div>
		<button class="btn btn-default">수정</button>
	</form>
</div>
</body>
</html>