<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 인증 방어 코드 : 로그인 전에만 페이지 열람 가능
	// session.getAttribute("loginMember") --> null
	
	if(session.getAttribute("loginMember") != null) {
		System.out.println("이미 로그인 되어 있습니다.");
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	
	<div class="container-fluid">
	 <div class="row">
	 <div class="col-sm-6">
		<div align='center' style="font-size: 18px;"> <br>
		<h4>로그인</h4> <br>
			<form id="loginForm" class="form-inline" method="post" action="<%=request.getContextPath() %>/loginAction.jsp">
				<label for="email2" class="mb-2 mr-sm-2">ID : </label>
				<input type="text" class="form-control mb-2 mr-sm-2" id="memberId" name="memberId" placeholder="Enter ID">
				<label for="pwd2" class="mb-2 mr-sm-2">PASSWORD : </label>
				<input type='password' class="form-control mb-2 mr-sm-2" id="memberPw" name="memberPw" placeholder="Enter PASSWORD" name="pswd">
				<button id="loginBtn" class="btn btn-primary mb-2" type="button">로그인</button>
			</form>
		</div>
		<script>
			$('#loginBtn').click(function(){
				// 버튼을 click했을때
				if($('#memberId').val() == '') { // id 공백이면
					alert('memberId를 입력하세요');
					return;
				} else if($('#memberPw').val() == '') { // pw 공백이면
					alert('memberPw를 입력하세요');
					return;
				} else {
					$('#loginForm').submit(); // <button type="button"> -> <button type="submit">
				}
			});
		</script>
	</div>
	
	<div class="col-sm-6">
		<div align='center' style="font-size: 18px;"> <br>
		<h4>아직 회원이 아니신가요?</h4> <br>
		<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
	</div>
	</div>
</div>
</div>
</body>
</html>





