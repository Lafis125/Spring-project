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
		$("#findIdBtn").click(function() {
			$.ajax({
				url : '/memberAjax/findId.action',
				type : 'POST',
				data : {
					name : $('#name').val(),
					tel : $('#tel').val()
				},
				success : function(data) {
					let id = data;
					if(id) {
						$("#result").text('찾으시는 아이디 : ' + id);
					}
					else {
						$("#result").text("입력한 정보와 맞는 아이디가 없습니다\n입력하신 정보를 다시 확인해주세요");
					}
				},
				error : function() {

				}
			});
		});
	});
</script>
</head>
<body>
	<div class="col-md-3"></div>
	<div class="col-md-5">
		<div class="card-sm card-2">
			<h2>아이디 찾기</h2>
			<center>
				<div class="items">
					<div class="a">
						<input type="text" name="name" id="name" class="b" required> <label
						class="c">이름</label> <span class="d"></span>
					</div>
				</div>
				<div class="items">
					<div class="a">
						<input type="tel" name="tel" id="tel" class="b" required> <label
						class="c">전화번호</label> <span class="d"></span>
					</div>
				</div>
				<div>
					<button type="button" id="findIdBtn" class="button__item login-button__item--black"
						data-toggle="modal" data-target="#findIdModal">찾기</button>
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
	<div class="modal fade" id="findIdModal" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">아이디 찾기 결과</h4>
				</div>
				<div class="modal-body">
					<div id="result"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>