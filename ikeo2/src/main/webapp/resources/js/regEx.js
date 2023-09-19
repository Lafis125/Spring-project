/**
 * 정규표현식 자리
 */

//console.log("regEx.js Loading");

// const - 상수 변수 선언
const reg_digit = /^\d+$/;
const reg_digit_error_msg = "숫자만 입력 하셔야 합니다";

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ회원ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
// 아이디 패턴 - 첫글자는 영문자, 뒤에는 영숫자, 4자~20자 사이
const reg_id = /^[a-z][a-z0-9]{3,19}$/;
const reg_id_error_msg = "아이디 첫 글자는 영문자, 4~20자까지 영문자와 숫자만 입력해야 합니다";

// 닉네임 패턴 - 첫글자는 영문자, 한글, 뒤에는 영숫자, 한글, 4자~50자 사이
const reg_nickname = /^[a-zA-Z가-힣][a-zA-Z가-힣0-9]{3,49}$/;
const reg_nickname_error_msg = "닉네임 첫 글자는 영문자나 한글, 4~50자까지 영문자와 한글이나 숫자만 입력해야 합니다";

// 비밀번호 - 비밀번호는 영문 숫자 특수기호 조합 8자리 이상 20자리 이하
const reg_pw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,19}$/;
const reg_pw_error_msg = "비밀번호는 영문 숫자 특수기호 조합 8자리 이상 입력하셔야 합니다"

// 이름 패턴 - 
const reg_name = /^[가-힣]{2,10}$/;
const reg_name_error_msg = "이름은 한글 2~10자리로 입력해야 합니다";


// 연락처 패턴 - 
//const reg_tel = /^\d{3,4} \d{4}$/;
const reg_tel = /^01[0-9]{1}-[0-9]{3,4}-[0-9]{4}$/;
const reg_tel_error_msg = "연락처 형식은 (예: 010-111(1)-1111)로 숫자와 '-'만 입력해야 합니다";

// 이메일 패턴 -
const reg_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
const reg_email_error_msg = "이메일 형식은 aaa@bbb.ccc 형식으로 입력해야 합니다";

//이메일 패턴 2
const reg_email2 = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z]){2,18}$/;
const reg_email_error_msg2="이메일 형식 ID부분 첫글자는 영문자 그리고 숫자조합 하이픈(-), 밑줄(_), 또는 점(.) 조합 2~18글자 가능합니다";

// 이메일 도메인 패턴 
const reg_email3 = /[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
const reg_email_error_msg3="이메일 도메인 형식: @를 제외한 예)naver.com, daum.net 형식을 확인해주세요"


//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ/회원ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
// 정규 표현식을 검사하는 함수.
// text(위에 정규표현식 변수, 검사할 문자열, 에러메세지)
 function test(reg, str) {
	// 패턴에 맞지 않는 경우의 처리
	if(!reg.test(str)) {
		// 호출한 쪽에 오류라고 false를 return한다.
		return false;
	}
	// 오류가 없는 경우 true를 return 해 준다. 안해주면 false와 같이 동작한다.
	return true;
}

	// 데이터 유효성 검사 함수
	// isTrim - 1이면 trim() 처리 한다. 0이면 trim() 처리를 하지 않는다.
function checkData(reg, obj, isTrim) {
    console.log("checkData");
    if (isTrim && typeof obj === "object") {
        obj.val(obj.val().trim());
    }

    // 잘못 입력된 데이터 처리
    if (!test(reg, typeof obj === "object" ? obj.val() : obj)) {
        if (typeof obj === "object") {
            obj.focus();
        }
        return false;
    }
    // 맞게 입력된 데이터 처리
    return true;
}

	// 아이디 체크
	function checkId(id, callback) {
		$("#form-id").removeClass("has-success has-error");
		// 아이디에 입력이 되어 있을 경우
		if(id != '') {
			$("#checkId").css("display", "");
			if(!checkData(reg_id, id, 1)){
				$("#checkId").css("background-color", "tomato");
				$("#checkId").text(reg_id_error_msg);
				$("#form-id").addClass("has-error");
				callback(false);
			}
			$.ajax({
				url : '/memberAjax/checkId.action',
				type : 'GET',
				data : {
					id : id
				},
				success : function(data) {
					let result = data;
					if(result == 0) {
						$("#checkId").css("background-color", "limegreen");
						$("#checkId").text("사용 가능한 아이디 입니다");
						$("#form-id").addClass("has-success");
						callback(true);
					}
					else {
						$("#checkId").css("background-color", "tomato");
						$("#checkId").text("이미 존재하는 아이디 입니다");
						$("#form-id").addClass("has-error");
						callback(false);
					}
				},
				error : function() {
					console.log("아이디 중복 검사 중 오류가 발생했습니다");
					callback(false);
				}
			});
		}
		// 아이디에 입력이 안되어 있을 경우
		else {
			$("#checkId").css("background-color", "tomato");
			$("#checkId").text(reg_id_error_msg);
			$("#form-id").addClass("has-error");
			callback(false);
		}
	}
	
	// 닉네임 중복 체크
	function checkNickname(nickname, callback) {
		$("#form-nickname").removeClass("has-success has-error");
		// 닉네임에 입력을 했을 경우
		if(nickname != '') {
			$("#checkNickname").css("display", "");
			if(!checkData(reg_nickname, nickname, 1)){
				$("#checkNickname").css("background-color", "tomato");
				$("#checkNickname").text(reg_nickname_error_msg);
				$("#form-nickname").addClass("has-error");
				callback(false);
			}
			$.ajax({
				url : '/memberAjax/checkNickname.action',
				type : 'GET',
				data : {
					nickname : nickname
				},
				success : function(data) {
					let result = data;
					if(result == 0) {
						$("#checkNickname").css("background-color", "limegreen");
						$("#checkNickname").text("사용 가능한 닉네임 입니다");
						$("#form-nickname").addClass("has-success");
						callback(true);
					}
					else {
						$("#checkNickname").css("background-color", "tomato");
						$("#checkNickname").text("이미 존재하는 닉네임 입니다");
						$("#form-nickname").addClass("has-error");
						callback(false);
					}
				},
				error : function() {
					console.log("닉네임 중복 검사 중 오류가 발생했습니다");
					callback(false);
				}
			});
		}
		// 닉네임에 입력이 안되있을 경우
		else {
			$("#checkNickname").css("background-color", "tomato");
			$("#checkNickname").text(reg_nickname_error_msg);
			$("#form-nickname").addClass("has-error");
			callback(false);
		}
	}
	
	// 비밀번호 유효성 체크
	function checkPw(pw, callback) {
		$("#form-pw").removeClass("has-success has-error");
		// 비밀번호에 입력을 했을 경우
		if(pw != '') {
			$("#checkPw").css("display", "");
			// 비밀번호 유효성 검사 - 잘못된 형식
			if(!checkData(reg_pw, pw, 1)) {
				$("#checkPw").css("background-color", "tomato");
				$("#checkPw").text(reg_pw_error_msg);
				$("#form-pw").addClass("has-error");
				callback(false);
			// 비밀번호 유효성 검사 - 올바른 형식
			} else {
				$("#checkPw").css("background-color", "limegreen");
				$("#checkPw").text("사용 가능한 비밀번호입니다");
				$("#form-pw").addClass("has-success");
				callback(true);
			}
		// 비밀번호에 입력을 안했을 경우
		} else {
			$("#checkPw").css("background-color", "tomato");
			$("#checkPw").text(reg_pw_error_msg);
			$("#form-pw").addClass("has-error");
			callback(false);
		}
	}
	
	// 이메일 유효성 체크 (아이디, 도메인 따로)
	function checkEmail(email, domain, callback) {
		$("#form-email").removeClass("has-success has-error");
		// 이메일에 입력을 했을 경우
		if(email != '') {
			$("#checkEmail").css("display", "");
			// 이메일 유효성 검사 - 잘못된 형식
			if(!checkData(reg_email2, email, 1)) {
				$("#checkEmail").css("background-color", "tomato");
				$("#checkEmail").text(reg_email_error_msg2);
				$("#form-email").addClass("has-error");
				callback(false);
			// 이메일 유효성 검사 - 올바른 형식
			} else {
				$("#form-email").addClass("has-success");
				$("#form-domain").removeClass("has-success has-error");
				// 도메인에 입력을 했을 경우
				if(domain != '') {
					$("#checkEmail").css("display", "");
					// 도메인 유효성 검사 - 잘못된 형식
					if(!checkData(reg_email3, domain, 1)) {
						$("#checkEmail").css("background-color", "tomato");
						$("#checkEmail").text(reg_email_error_msg3);
						$("#form-domain").addClass("has-error");
						callback(false);
					// 도메인 유효성 검사 - 올바른 형식
					} else {
						$("#checkEmail").css("background-color", "limegreen");
						$("#checkEmail").text("올바른 이메일 형식입니다");
						$("#form-domain").addClass("has-success");
						callback(true);
					}
				// 도메인에 입력을 안했을 경우
				} else {
					$("#checkEmail").css("background-color", "tomato");
					$("#checkEmail").text(reg_email_error_msg3);
					$("#form-domain").addClass("has-error");
					callback(false);
				}
			}
		// 이메일에 입력을 안했을 경우
		} else {
			$("#checkEmail").css("background-color", "tomato");
			$("#checkEmail").text(reg_email_error_msg2);
			$("#form-email").addClass("has-error");
			callback(false);
		}
	}
	
	// 이메일 유효성 체크 (아이디, 도메인 한꺼번에)
	function checkEmail2(email, callback) {
		$("#form-email").removeClass("has-success has-error");
		// 이메일에 입력을 했을 경우
		if(email != '') {
			$("#checkEmail").css("display", "");
			// 이메일 유효성 검사 - 잘못된 형식
			if(!checkData(reg_email, email, 1)) {
				$("#checkEmail").css("background-color", "tomato");
				$("#checkEmail").text(reg_email_error_msg);
				$("#form-email").addClass("has-error");
				callback(false);
			// 이메일 유효성 검사 - 올바른 형식
			} else {
				$("#checkEmail").css("background-color", "limegreen");
				$("#checkEmail").text("사용 가능한 이메일 입니다");
				$("#form-email").addClass("has-success");
				callback(true);
			}
		// 이메일에 입력을 안했을 경우
		} else {
			$("#checkEmail").css("background-color", "tomato");
			$("#checkEmail").text(reg_email_error_msg);
			$("#form-email").addClass("has-error");
			callback(false);
		}
	}
	
	// 이름 유효성 체크
	function checkName(name, callback) {
		$("#form-name").removeClass("has-success has-error");
		// 이름에 입력을 했을 경우
		if(name != '') {
			$("#checkName").css("display", "");
			// 이름 유효성 검사 - 잘못된 형식
			if(!checkData(reg_name, name, 1)) {
				$("#checkName").css("background-color", "tomato");
				$("#checkName").text(reg_name_error_msg);
				$("#form-name").addClass("has-error");
				callback(false);
			// 이름 유효성 검사 - 올바른 형식
			} else {
				$("#checkName").css("background-color", "limegreen");
				$("#checkName").text("올바른 이름입니다");
				$("#form-name").addClass("has-success");
				callback(true);
			}
		// 이름에 입력을 안했을 경우
		} else {
			$("#checkName").css("background-color", "tomato");
			$("#checkName").text(reg_name_error_msg);
			$("#form-name").addClass("has-error");
			callback(false);
		}
	}
	
	// 전화번호 유효성 체크
	function checkTel(tel, callback) {
		$("#form-tel").removeClass("has-success has-error");
		// 전화번호에 입력을 했을 경우
		if(tel != '') {
			$("#checkTel").css("display", "");
			// 전화번호 유효성 검사 - 잘못된 형식
			if(!checkData(reg_tel, tel, 1)) {
				$("#checkTel").css("background-color", "tomato");
				$("#checkTel").text(reg_tel_error_msg);
				$("#form-tel").addClass("has-error");
				callback(false);
			// 전화번호 유효성 검사 - 올바른 형식
			} else {
				$("#checkTel").css("background-color", "limegreen");
				$("#checkTel").text("올바른 형식입니다");
				$("#form-tel").addClass("has-success");
				callback(true);
			}
		// 전화번호에 입력을 안했을 경우
		} else {
			$("#checkTel").css("background-color", "tomato");
			$("#checkTel").text(reg_tel_error_msg);
			$("#form-tel").addClass("has-error");
			callback(false);
		}
	}
	