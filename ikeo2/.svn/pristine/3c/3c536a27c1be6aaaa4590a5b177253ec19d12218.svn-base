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
    $("#preImageFile").change(function () {
        readURL(this, "#preview");
    });

    // 상세 이미지 파일 업로드 필드 변경 이벤트 처리
    $("#imageFile").change(function () {
        readURL(this, "#previewImage");
    });

    // 파일을 읽어서 미리보기 이미지에 표시하는 함수
    function readURL(input, previewId) {
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

    $('#word').keyup(function () {
        let searchTerm = $(this).val();
        
        if (searchTerm.length >= 1) {
            // AJAX 요청으로 검색 결과 가져오기
            $.ajax({
                type: 'GET',
                url: '/communityAjax/itemSearch.do', // 서버의 상품 검색 엔드포인트
                data: { word: searchTerm },
                success: function (data) {
                    console.log(data);
                    let searchResults = $('#searchResults');
                    searchResults.empty();

                    if (data.length > 0) {
                        // 동적으로 테이블 생성
                        let table = $('<table class="table table-bordered"></table>');
                        let thead = $('<thead><tr><th></th><th>상품명</th><th>가격</th></tr></thead>');
                        let tbody = $('<tbody></tbody>');

                        $.each(data, function (index, item) {
                            let row = $('<tr></tr>');
                            let imgCell = $('<td></td>');
                            let img = $('<img>').attr('src', item.item_thum).attr('alt', item.item_title).addClass('thumbnail');
                            row.append(imgCell);
                            row.append('<td>' + item.item_title + '</td>');
                            row.append('<td>' + item.item_price + '</td>');
                            imgCell.append(img);
                            tbody.append(row);
                        });

                        table.append(thead);
                        table.append(tbody);

                        // 생성된 테이블을 결과 컨테이너에 추가
                        searchResults.append(table);
                        searchResults.show();
                        
                    } else {
                        searchResults.hide();
                    }
                }
            });
        } else {
            $('#searchResults').hide();
        }
    });
});
</script>
<style type="text/css">
    .thumbnail {
        max-width: 100px;
        max-height: 100px; 
    }
    
    .selected {
    background-color: #f2f2f2;
    }
</style>
</head>
<body>
    <div class="container">
        <h2>커뮤니티 게시판 글등록</h2>
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
                <label for="preImageFile">대표 이미지</label> 
                <input id="preImageFile" name="preImageFile" required class="form-control" type="file">
                <img id="preview" src="#" alt="preview" style="max-width: 200px; display: none;">
            </div>
            
            <div class="form-group">
                <label for="preImageFile">상세 이미지</label> 
                <input id="imageFile" name="imageFile" class="form-control" type="file">
                <img id="previewImage" src="#" alt="preview2" style="max-width: 200px; display: none;">
            </div>
    		<div id="searchDiv" class="form-grop">
        		<div class="input-group">
            		<label for="word">태그 할 상품검색</label>
            		<input type="text" class="form-control" placeholder="Search" id="word" name="word">
       		 </div>
	        <div id="searchResults" class="dropdown">
	        </div>
    		</div>
    		<button class="btn btn-info btn-lg center-block">등록</button>
         </form>
    </div>
</body>
</html>