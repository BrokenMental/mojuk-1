<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
	src="/resources/jQuery/jQuery-2.1.4.min.js"></script>
<script type="text/javascript">
	var count = 0;

	function idCheck() {

		var text = $("#cnum").val();
		var regexp = /[0-9a-zA-Z]/; // 숫자,영문,특수문자
		// var regexp = /[0-9]/; // 숫자만
		//         var regexp = /[a-zA-Z]/; // 영문만

		for (var i = 0; i < text.length; i++) {

			if (text.charAt(i) != " " && regexp.test(text.charAt(i)) == false) {
				alert("한글이나 특수문자는 입력불가능 합니다.");
				return false;
			}
		}
		overlapCheck();
	}

	function overlapCheck() {

		var param = "cnum" + "=" + $("cnum").val();

		if ($("#cnum").val() == '' || $("#cnum").val() == null) {
			alert("아이디를 입력하세요");
			return false;
		}

		$.ajax({
			url : "/overlaptest.do",
			type : "GET",
			data : param,
			cache : false,
			async : false,
			dataType : "text",
			success : function(response) {

				if (response == '0') {
					count = 1;
					alert("아이디가 중복이 되지 않습니다. 쓰셔도 됩니다.")
				} else {

					alert("아이디가 중복이 됩니다. 다시 입력 해주세요");
					return false;
				}
			},
			error : function(request, status, error) {
				if (request.status != '0') {
					alert("code : " + request.status + "\r\nmessage : "
							+ request.reponseText + "\r\nerror : " + error);
				}
			}
		});
	}

	function formCheck() {

		var cnum = document.getElementById('cnum');
		var depart = document.getElementById('depart');
		var userpw = document.getElementById('userpw');
		var userpw_check = document.getElementById('userpw_check');
		var email = document.getElementById('email');
		var comp = document.getElementById('comp');
		var soci = document.getElementById('soci');

		if (cnum.value == '' || cnum.value == null) {
			alert('ID를 입력하세요');
			focus.cnum;
			return false;
		}

		if (userpw.value == '' || userpw == null) {
			alert('비밀번호를 입력하세요');
			focus.userpw;
			return false;
		}

		if (password_check.value == '' || password_check.value == null) {
			alert('비밀번호확인란을 입력하세요');
			focus.userpw;
			return false;
		}

		/*비밀번호와 비밀번호확인란 같은지 확인*/

		if (userpw.value != userpw_check.value) {
			alert("비밀번호와 비밀번호 확인란이 다릅니다.");
			focus.userpw;
			return false;
		}

		if (count == 0) {
			alert("중복확인을 눌러주세요");
			return false;
		}

		else {
			save();
		}
	}

	function init() {
		count = 0;
	}

	function save() {
		// 		alert($("#password_hint").val());
		// 		alert($("#member_HP").val());
		var str3 = document.getElementById('join');
		str3.submit();
		alert("가입이 완료되었습니다.")
	}

	function countCheck() {

		if (count == 1) {
			count = 0;
		}
	}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="#ffffff" text="#000000">

	<P align="center">

		<FONT size="6"><B>회원 가입서</B></FONT>

	</P>

	<form action="/members.do" method="post" id="join">

		<table width="550" align="center" border="1" bordercolor="ADD8E6"
			cellpadding="5">

			<tr>

				<td height="30" align="center" bgcolor="#FFDEAD">아이디</td>

				<td bgcolor="#E0FFFF"><input type="text" size="10"
					id="cnum" name="cnum" maxlength="10"
					onkeydown="countCheck();" onkeypress="countCheck();">&nbsp;<input
					type="button" value="중복확인" onclick='idCheck()'></td>
			</tr>
			<tr>
				<td height="30" align="center" bgcolor="#FFDEAD">비밀번호</td>
				<td bgcolor="#E0FFFF"><input type="password" id="userpw"
					name="member_userpw" size=12 maxlength="12"></td>
			</tr>

			<tr>
				<td height="30" align="center" bgcolor="#FFDEAD">비밀번호확인</td>
				<td bgcolor="#E0FFFF"><input type="password"
					id="userpw_check" name="userpw_check" size=12 maxlength="12"></td>
			</tr>
			<tr>

				<td height="30" align="center" bgcolor="#FFDEAD">E-Mail</td>

				<td bgcolor="#E0FFFF"><input type="text" id="email"
					name="email" size=12 maxlength="12"></td>
			</tr>
			<tr>

				<td colspan="2" height="30" align="center" bgcolor="#FFDEAD"><input
					type="button" id="join" name="join" value="가입하기"
					onclick="javascript:formCheck();">&nbsp;&nbsp; <input
					type="reset" value="리셋하기" onclick='init()'> <input
					type="button" id="back" value="뒤로가기"
					onclick="javascript:location.href='/loginpage.do';"></td>
			</tr>
		</table>
	</form>
</body>
</html>