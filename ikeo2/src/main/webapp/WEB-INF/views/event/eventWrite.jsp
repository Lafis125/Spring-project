<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 등록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
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

	  	$("#preImageFile").change(function () {
		  	//alert("메인");
	        readURL(this, "#preview");
	    });

	    // 상세 이미지 파일 업로드 필드 변경 이벤트 처리
	    $("#imageFile").change(function () {
	    	//alert("서브");
	        readURL(this, "#previewImage");
	    });

	    // 파일을 읽어서 미리보기 이미지에 표시하는 함수
	    function readURL(input, previewId) {
		    //alert(readURL);
	        if (input.files && input.files[0]) {
	            let reader = new FileReader();

	            reader.onload = function (e) {
	                $(previewId).attr("src", e.target.result);
	                $(previewId).show(); // 이미지를 표시
	            }

	            reader.readAsDataURL(input.files[0]);
	        } else {
	            $(previewId).attr("src", ""); // 이미지를 초기화
	            $(previewId).hide(); // 이미지를 숨김
	        }
	    }
});
</script>
</head>
<body>
	<div class="container">
		<h2>이벤트 게시판 등록</h2>
		<form action="write.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="perPageNum" value="${param.perPageNum }">
			<div class="form-group">
				<label for="title">제목</label> <input id="title" name="title"
					required class="form-control">
			</div>

			<div class="form-group">
				<label for="content">내용</label>
				<textarea id="content" name="content" rows="5" class="form-control"></textarea>
			</div>
			
			<div class="form-group">
			<label>이벤트 시작일</label>
			<input name="start_date" class="form-control" id="startDate" autocomplete="off">
			</div>
			
			<div class="form-group">
				<label>이벤트 종료일</label>
				<input name="end_date" class="form-control" id="endDate" autocomplete="off"> 
			</div>
			
			<div class="form-group">
				<label for="preImageFile">대표 이미지</label> 
				<input id="preImageFile" name="preImageFile" required class="form-control" type="file">
				<img id="preview" src="#" alt="preview" style="max-width: 200px; display: none;">
			</div>
			
			<div class="form-group">
				<label for="preImageFile">상세 이미지</label> 
				<input id="imageFile" name="imageFile" class="form-control" type="file">
				<img id="previewImage" src="#" alt="preview2" style="max-width: 200px; display: none;">
			</div>
			
			<button class="btn btn-info">등록</button>
		</form>
	</div>
</body>
</html>