<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" href="/resources/css/member.css?v=2">
<script type="text/javascript">
	$(function() {
		$("#findPwBtn")
				.click(
						function() {
							$
									.ajax({
										url : '/memberAjax/findPw.action',
										type : 'POST',
										data : {
											id : $('#id').val(),
											tel : $('#tel').val()
										},
										success : function(data) {
											let result = data;
											let resultHtml = "";
											let buttonHtml = "<button type=\"submit\" class=\"btn btn-default\">수정</button>";
											if (result == 1) {
												// 비밀번호 재설정
												resultHtml += "새로 설정할 비밀번호를 입력해주세요";
												resultHtml += "<div>";
												resultHtml += "<div class=\"form-group\">";
												resultHtml += "<input type=\"hidden\" class=\"form-control\" name=\"id\" value=\""
														+ $('#id').val()
														+ "\">";
												resultHtml += "<input type=\"password\" class=\"form-control\" name=\"pw\">";
												resultHtml += "</div>"
												resultHtml += "</div>";
												$('#changePwContent').html(
														resultHtml);
												$('#changePwBtn').html(buttonHtml);
											} else {
												// 계정 정보 없음
												$('#changePwContent')
														.html(
																'해당 정보와 일치하는 계정이 없습니다<br>계정 정보를 다시 확인해 주세요');
											}
										},
										error : function() {
											console.log('비밀번호 찾기 중 오류 발생');
										}
									})
						})
	});
</script>
</head>
<body>
	<div class="col-md-3"></div>
	<div class="col-md-5">
		<div class="card-sm card-2">
			<h2>비밀번호 찾기</h2>
			<center>
				<div class="items">
					<div class="a">
						<input type="text" name="id" id="id" class="b" required> <label
						class="c">아이디</label> <span class="d"></span>
					</div>
				</div>
				<div class="items">
					<div class="a">
						<input type="tel" name="tel" id="tel" class="b" required>
						<label class="c">전화번호</label> <span class="d"></span>
					</div>
				</div>
				<div>
					<button type="button" id="findPwBtn" class="button__item login-button__item--black"
						data-toggle="modal" data-target="#changePwModal">찾기</button>
				</div>
			</center>
				<div>
					<div class="items" style="width: 280px; text-align: center; margin-bottom: 20px;"><a href="/member/findId.do">아이디 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/member/findPw.do">비밀번호 찾기</a></div>
					<div class="items" style="width: 280px; text-align: center;"><a href="/member/register.do">회원가입</a></div>
				</div>
		</div>
	</div>
	<div class="col-md-4"></div>

	<!-- Modal -->
	<div class="modal fade" id="changePwModal" role="dialog">
		<div class="modal-dialog modal-sm">
			<form action="changePw.do" method="post">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">비밀번호 찾기</h4>
					</div>
					<div class="modal-body">
						<div id="changePwContent"></div>
					</div>
					<div class="modal-footer">
						<div id="changePwBtn" style="float: left;"></div>
						<button type="button" class="btn btn-default" data-dismiss="modal" style="float: right;">Close</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>