<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script src="/resources/js/jquery-3.6.4.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<style type="text/css">
.glyphicon-heart-empty, .glyphicon-heart {
	font-size: 22px;
	line-height: 22px;
	color: red;
}

#likeBtn, #disLikeBtn {
	border: 0;
	background-color: white;
}

#data {
	padding: 20px; /* 데이터 부분의 안팎 여백 설정 */
	background-color: #f9f9f9; /* 데이터 부분의 배경색 설정 */
	border-radius: 10px; /* 데이터 부분의 모서리 둥글기 설정 */
	margin-bottom: 20px; /* 하단 여백 추가 */
}

.main-img {
	width: 100%;
	height: 100vh; /* 화면 높이의 100% */
	object-fit: cover;
	position: absolute;
	top: 0;
	left: 0;
}

.data-content{
	font-size: 20px;
	margin-top: 10px;
}

.data-nick{
	font-weight: 700;
    color: #2f3438;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    font-size: 17px;
}

.data-writeDate{
	color: #656e75;
}

.hearder-auth{
	font-size: 16px;
    padding-left: 10px;
    line-height: 27px;
}

.data-title{
	font-weight: 700;
	color: #2f3438;
	line-height: 42px;
	text-align: center;
}
</style>
<script type="text/javascript">
$(function(){
	$("#deleteBtn").click(function(){
		if(!confirm("정말 삭제하시겠습니까?")) return false;
	});
	
	let chkRed = ${chkRecommend};
	let no = parseInt("${vo.no}", 10);
	let loginChk = ${!empty login};
	
    //로그인 되어있지않을경우
    if(${empty login}){
    	$("#likeBtn").show();
        $("#disLikeBtn").hide();
        $("#emptyHeart").show();
        $("#heart").hide();
    }
    
    // 로그인이 되어있고 chkRecommend 0
    if(${!empty login} && chkRed == 0 ){
    	$("#likeBtn").show();
        $("#disLikeBtn").hide();
        $("#emptyHeart").show();
        $("#heart").hide();
        
    }
    // 로그인이 되어있고 chkRecommend 1
    if(${!empty login} && chkRed == 1){
    	$("#likeBtn").hide();
        $("#disLikeBtn").show();
        $("#emptyHeart").hide();
        $("#heart").show();
    }
    
    function recommendCount() {
        $.ajax({
            url: "/communityAjax/recommendCnt.do",
            data: { no: no },
            success: function (data) {
                if (data == "") {
                    $("#likeCount").text('0');
                } else {
                    $("#likeCount").text(data);
                }
            },
            error: function () {
                alert("좋아요 수 업데이트 실패");
            }
        });
    } 

    // 좋아요 버튼 클릭 이벤트 핸들러
    $("#likeBtn").click(function () {
        if(!loginChk){
            alert("로그인을 하셔야 좋아요가 가능합니다.");
            return false;
        }
            
        $.ajax({
            url: "/communityAjax/like.do",
            data: { no: no },
            success: function (result) {    
                if (result == "1") {
                    $("#likeBtn, #emptyHeart").hide();
                    $("#disLikeBtn, #heart").show();
                    recommendCount();
                } else {
                    alert("좋아요 실패");
                }
            },
            error: function () {
                alert("좋아요 실패");
            }
        });
    });

    // 취소 버튼 클릭 이벤트 핸들러
    $("#disLikeBtn").click(function () {
        $.ajax({
            url: "/communityAjax/disLike.do",
            data: { no: no },
            success: function (result) {
                if (result == "1") {
                    $("#disLikeBtn, #heart").hide();
                    $("#likeBtn, #emptyHeart").show();
                    recommendCount();
                } else {
                    alert("좋아요 취소 실패");
                }
            },
            error: function () {
                alert("좋아요 실패");
            }
        });
    });
});
</script>
</head>
<body>
	<div class="container">
		<div id="com-data">
			<div class="hearder" style="margin-bottom: 35px;">
				<div>
					<h1 class="data-title">${vo.title }</h1>
				</div>
			</div>
			<div class="hearder-auth">
				<div class="data-writer">
				    <div style="display: flex; align-items: center;">
				        <span class="glyphicon glyphicon-user" style="font-size: 13px; color: #828282;"></span>
				        <div class="data-nick" style="margin-left:5px;">${vo.nickname }</div>
				    </div>
				</div>
				<div class="data-writeDate">
					<div style="display: flex; align-items: center;">
						<span class="glyphicon glyphicon-calendar" style="font-size: 13px; color: #828282;"></span>
						<span style="margin-left:5px;"><fmt:formatDate value="${vo.write_date }"
								pattern="yy-MM-dd" /></span>
					</div>
				</div>
			</div>
			
			<div class="data-img-content">
				<c:forEach items="${imageList }" var="imageVO">
					<c:if test="${imageVO.pr == 0}">
						<div class="imgDiv img-thumbnail"
							style="padding: 10px 3px 3px 3px;">
							<img alt="${imageVO.file_name }" src="${imageVO.file_name }"
								data-pr="${imageVO.pr }" style="width: 100%;"
								data-image_no="${imageVO.image_no }">
						</div>
					</c:if>
				</c:forEach>
			</div>
			
			<div class="data-content">${vo.content }</div>
		</div>
       <div style="margin-top: 15px; text-align: center;">
            <div class="text-left">
                <a href="list.do?page=${param.page }&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}" class="btn btn-default">리스트</a>
                <c:if test="${vo.id == login.id}">
                    <a href="update.do?no=${vo.no }&page=${param.page }&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}" class="btn btn-default">수정</a>
                </c:if>
                  <c:if test="${vo.id == login.id || login.grade_no >=8 }">
                    <a href="delete.do?no=${vo.no}&perPageNum=${param.perPageNum}" class="btn btn-default" id="deleteBtn">삭제</a>
                  </c:if>
            </div>
  				
  				<div style="display: inline-block; margin-left: 10px;">
				    <div id="likeBtnContainer">
				       <span style="font-weight: 700">좋아요</span>
				        <button id="likeBtn" data-toggle="tool-tip" title="좋아요">
				            <img src="/upload/image/empty-heart.png" alt="비어진 하트" id="emptyHeart" width="30px;">
				        </button>
				        <button id="disLikeBtn" title="취소">
				            <img src="/upload/image/heart.png" alt="채워진 하트" id="heart" width="30px;">
				        </button>
				    </div>
				</div>
				
				<c:if test="${cntRecommend == null }">
				    <span id="likeCount">0</span>
				</c:if>
				<span id="likeCount">${cntRecommend}</span>
                
                <div class="data-hit" style="display: inline-block; margin-left: 10px;"><span style="font-weight: 700"> 조회수 </span>${vo.hit }</div>
            </div>
	<%@ include file="../communityReply/communityReplyList.jsp"%>
</div>
</body>
</html>