<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.item{overflow: auto;  
  width: 550px;
  height: 500px;
  margin: 5px;
  float: left;}
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
        }
    }).open();
</script>

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById("phone").addEventListener("keyup", function(event) {
            inputPhoneNumber(event.target);
        });
    });
    
    function inputPhoneNumber( phone ) {
        if( event.keyCode != 8 ) {
            const regExp = new RegExp( /^[0-9]{2,3}-^[0-9]{3,4}-^[0-9]{4}/g );
            if( phone.value.replace( regExp, "").length != 0 ) {                
                if( checkPhoneNumber( phone.value ) == true ) {
                    let number = phone.value.replace( /[^0-9]/g, "" );
                    let tel = "";
                    let seoul = 0;
                    if( number.substring( 0, 2 ).indexOf( "02" ) == 0 ) {
                        seoul = 1;
                        phone.setAttribute("maxlength", "12");
                        console.log( phone );
                    } else {
                        phone.setAttribute("maxlength", "13");
                    }
                    if( number.length < ( 4 - seoul) ) {
                        return number;
                    } else if( number.length < ( 7 - seoul ) ) {
                        tel += number.substr( 0, (3 - seoul ) );
                        tel += "-";
                        tel += number.substr( 3 - seoul );
                    } else if(number.length < ( 11 - seoul ) ) {
                        tel += number.substr( 0, ( 3 - seoul ) );
                        tel += "-";
                        tel += number.substr( ( 3 - seoul ), 3 );
                        tel += "-";
                        tel += number.substr( 6 - seoul );
                    } else {
                        tel += number.substr( 0, ( 3 - seoul ) );
                        tel += "-";
                        tel += number.substr( ( 3 - seoul), 4 );
                        tel += "-";
                        tel += number.substr( 7 - seoul );
                    }
                    phone.value = tel;
                } else {
                    const regExp = new RegExp( /[^0-9|^-]*$/ );
                    phone.value = phone.value.replace(regExp, "");
                }
            }
        }
    }

    function checkPhoneNumber( number ) {
        const regExp = new RegExp( /^[0-9|-]*$/ );
        if( regExp.test( number ) == true ) { return true; }
        else { return false; }
    }
</script>


<script type="text/javascript">
$(function(){
	$(".orderBtn").click(function(){
		alert("주문하기");
		location = "write.do"
		})
})
</script>
</head>
<body>
<div class="container">
 <form action="write.do" role="form" method="post" autocomplete="off">
<div class="orderInfo col-sm-6">
<h2>주문하기</h2>
    
    
  <div class="inputArea">
   <label for="">수령인</label>
   <input type="text" name="buyUser" id="buyUser" class="form-control" required="required" />
  </div>
  
  <div class="inputArea">
   <label for="orderPhon">수령인 연락처</label>
   <input type="text" name="phone" id="phone" class="form-control" maxlength="13" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" required="required" />
  </div>
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<input type="text" name="addres1" id="sample6_postcode" placeholder="우편번호">
<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" name="addres2" id="sample6_address" placeholder="주소"><br>
<input type="text" name="addres3" id="sample6_detailAddress" placeholder="상세주소">
<input type="text" id="sample6_extraAddress" placeholder="참고항목">

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

  <div class="inputArea">
   <label for="userAddr3">요청사항</label>
   <input type="text" name="request" id="request" class="form-control" required="required" />
  </div>
  
</div>
<div class="itemInfo col-sm-6 container">
<h2>결제 상품 정보</h2>
  <div class="item">
<c:forEach items="${list}" var="vo">
   <div class="thumb">
    <img src="${vo.item_thum}" />
</div>
     <span>상품명 : </span>${vo.item_title}<br />
     <span>옵션 : </span>${vo.option_name}${vo.option_info}<br />
     <span>상품 가격 : </span>${vo.item_price}(+${vo.option_price}) 원<br />
     <span>구입 수량 : </span>${vo.cnt}<br/>

</c:forEach>
</div>
<label>총 상품 가격</label>
<input name="allPrice" value="100000" readonly class="form-control" />
</div>
  <div class="inputArea pull-right">
   <button class="orderBtn btn btn-default">주문</button>
   <button type="button" class="cancelBtn btn btn-default">취소</button> 
  </div>
 </form> 
</div>
</body>
</html>