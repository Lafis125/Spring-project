<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 수정</title>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<script type="text/javascript">
$(function(){
	$("#startDate, #endDate").datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: "yy-mm-dd",
        dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
        monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월",
           "7월", "8월", "9월", "10월", "11월", "12월"],
        yearRange: "1923:2099"
  });
	  
  $("#startDate").datepicker("option", {
     // 오늘 날짜 이후로만 선택 가능
     "minDate" : new Date(),
     // 날짜를 선택하면 종료일을 시작일 이전을 선택할 수 없다.
     // onClose -> 날짜를 선택해서 날짜 달력이 닫혔다.
     onClose : function(selectedDate) {
        $("#endDate").datepicker("option", "minDate", selectedDate);
     }
  });
  
  $("#endDate").datepicker("option", {
     // 오늘 날짜 이후로만 선택 가능
     "minDate" : new Date(),
     // 날짜를 선택하면 시작일을 종료일 이후를 선택할 수 없다.
     // onClose -> 날짜를 선택해서 날짜 달력이 닫혔다.
     onClose : function(selectedDate) {
        $("#startDate").datepicker("option", "maxDate", selectedDate);
     }
  });

	  // 상세 이미지 삭제 버튼 클릭 시
 	  $('.delete-detail').click(function () {
 	      let imageNo = $(this).data('image_no');
 	      let deleteFile = $('.imgDiv img[data-pr="0"]').attr('src');
 	      let imageDiv = $(this).closest('.imgDiv'); // 해당 이미지의 부모 요소를 선택

 	      alert(imageNo);
 	      alert(deleteFile);
	      // 이미지를 화면에서 제거
 	      imageDiv.remove();
 	      $("#delFile").val(delFile);
 	      $("#image_no").val(imageNo);
	      $('#detail-label').remove();
 	  });
	  
	  
	  

		// 대표 이미지 업로드 필드 처리
		  $('#preImageUpload').on('change', function() {
		      let fileInput = this;
		      let previewImage = $('#preImagePreview')[0];

		      if (fileInput.files && fileInput.files[0]) {
		          let reader = new FileReader();

		          reader.onload = function(e) {
		              // 새 이미지로 업데이트
		              $(previewImage).attr('src', e.target.result);
		              $(previewImage).show();

		          	  // 기존 메인 이미지의 image-no 가져오기
		              let preImg_no = $('.imgDiv img[data-pr="1"]').data('image_no');
		              
		              // 기존 메인 이미지의 file-name 가져오기
		              let delPreFile = $('.imgDiv img[data-pr="1"]').attr('src');
		              
		              // 이미지 업로드 시 기존 이미지를 화면에서 지우기
		              //$('.imgDiv img[data-pr="1"]').remove();
		              $("#mainImageDiv").remove();

		           	  // 새로운 이미지 업로드 시 기존 이미지의 정보 담기 
		              $("#preImg_no").val(preImg_no);
		              $("#delPreFile").val(delPreFile);
		          };

		          reader.readAsDataURL(fileInput.files[0]);
		      }
		  });

		  // 상세 이미지 업로드 필드 처리 (추가 이미지 )
		  $('#detailImageUpload').on('change', function() {
		      let fileInput = this;
		      let previewImage = $('#detailImagePreview')[0];

		      if (fileInput.files && fileInput.files[0]) {
		          let reader = new FileReader();

		          reader.onload = function(e) {
		              // 새 이미지로 업데이트
		              $(previewImage).attr('src', e.target.result);
		              $(previewImage).show();

		           	  // 기존 이미지의 image-no 가져오기
		              let detailImageNo = $('.imgDiv img[data-pr="0"]').data('image_no');
		              // 기존 이미지의 file_name 가져오기
		              let delFile = $('.imgDiv img[data-pr="0"]').attr('src');		     
		              // 이미지 업로드 시 기존 이미지를 화면에서 지우기
		              $("#detailImageDiv").remove();

		              $("#image_no").val(detailImageNo);
		              if(delFile != null){
		              	$("#delFile").val(delFile);
		              	//alert("defile not null");
		              }else{
			            $("#delFile").val(null);
			            //alert("defile null");
			          }
		          };

		          reader.readAsDataURL(fileInput.files[0]);
		      }
		  });
    });
</script>
</head>
<body>
	<div class="container">
		<h2>이벤트 수정</h2>
		<form action="update.do" method="post" id="updateForm" enctype="multipart/form-data">
			<input type="hidden" name="page" value="${param.page}"> <input
				type="hidden" name="perPageNum" value="${param.perPageNum}">
			<input type="hidden" name="key" value="${param.key}"> <input
				type="hidden" name="word" value="${param.word}">

			<div class="form-group">
				<label for="no">번호:</label> <input id="no" name="no"
					class="form-control" readonly value="${vo.no}">
			</div>

			<div class="form-group">
				<label for="title">제목:</label> <input id="title" name="title"
					required class="form-control" value="${vo.title}">
			</div>

			<div class="form-group">
				<label for="content">내용:</label>
				<textarea id="content" name="content" rows="5" required
					class="form-control">${vo.content}</textarea>
			</div>

	        <div class="form-group">
	            <label for="preImageUpload">대표 이미지 수정 업로드</label>
	            <input id="preImageUpload" name="changePreImg" class="form-control" type="file">
	            <img id="preImagePreview" src="#" alt="대표 이미지 미리보기" style="max-width: 30%; display: none;">
		        <input type="hidden" name="preImg_no" id="preImg_no">
		        <input type="hidden" name="delPreFile" id="delPreFile">
	        </div>
	        
	        
	        <div class="form-group">
	            <label for="detailImageUpload">상세 이미지 수정 업로드</label>
	            <input id="detailImageUpload" name="changeDetailImg" class="form-control" type="file">
	            <img id="detailImagePreview" src="#" alt="추가 이미지 1 미리보기" style="max-width: 30%; display: none;">
	            <input type="hidden" name="image_no" id="image_no">
		        <input type="hidden" name="delFile" id="delFile">
	        </div>

			<div class="form-group">
				<label>이벤트 시작일</label> 
				<input name="start_date" class="form-control" 
				id="startDate" value="<fmt:formatDate value="${vo.start_date }" pattern="yyyy-MM-dd"/>" />
			</div>

			<div class="form-group">
				<label>이벤트 종료일</label> <input name="end_date" class="form-control"
				id="endDate" value="<fmt:formatDate value="${vo.end_date }" pattern="yyyy-MM-dd"/>" />
			</div>
					
		<div class="form-group" id="mainImageDiv">
			<label>대표 이미지(삭제 불가):</label>
			<c:forEach items="${imageList}" var="imageVO">
				<c:if test="${imageVO.pr == 1}">
					<div class="imgDiv img-thumbnail"
						style="padding: 10px 3px 3px 3px;">
						<img alt="${imageVO.file_name}" src="${imageVO.file_name}"
							data-pr="1" style="width: 30%;"
							data-image_no="${imageVO.image_no}">
					</div>
					<input type="hidden" name="prefileName" value="${imageVO.file_name }" >
				</c:if>
			</c:forEach>
		</div>
		
		<div class="form-group" id="detailImageDiv">
			<label>상세 이미지:</label>
			<c:forEach items="${imageList}" var="imageVO2">
				<c:if test="${imageVO2.pr == 0}">
					<div class="imgDiv img-detail"
						style="padding: 10px 3px 3px 3px;">
						<img alt="${imageVO2.file_name}" src="${imageVO2.file_name}"
							data-pr="0" style="width: 30%;"
							data-image_no="${imageVO2.image_no}" data-file_name="${imageVO2.file_name}">
							<button class="delete-detail" data-image_no="${imageVO2.image_no}">X</button>
					</div>
					 <input type="hidden" name="imageName" value="${imageVO2.file_name }" >
				</c:if>
			</c:forEach>
		</div>
			<button class="btn btn-default">수정</button>
		</form>
	</div>
</body>
</html>