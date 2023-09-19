<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="/resources/css/member.css?v=3">
<style type="text/css">
</style>
</head>
<body>
	<div class="col-md-3"></div>
	<div class="col-md-5">
		<div class="card-sm card-2">
				<h2>LOGIN</h2>
				<center>
					<form action="login.do" method="post">
						<div class="items">
								<div class="a">
									<input type="text" name="id" id="id" class="b" required> 
									<label class="c">아이디</label> <span class="d"></span>
								</div>
						</div>
						<div class="items">
							<div class="a">
								<input type="password" name="pw" id="pw" class="b" required>
								<label class="c">비밀번호</label> <span class="d"></span>
							</div>
						</div>
						<div>
							<button type="submit" class="button__item login-button__item--black">로그인</button>
						</div>
					</form>
				</center>
				<div>
					<div class="items" style="width: 280px; text-align: center; margin-bottom: 20px;">
						<a href="/member/findId.do">아이디 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a
							href="/member/findPw.do">비밀번호 찾기</a>
					</div>
					<div class="items" style="width: 280px; text-align: center;">
						<a href="/member/register.do">회원가입</a>
					</div>
				</div>
		</div>
	</div>
	<div class="col-md-4"></div>
</body>
</html>