<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	
	<div align='center' class="container">
		<p><h4>회원가입</h4></p>
		<p>
		<!-- 멤버아이디 중복검사 -->
		<%
			String memberIdCheck = "";
			if(request.getParameter("memberIdCheck") != null) {
				memberIdCheck = request.getParameter("memberIdCheck");
			} 
		%>
			
		<!-- 멤버아이디가 사용가능한지 확인 폼 -->
		<form action="<%=request.getContextPath()%>/selectMemberIdCheckAction.jsp" method="post">
			<div>
				회원아이디 :
				<input type="text" name="memberIdCheck">
				<button type="submit">아이디 중복 검사</button>
			</div>
		</form>
		
		<!-- 회원가입 폼 -->
		<form id="joinForm" action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
			<table class="table">
				<tr>
					<td>회원아이디</td>
					<td><input type="text" id="memberId" name="memberId" readonly="readonly" value="<%=memberIdCheck%>"></td>
				</tr>
				<tr>
					<td>회원비밀번호</td>
					<td><input type="password" id="memberPw" name="memberPw"></td>
				</tr>
				<tr>
					<td>회원이름</td>
					<td><input type="text" id="memberName" name="memberName"></td>
				</tr>
				<tr>
					<td>회원나이</td>
					<td><input type="text" id="memberAge" name="memberAge"></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<input type="radio" class="memberGender" name="memberGender" value="남">남
						<input type="radio" class="memberGender" name="memberGender" value="여">여
					</td>
				</tr>
			</table>
			<button id="btn" class="btn btn-primary mb-2" type="button">회원가입</button>
		</form>
	</div>
	</div>
	<script>
		$('#btn').click(function(){
			if($('#memberId').val() == '') {
				alert('memberId를 입력하세요');
				return;
			}
			if($('#memberPw').val() == '') {
				alert('memberPw를 입력하세요');
				return;
			}
			if($('#memberName').val() == '') {
				alert('memberName를 입력하세요');
				return;
			}
			if($('#memberAge').val() == '') {
				alert('memberAge를 입력하세요');
				return;
			}
			let memberGedner = $('.memberGender:checked'); // . 클래스속성으로 부르면 리턴값은 배열
			if(memberGedner.length == 0) {
				alert('memberGender를 선택하세요');
				return;
			}
			
			$('#joinForm').submit();
		});
	</script>
</body>
</html>