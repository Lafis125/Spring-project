<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 등록</title>
<style type="text/css">
@import url(//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);
.rate {
  display: inline-block;
  border: 0;
  margin-right: 15px;
}
.rate > input {
  display: none;
}
.rate > label {
  float: right;
  color: #ddd;
}
.rate > label:before {
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
.rate input:checked ~ label,
.rate label:hover,
.rate label:hover ~ label {
  color: #f73c32 !important;
}
.rate input:checked + .rate label:hover,
.rate input input:checked ~ label:hover,
.rate input:checked ~ .rate label:hover ~ label,
.rate label:hover ~ input:checked ~ label {
  color: #f73c32 !important;
}

</style>
</head>
<body>
<div class="container">
	<h2>리뷰 등록</h2>
	<form action="write.do" method="post" enctype="multipart/form-data">
		<input name="perPageNum" value="${param.perPageNum }" type="hidden">
		<div class="form-group">
			<label for="itemNo">구매상품번호</label>
			<input id="itemNo" name="itemNo" required class="form-control" value="${param.itemNo }" readonly >
		</div>
		<div class="form-group">
			<label for="title">제목</label>
			<input id="title" name="title" required class="form-control">
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<textarea rows="5" id="content" name="content" required class="form-control"></textarea>
		</div>
		<div class="form-group">
			<label for="stars">별점</label>
	<fieldset class="rate" id = "stars">
  <input type="radio" id="rating5" name="stars" value="5"><label for="rating5" title="5점">${stars }</label>
  <input type="radio" id="rating4" name="stars" value="4"><label for="rating4" title="4점">${stars }</label>
  <input type="radio" id="rating3" name="stars" value="3"><label for="rating3" title="3점">${stars }</label>
  <input type="radio" id="rating2" name="stars" value="2"><label for="rating2" title="2점">${stars }</label>
  <input type="radio" id="rating1" name="stars" value="1"><label for="rating1" title="1점">${stars }</label>
</fieldset>
		</div>
		<div class="form-group">
			<label for="fileName">이미지</label>
			<input id="fileName" name="imageFile" class="form-control" type="file">
		</div>
		<div id="appendDiv" style="margin-bottom: 10px; "></div>
		<button class="btn btn-default">등록</button>
	</form>
</div>
</body>
</html>