<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<script type="text/javascript">
$(function(){
	$(".replyUpdateBtn").click(function(){
		// alert("댓글 수정버튼 클릭");
		// 데이터 수집 - 모달창에 세팅할 데이터 : rno, content
		let dataRow = $(this).closest(".dataRow");
		let rno = dataRow.find(".rno").text();
		let content = dataRow.find(".content").text();
		// alert("댓글 번호 : " + rno);
		// alert("댓글 내용 : " + content);
		$("#modalRno").val(rno);
		$("#modalContent").val(content);
	});
	$(".replyDeleteBtn").click(function(){
		// alert("댓글 삭제");
		let rno = $(this).closest(".dataRow").find(".rno").text();
		let no = $("#no").val();
		// alert(no);
		// alert("댓글 번호 : " + rno);
		if(!confirm("삭제하시겠습니까?")) return false;
		location = "/qnareply/delete.do?rno=" + rno + "&no=" + no;
		
	});
});
</script>
<div class="container" id="replyDiv">
	<h3>Answer</h3>
	<c:if test="${!empty login}">
		<div class="well" style="background: #dcdcdc;">
			<form action="/qnareply/write.do" method="post">
				<input type="hidden" name="no" value="${vo.no }" id="no">
				<input type="hidden" name="query" value="<%= request.getQueryString() %>">
				<div class="form-group">
					<textarea rows="3" name="content" class="form-control" required></textarea>
				</div>
				<c:if test="${!empty login && login.grade_no == 9 }">
					<button class="btn btn-defualt">답변 등록</button>
				</c:if>
			</form>
		</div>
	</c:if>
	<c:if test="${empty replyPageObject  }">
		<div class="well">
				답변이 존재하지 않습니다.
		</div>
	</c:if>
	<c:if test="${not empty replyPageObject}">
		<c:forEach items="${replyPageObject }" var="QnaReplyVO">
			<div class="panel panel-default dataRow">
				<div class="panel-heading">
					답변 번호 : <span class="rno">${QnaReplyVO.rno }</span>
					<span class="pull-right">${QnaReplyVO.writeDate }</span>
				</div>
				<div class="panel-body content">${QnaReplyVO.content }</div>
				<div class="panel-footer">
					${QnaReplyVO.name }(${QnaReplyVO.id })
					<c:if test="${!empty login && QnaReplyVO.id == login.id && login.grade_no == 9}">
						<span class="pull-right">
							<button type="button" class="btn btn-info btn-xs replyUpdateBtn" data-toggle="modal" data-target="#updateModal">수정</button>
							<button type="button" class="btn btn-info btn-xs replyDeleteBtn">삭제</button>
					</span>
					</c:if>
				</div>
			</div>
		</c:forEach>
	</c:if>
</div>

<c:if test="${!empty login && login.grade_no == 9}">
<!-- Modal -->
<div id="updateModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
    	<form action="/qnareply/update.do" method="post">
    	
    		<input type="hidden"  name="no" value="${vo.no }">
    		<input type="hidden" name="query" value="<%= request.getQueryString() %>">
    		<input type="hidden" name="rno" id="modalRno">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">답변 수정 폼</h4>
	      </div>
	      <div class="modal-body">
	        <textarea rows="3" name="content" class="form-control" id="modalContent">test</textarea>
	      </div>
	      <div class="modal-footer">
	      	<button class="btn btn-default">수정</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
     	</form>
    </div>
  </div>
</div>
</c:if>
