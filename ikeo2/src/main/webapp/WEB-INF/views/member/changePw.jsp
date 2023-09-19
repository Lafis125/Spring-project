<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<link rel="stylesheet" href="/resources/css/member.css">
<script src="/resources/js/regEx.js?v=6"></script>
<script type="text/javascript">
var t_checkPw = false;

//비밀번호 유효성 검사
function checkPwFunc() {
	checkPw($("#pw").val(), function (t) {
		if(t) {
			t_checkPw = true;
		}
		else {
			t_checkPw = false;
		}
	});
}

$(function(){
	$("#changeBtn").click(function(){
		let pw = $("#pw").val();
		let pw1 = $("#pw1").val();
		if(pw != pw1) {
			alert("변경할 비밀번호와 비밀번호 확인이 다릅니다");
			$("#pw").val('');
			$("#pw1").val('');
			$("#pw").focus();
			return false;
		}
		if(!t_checkPw) {
			alert("비밀번호는 영문 숫자 특수기호 조합 8자리 이상 입력하셔야 합니다");
			return false;
		}
	});
});
</script>
<style type="text/css">
form-group{
	width: 250px;
}
</style>
</head>
<body>
	<div class="col-md-3"></div>
	<div class="col-md-5">
		<div class="card-sm card-2">
			<h2>비밀번호 변경</h2>
			<form action="changePw.do" method="post">
				<input type="hidden" name="id" value="${login.id }">
				<div class="form-group" id="form-pw">
					<label>변경할 비밀번호: </label>
					<input type="password" name="pw" id="pw" class="form-control input-lg"
					placeholder="변경할 비밀번호" onkeyup="checkPwFunc();">
				</div>
				
				<div class="form-group">
					<label>변경할 비밀번호 확인: </label>
					<input type="password" id="pw1" class="form-control input-lg"
					placeholder="변경할 비밀번호 확인">
				</div>
				<center>
					<div style="margin-bottom: 30px;">
						<button type="submit" id="changeBtn" class="button__item login-button__item--black">변경</button>
					</div>
				</center>
			</form>
		</div>
	</div>
	<div class="col-md-4"></div>
</body>
</html>