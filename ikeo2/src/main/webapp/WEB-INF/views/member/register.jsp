<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="/resources/css/member.css?v=3">
<script src="/resources/js/regEx.js?v=11"></script>
<style type="text/css">
#hidePwBtn {
	display: none;
}

#b {
	display: none;
}

body{
	margin-bottom: 100px;
}
</style>
<script type="text/javascript">
	// 0 : 다시 입력
	// 1 : 회원가입 가능한 양식
	var t_checkId = false;
	var t_checkNickname = false;
	var t_checkPw = false;
	var t_checkName = false;
	var t_checkTel = false;
	var t_checkEmail = false;
	
	// 아이디 중복 체크
	function checkIdFunc() {
		checkId($("#id").val(), function (t) {
			if(t) {
				t_checkId = true;
			}
			else {
				t_checkId = false;
			}
		});
	}

	// 닉네임 중복 체크
	function checkNicknameFunc() {
		checkNickname($("#nickname").val(), function (t) {
			if(t) {
				t_checkNickname = true;
			}
			else {
				t_checkNickname = false;
			}
		});
	}

	// 비밀번호 유효성 검사
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

	// 이름 유효성 검사
	function checkNameFunc() {
		checkName($("#name").val(), function (t) {
			if(t) {
				t_checkName = true;
			}
			else {
				t_checkName = false;
			}
		});
	}

	// 전화번호 유효성 검사
	function checkTelFunc() {
		checkTel($("#tel").val(), function (t) {
			if(t) {
				t_checkTel = true;
			}
			else {
				t_checkTel = false;
			}
		});
	}

	// 이메일 유효성 검사
	function checkEmailFunc() {
		checkEmail($("#email").val(), $("#domain").val(), function (t) {
			if(t) {
				t_checkEmail = true;
			}
			else {
				t_checkEmail = false;
			}
		});
	}

// 0 : 비밀번호 안보이게 설정
// 1 : 비밀번호 보이게 설정
let showPwToggle = 0;
	$(function() {
		$("#showPwBtn").click(function() {
			// 비밀번호 안보이는 상태 -> 보이는 상태로 변경
			if(showPwToggle == 0) {
				$("#showPwIcon").removeClass("glyphicon-eye-open");
				$("#showPwIcon").addClass("glyphicon-eye-close");
				$("#pw").attr("type", "text");
				showPwToggle = 1;
			// 비밀번호 보이는 상태 -> 안보이는 상태로 변경
			} else {
				$("#showPwIcon").removeClass("glyphicon-eye-close");
				$("#showPwIcon").addClass("glyphicon-eye-open");
				$("#pw").attr("type", "password");
				showPwToggle = 0;
			}
		});
		// 이메일 도메인 선택 시
		$("#domain-selector").change(function() {
			let domain = $("#domain-selector").val();
			if (domain == '') {
				$("#domain").removeAttr("readonly");
			} else {
				$("#domain").attr("readonly", "readonly");
			}
			$("#domain").val(domain);
			checkEmailFunc();
		});
		// 회원가입 버튼을 누르면 회원가입 입력란이 나옵니다
		$("#registerBtn").click(function(){
			if($("#agree").prop("checked")) {
				$("#a").css("display", "none");
				$("#b").css("display", "flex");
			}
			else {
				alert("회원가입 약관에 동의하셔야 회원가입을 할 수 있습니다");
			}
		});
		// 회원가입시 잘못 작성한 칸이 있다면 회원가입 처리가 되지 않습니다
		$("#writeBtn").click(function(){
			console.log("id : " + t_checkId);
			console.log("nickname : " + t_checkNickname);
			console.log("pw : " + t_checkPw);
			console.log("name : " + t_checkName);
			console.log("tel : " + t_checkTel);
			console.log("email : " + t_checkEmail);
			if(!t_checkId) {
				$("#id").focus();
				return false;
			}
			if(!t_checkNickname) {
				$("#nickname").focus();
				return false;
			}
			if(!t_checkPw) {
				$("#pw").focus();
				return false;
			}
			if(!t_checkName) {
				$("#name").focus();
				return false;
			}
			if(!t_checkTel) {
				$("#tel").focus();
				return false;
			}
			if(!t_checkEmail) {
				$("#email").focus();
				return false;
			}
		});

		// 아이디 확인을 받아야 회원가입이 가능합니다
		$("#id").change(function(){
			t_checkId = false;
			$("#checkId").text("아이디 중복 검사를 하셔야 회원가입이 가능합니다");
			$("#checkId").css("background-color", "tomato");
			$("#form-id").removeClass("has-success has-error");
			$("#form-id").addClass("has-error");
		});

		// 닉네임 확인을 받아야 회원가입이 가능합니다
		$("#nickname").change(function(){
			t_checkNickname = false;
			$("#checkNickname").text("닉네임 중복 검사를 하셔야 회원가입이 가능합니다");
			$("#checkNickname").css("background-color", "tomato");
			$("#form-nickname").removeClass("has-success has-error");
			$("#form-nickname").addClass("has-error");
		});
	});
</script>
</head>
<body>
	<div class="col-md-2"></div>
	<div class="col-md-8">
		<div class="card-lg card-2" id="a">
			<h2>회원가입</h2>
			<div style="text-align: center;">
				<div class="items">
					<div class="form-group">
						<pre class="pre-scrollable form-control" style="overflow-x: hidden; height: 400px;">
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
							<p>회원가입 하시겠습니까?</p>
						</pre>
					</div>
				</div>
				<div class="items">
					<div class="form-group">
						<label><input type="checkbox" id="agree">동의합니다</label>
					</div>
				</div>
			</div>
			<div class="items-button">
				<button class="button__item login-button__item--black" id="registerBtn">회원가입</button>
			</div>
		</div>
		
		<div class="card-xl card-2" id="b">
			<h2>회원가입</h2>
			<form action="register.do" method="post">
				<div class="form-group input-group items-lg" id="form-id">
					<input type="text" name="id" id="id" class="form-control input-lg" required
						maxlength="20" placeholder="아이디를 입력해주세요">
					<div class="input-group-btn">
						<button type="button" class="btn btn-default btn-lg"
							onclick="checkIdFunc();">아이디 확인</button>
					</div>
				</div>
				<div class="form-group items-lg-check">
					<div id="checkId"></div>
				</div>

				<div class="input-group items-lg" id="form-pw">
					<input type="password" name="pw" id="pw" class="form-control input-lg"
						required maxlength="20" placeholder="비밀번호를 입력해주세요"
						onkeyup="checkPwFunc();">
					<div class="input-group-btn">
						<button class="btn btn-default btn-lg" id="showPwBtn" type="button">
							<i class="glyphicon glyphicon-eye-open" id="showPwIcon"></i>
						</button>
					</div>
				</div>
				<div class="form-group items-lg-check">
					<div id="checkPw"></div>
				</div>

				<div class="form-group items-lg" id="form-name">
					<input type="text" name="name" id="name" class="form-control input-lg"
						required onkeyup="checkNameFunc();" placeholder="이름을 입력해주세요">
				</div>
				<div class="form-group items-lg-check">
					<div id="checkName"></div>
				</div>

				<div class="form-group input-group items-lg" id="form-nickname">
					<input type="text" name="nickname" id="nickname"
						class="form-control input-lg" required placeholder="닉네임을 입력해주세요">
					<div class="input-group-btn">
						<button type="button" class="btn btn-default btn-lg"
							onclick="checkNicknameFunc();">닉네임 확인</button>
					</div>
				</div>
				<div class="form-group items-lg-check">
					<div id="checkNickname"></div>
				</div>

				<div class="form-group items-lg" id="form-tel">
					<input type="tel" name="tel" id="tel" class="form-control input-lg" required
						placeholder="전화번호를 입력해주세요" onkeyup="checkTelFunc();"
						maxlength="13">
				</div>
				<div class="form-group items-lg-check">
					<div id="checkTel"></div>
				</div>

				<div class="items" style="margin: 0%; width: 100%;">
					<div class="form-inline" style="text-align: center;">
						<div class="input-group" id="form-email">
							<input type="text" name="email" id="email" class="form-control input-lg"
								required placeholder="이메일을 입력해주세요" onkeyup="checkEmailFunc();">
							<span class="input-group-addon">@</span>
						</div>
						<div class="form-group" id="form-domain">
							<input type="text" name="domain" id="domain" class="form-control input-lg"
								required placeholder="도메인을 입력해주세요" onkeyup="checkEmailFunc();">
						</div>
						<div class="form-group">
							<select class="form-control input-lg" id="domain-selector">
								<option value="" selected>직접입력</option>
								<option value="naver.com">naver.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="outlook.com">outlook.com</option>
								<option value="hotmail.com">hotmail.com</option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group items-lg-check">
					<div id="checkEmail"></div>
				</div>
				
				<center>
					<div style="margin-bottom: 30px;">
						<button type="submit" class="button__item login-button__item--black" id="writeBtn">회원가입</button>
					</div>
				</center>
			</form>
		</div>
	</div>
	<div class="col-md-2"></div>
</body>
</html>