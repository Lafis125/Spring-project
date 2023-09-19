<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 마이페이지</title>
<link rel="stylesheet" href="/resources/css/member.css">
<style type="text/css">
ul > li {
	margin: 5px 0px;
	padding: 2px;
}
</style>
<script type="text/javascript">
$(function(){
	$("#company_bank").val("${vo.company_bank}").attr("selected","selected");
});
</script>
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
			<form action="/member/seller/update.do" method="post">
				<div class="form-group items-lg">
					<input type="hidden" name="id" value="${vo.id }">
					<label for="company_no">사업자 번호:</label>
					<input type="text" name="company_no" id="company_no" class="form-control input-lg" required
					value="${vo.company_no }" placeholder="사업자 번호를 입력해주세요">
				</div>
				<div class="form-group items-lg">
					<label for="company_name">사업장 이름:</label>
					<input type="text" name="company_name" id="company_name" class="form-control input-lg" required
					value="${vo.company_name }" placeholder="사업장 이름을 입력해주세요">
				</div>
				<div class="form-group items-lg">
					<label for="company_tel">사업장 전화번호:</label>
					<input type="text" name="company_tel" id="company_tel" class="form-control input-lg" required
					value="${vo.company_tel }" placeholder="사업장 전화번호를 입력해주세요">
				</div>
				<div class="form-group items-lg">
					<label for="company_addr">사업장 주소:</label>
					<input type="text" name="company_addr" id="company_addr" class="form-control input-lg" required
					value="${vo.company_addr }" placeholder="사업장 주소를 입력해주세요">
				</div>
				<div class="form-group items-lg">
					<label for="company_detail_addr">상세주소:</label>
					<input type="text" name="company_detail_addr" id="company_detail_addr" class="form-control input-lg" required
					value="${vo.company_detail_addr }" placeholder="상세주소를 입력해주세요">
				</div>
				<div class="form-inline items-lg">
					<div class="form-group">
						<select name="company_bank" class="form-control input-lg" id="company_bank">
							<option value="국민은행">국민은행</option>
							<option value="신한은행">신한은행</option>
							<option value="기업은행">기업은행</option>
							<option value="농협">농협</option>
							<option value="카카오뱅크">카카오뱅크</option>
						</select>
					</div>
					<div class="form-group">
						<input type="text" name="company_account" required class="form-control input-lg"
							placeholder="정산받을 계좌번호를 입력해주세요" value="${vo.company_account }">
					</div>
				</div>
				<center>
					<div style="margin-bottom: 30px;">
						<button type="submit" class="button__item login-button__item--black">수정</button>
						<a href="/member/seller/withdrawals.do" style="float: right;">판매자 취소</a>
					</div>
				</center>
			</form>
		</div>
	</div>
	<div class="col-md-3"></div>
</body>
</html>