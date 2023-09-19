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
<title>Community</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
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
    
    .thum:hover {
        transform: scale(1.05); 
        transition: transform 0.3s ease; 
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
    
    .communiy_title{
        margin: 18px 0 8px;
	    line-height: 24px;
	    font-size: 17px;
	    font-weight: 700;
	    color: #424242;
	    text-align: center;
	    word-break: keep-all;
	    word-wrap: break-word;
    }
    
    #listData{
    	margin-bottom: 25px; 
    }
    
    #imgData{
    	border-radius: 5px;
        max-width: 100%;
        height: auto;
    }
    
    .com-writer{
	    position: relative;
	    margin: 8px 0;
	    font-size: 15px;
	    font-weight: 400;
	    color: #757575;
	    line-height: 16px;
	    z-index: 2;
    }
    
    .glyphicon-user{
    	font-size: 15px;
    }
    
    .com-hit{
	    color: #757575;
	    font-size: 13px;
	    line-height: 17px;
	    text-align: center;
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
            location = "view.do?no=" + no + "&inc=1" + "&${pageObject.pageQuery}";
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
	<div class="text-center" id="com-title"style="border-bottom: 1px solid #828282; margin-bottom: 30px;">
    	<h2>Community</h2>
    </div>
    <div style="margin-bottom: 20px" class="row">
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
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search"
                        name="word" value="${pageObject.word }">
                    <div class="input-group-btn">
                        <button class="btn btn-info" type="submit">
                            <span class="glyphicon glyphicon-search"></span> Search
                        </button>
                    </div>
                </div>
                <div class="input-group pull-right" style="margin-right: 15px;">
                    <span class="input-group-addon" style="background-color: #5bc0de; color: white;">Rows/Page</span>
                    <select class="form-control" id="perPageNum" name="perPageNum">
                        <option>9</option>
                        <option>18</option>
                        <option>27</option>
                        <option>36</option>
                    </select>
                </div>
            </form>
        </div>
    </div>

<div class="row" id="eventList">
    <c:forEach items="${list}" var="vo" varStatus="vs">
        <c:if test="vs.index > 0 && vs.index % 3 == 0">
            <c:out value="</div>"/>
            <c:out value="<div class='row'/>"/>
        </c:if>
        <div class="col-md-4 dataRow" data-no="${vo.no}" id="listData">
            <div class="thum">
                <div class="imgDiv" style="width: 100%; border-radius: 10px;">
                    <img alt="${vo.file_name}" src="${vo.file_name}" style="width: 100%; max-height: 365.55px;" id="imgData">
                </div>
            </div>
            <div class="caption">
                <div class="titleDiv">
                    <h1 class="communiy_title">${vo.title}</h1>
                </div>
            </div>
            <div class="caption">
               <div class="infoDiv">
              	<!-- <span class="glyphicon glyphicon-pencil"></span> --> <span class="com-writer">${vo.nickname}</span>
                <span class="pull-right com-hit">조회 ${vo.hit}</span>
               </div>
            </div>
        </div>
    </c:forEach>
</div>
    <c:if test="${!empty login}">
        <div>
            <a href="write.do?perPageNum=${pageObject.perPageNum }" class="btn btn-info pull-right">글쓰기</a>
        </div>
    </c:if>
     <div class="text-center">
        <pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>
    </div>
</div>
</body>
</html>