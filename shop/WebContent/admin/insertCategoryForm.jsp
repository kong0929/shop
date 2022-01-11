<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여기에 제목을 입력하십시오</title>
</head>
<body>
	<!-- start: adminMenu include -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	<!-- end : adminMenu include -->
	<div align='center' class="container">
	<br>
	<h4>카테고리 추가</h4>
	
	<%
		String categoryCheckResult = "";
		if(request.getParameter("categoryCheckResult") != null){
			categoryCheckResult = request.getParameter("categoryCheckResult");
		}
		String categoryNameCheck = "";
		if(request.getParameter("categoryNameCheck") != null){
			categoryNameCheck = request.getParameter("categoryNameCheck");
		}
	%>
	<form action="<%=request.getContextPath() %>/admin/selectCategoryNameCheckAction.jsp" method="post">
			<div>중복 검사</div>
			<div>
				<input type="text" name="categoryNameCheck"> 
				<button type="submit">중복 검사</button> 
			<%
				if(!categoryCheckResult.equals("")){
			%>
					<%=request.getParameter("categoryCheckResult") %>
			<%
				}
			%>
			</div>
		</form>
	<form method="post" action="<%=request.getContextPath() %>/admin/insertCategoryAction.jsp">
		<div>추가할 카테고리</div>
		<div><input type="text" name="categoryName"  value="<%=categoryNameCheck%>" readonly></div>
		<br>
		<div><button type="submit" class="btn btn-outline-primary">추가</button></div>
	</form>
	</div>
</body>
</html>