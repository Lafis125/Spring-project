<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="/resources/css/member.css">
<script src="/resources/js/regEx.js?v=6"></script>
<style type="text/css">
#updateBtn{

}
#submitBtn{
	display: none;
}
#cancelBtn{
	display: none;
}
</style>
<script type="text/javascript">
	// 1 : 수정 가능
	// 0 : 수정 불가능
	var t_checkNickname = true;
	var t_checkTel = true;
	var t_checkEmail = true;
	var myNickname = '${vo.nickname}';
	
	// 닉네임 중복 체크
	function checkNicknameFunc() {
		// 원래 자신의 닉네임 저장
		checkNickname($("#nickname").val(), function (t) {
			if(t) {
				t_checkNickname = true;
			}
			// 닉네임 중복인 경우
			else {
				// 자신의 닉네임인 경우
				if(myNickname == $("#nickname").val()) {
					$("#checkNickname").css("display", "none");
					$("#checkNickname").text("");
					$("#form-nickname").removeClass("has-success has-error");
					t_checkNickname = true;
				}
				// 자신의 닉네임이 아닌 경우
				else {
					t_checkNickname = false;
				}
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
		checkEmail2($("#email").val(), function (t) {
			if(t) {
				t_checkEmail = true;
			}
			else {
				t_checkEmail = false;
			}
		});
	}

$(function(){
	// 정보수정 버튼을 클릭하면 확인 버튼이 보이게 하고 나의 정보를 수정할 수 있도록 속성을 바꿉니다
	$("#updateBtn").click(function(){
		$("#updateBtn").hide();
		$("#cancelBtn").show();
		$("#submitBtn").show();
		$("#nickname").removeAttr("readonly");
		$("#birth").removeAttr("readonly");
		$("#tel").removeAttr("readonly");
		$("#email").removeAttr("readonly");
	});

	// 취소 버튼을 누르면 정보수정 버튼이 보이게 하고 나의 정보를 수정할 수 없도록 속성을 바꿉니다
	$("#cancelBtn").click(function(){
// 		$("#submitBtn").hide();
// 		$("#cancelBtn").hide();
// 		$("#updateBtn").show();
// 		$("#nickname").attr("readonly", "readonly");
// 		$("#birth").attr("readonly", "readonly");
// 		$("#tel").attr("readonly", "readonly");
// 		$("#email").attr("readonly", "readonly");
		location = "/member/mypage.do";
	});

	// 수정 버튼을 눌렀을 때 잘못된 입력이 있다면 수정 처리가 되지 않습니다
	$("#submitBtn").click(function(){
		if(!t_checkNickname) {
			$("#nickname").focus();
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
})
</script>
<style type="text/css">
ul > li {
	margin: 5px 0px;
	padding: 2px;
}
</style>
</head>
<body>
	<div class="col-md-3">
		<div style="margin-top: 100px;">
			<ul>
				<li><a href="/member/mypage.do">마이페이지</a></li>
				<li><a href="#">내가쓴글</a></li>
				<li><a href="#">내가쓴리뷰</a></li>
				<!-- 판매자 승인 대기, 판매자, 운영자, 관리자를 제외한 사용자만 판매자 신청 가능 -->
				<c:if test="${vo.grade_no < 6}">
					<li><a href="/member/seller/apply.do">판매자신청</a></li>
				</c:if>
				<!-- 판매자 승인 대기, 판매자 일 경우 판매자 정보 페이지로 가는 링크 -->
				<c:if test="${vo.grade_no == 6 || vo.grade_no == 7 }">
					<li><a href="/member/seller/mypage.do">판매자페이지</a></li>
				</c:if>
				<li><a href="/member/changePw.do">비밀번호 변경</a></li>
				<li><a href="/member/withdrawals.do">회원탈퇴</a></li>
			</ul>
		</div>
	</div>
	<div class="col-md-6">
		<div class="card-xl card-2">
			<h2>내 정보 보기</h2>
			<form action="update.do" method="post">
				<div class="form-group items-lg">
					<input type="hidden" name="id" value="${vo.id }" class="form-control input-lg">
					<label for="name">이름:</label>
					<input type="text" name="name" id="name" class="form-control input-lg" required readonly
					value="${vo.name }">
				</div>
				<div class="form-group items-lg">
					<label for="nickname">닉네임:</label>
					<input type="text" name="nickname" id="nickname" class="form-control input-lg" required readonly
					value="${vo.nickname }" onkeyup="checkNicknameFunc();">
				</div>
				<div class="form-group">
					<div id="checkNickname"></div>
				</div>
				
				<div class="form-group items-lg">
					<label for="birth">생년월일:</label>
					<input type="date" name="birth" id="birth" class="form-control input-lg" readonly
					value="<fmt:formatDate value="${vo.birth }" pattern="yyyy-MM-dd" />">
				</div>
				
				<div class="form-group items-lg">
					<label for="tel">전화번호:</label>
					<input type="text" name="tel" id="tel" class="form-control input-lg" required readonly
					value="${vo.tel }" maxlength="13">
				</div>
				<div class="form-group">
					<div id="checkTel"></div>
				</div>
				
				<div class="form-group items-lg">
					<label for="email">이메일:</label>
					<input type="text" name="email" id="email" class="form-control input-lg" required readonly
					value="${vo.email }" onkeyup="checkEmailFunc();">
				</div>
				<div class="form-group">
					<div id="checkEmail"></div>
				</div>
				
				<div class="form-group items-lg">
					<label for="reg_date">계정생성일:</label>
					<input type="text" name="reg_date" id="reg_date" class="form-control input-lg" required readonly
					value='<fmt:formatDate value="${vo.reg_date }" pattern="yyyy-MM-dd (E)" />'>
				</div>
				<div class="form-group items-lg">
					<label for="con_date">최근접속일:</label>
					<input type="text" name="con_date" id="con_date" class="form-control input-lg" required readonly
					value='<fmt:formatDate value="${vo.con_date }" pattern="yyyy-MM-dd (E)" />'>
				</div>
				<div class="form-group items-lg">
					<label for="grade_name">등급:</label>
					<input type="text" name="grade_name" id="grade_name" class="form-control input-lg" required readonly
					value="${vo.grade_name }">
				</div>
				<center>
					<div style="margin-bottom: 30px;">
						<button type="button" id="updateBtn" class="button__item login-button__item--black">정보변경</button>
						<button type="submit" id="submitBtn" class="button__item login-button__item--black">확인</button>
						<button type="button" id="cancelBtn" class="button__item login-button__item--black">취소</button>
					</div>
				</center>
			</form>
		</div>
	</div>
	<div class="col-md-3">
	</div>
</body>
</html>