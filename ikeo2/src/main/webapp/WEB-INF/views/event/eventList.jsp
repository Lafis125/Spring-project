<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Event</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">ㅈ
     .dataRow:hover {
        cursor: pointer;
    }

    .imgDiv {
        overflow: hidden;
    }

    .title {
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
    }
    
    .thumbnail-hover {
        transform: scale(1.05); /* 이미지 확대 */
        transition: transform 0.3s ease; /* 애니메이션 지속 시간 및 이징 함수 설정 */
    }
    
    .search-container {
        margin-bottom: 20px;
    }

    .search-container select {
        width: auto;
        margin-left: 10px;
    }

    .write-button {
        margin-top: 20px;
    }
    
    .event-title{
    	margin: 18px 0 8px;
	    line-height: 24px;
	    font-size: 17px;
	    font-weight: 700;
	    color: #424242;
	    text-align: center;
	    word-break: keep-all;
	    word-wrap: break-word;
    }
</style>

<script type="text/javascript">
    $(function () {
        resize();
        $(window).resize(function () {
            resize();
        });

        $("#key").val("${(empty pageObject.key)?"t":pageObject.key}");
        $("#perPageNum").val("${pageObject.perPageNum}");

        $(".dataRow").click(function () {
            let no = $(this).data("no");
            location = "view.do?no=" + no + "&${pageObject.pageQuery}";
        });

        $("#perPageNum").change(function () {
            location = "list.do?page=1&perPageNum=" + $("#perPageNum").val()
                + "&key=${pageObject.key}&word=${pageObject.word}";
        });

        $(".dataRow").mouseenter(function () {
            $(this).find(".thumbnail").addClass("thumbnail-hover"); 
        }).mouseleave(function () {
            $(this).find(".thumbnail").removeClass("thumbnail-hover"); 
        });
        

        $("#showInProgressEvent").click(function(){
            $(".dataRow").hide();
            $(".progressEvent").show();
   	 	});
   	 	
        $("#showEndedEvent").click(function(){
            
            $(".dataRow").hide();
            $(".endEvent").show();
    	}); 

        $("#showAllEvent").click(function(){
            $(".dataRow").show();
    	});
    });

    function resize() {
        let width = $(".dataRow .imgDiv:first").width();
        let height = width / 3 * 2.4;
        $(".dataRow .imgDiv").height(height + "px");
    }
</script>
</head>
<body>
<div class="container">
	<div class="text-center" style="border-bottom: 1px solid #828282; margin-bottom: 30px;">
    	<h2>Event</h2>
    </div>
    
    <div class="text-center">
	    <div class="btn-group" style="margin-bottom: 30px">
	        <button type="button" class="btn btn-info btn-lg" id="showAllEvent">전체 이벤트</button>
	        <button type="button" class="btn btn-info btn-lg" id="showInProgressEvent">진행중인 이벤트</button>
	        <button type="button" class="btn btn-info btn-lg" id="showEndedEvent">종료된 이벤트</button>
	    </div>
	</div>
    <!-- 게시판의 검색 : 제목, 내용, 작성자, 그외 복합 -->
    <div style="margin-bottom: 10px" class="row">
        <div id="searchDiv">
            <form action="list.do" class="form-inline">
                <input name="page" value="1" type="hidden"/>
                <div class="form-group" style="margin-left: 15px;">
                    <select class="form-control" id="key" name="key">
                        <option value="t" >제목</option>
                        <option value="c" >내용</option>
                        <option value="tc" >전체</option>
                    </select>
                </div>
                <div class="input-group ">
                    <input type="text" class="form-control" placeholder="Search"
                        name="word" value="${pageObject.word }">
                    <div class="input-group-btn">
                        <button class="btn btn-info" type="submit">
                            <i class="glyphicon glyphicon-search"></i>
                        </button>
                    </div>
                </div>
                <div class="input-group pull-right" style="margin-right: 15px;">
                    <span class="input-group-addon" style="background-color:#5bc0de; color:white;">Rows/Page</span>
                    <select class="form-control" id="perPageNum" name="perPageNum">
                        <option>8</option>
                        <option>12</option>
                        <option>16</option>
                        <option>20</option>
                    </select>
                </div>
            </form>
        </div>
    </div>

<div class="row" id="eventList">
    <c:forEach items="${list}" var="vo" varStatus="vs">
        <c:if test="vs.index > 0 && vs.index % 2 == 0">
            <c:out value="</div>"/>
            <c:out value="<div class='row'/>"/>
        </c:if>

        <c:set var="currentDate" value="<%=new java.util.Date() %>" />
        <c:choose>
            <c:when test="${vo.end_date >= currentDate}">
                <!-- 진행중인 이벤트를 출력하는 부분 -->
                <c:set var="eventClass" value="progressEvent"/>
            </c:when>
            <c:otherwise>
                <!-- 종료된 이벤트를 출력하는 부분 -->
                <c:set var="eventClass" value="endEvent"/>
            </c:otherwise>
        </c:choose>

        <div class="col-sm-6 dataRow ${eventClass}" data-no="${vo.no}">
            <div class="thumbnail">
                <div class="imgDiv" style="width:100%">
                    <img alt="${vo.file_name }" src="${vo.file_name}" style="width:100%">
                </div>
                <div class="caption">
                    <div style="border-top: 1px dotted #aaa;">
                        <div style="font-weight: 700; font-size: 15px;">
                            <c:choose>
                                <c:when test="${vo.end_date >= currentDate}">
                                    <span style="color: #35c5f0" class="pull-right">진행중</span><br>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #bdbdbd" class="pull-right">종료</span><br>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <span class="pull-right"><fmt:formatDate value="${vo.start_date }" pattern="yyyy/MM/dd" />~<fmt:formatDate value="${vo.end_date }" pattern="yyyy/MM/dd" /> </span>
                    </div>
                     <div class="titleDiv">
            			<span class="event-title">${vo.title }</span>
           			 </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
    <c:if test="${!empty login && login.grade_no >= 8 }">
    	<a href="write.do?perPageNum=${pageObject.perPageNum }" class="btn btn-info pull-right">글쓰기</a>
    </c:if>
	<div class="text-center">
        <pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>
    </div>
</div>
</body>
</html>