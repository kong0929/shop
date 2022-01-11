<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	//loginMember가 null일 때 이 페이지를 들어올 수 없음
	if(loginMember == null){
		System.out.println("insertQna : 로그인이 필요합니다");
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- start: mainMenu include -->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	<!-- end : mainMenu include -->
	<h3>QnA 작성</h3>
		<form method="post" action="<%=request.getContextPath()%>/insertQnaAction.jsp">
			<table>
				<tr>
					<td>TITLE</td>
					<td><input type="text" name="qnaTitle" class="form-control"></td>
				</tr>
				<tr>
					<td>Category</td>
					<td>
						<input type="radio" class="qnaCategory" name="qnaCategory" value="전자책관련">전자책관련
						<input type="radio" class="qnaCategory" name="qnaCategory" value="개인정보관련">개인정보관련
						<input type="radio" class="qnaCategory" name="qnaCategory" value="기타">기타
					</td>
				</tr>
				<tr>
					<td>비밀글 설정</td>
					<td>
						<input type="radio" class="qnaSecret" name="qnaSecret" value="Y">YES
						<input type="radio" class="qnaSecret" name="qnaSecret" value="N">NO
					</td>
				</tr>
				<tr>
					<td>CONTENT</td>
					<td><textarea name="qnaContent" class="form-control" cols="30" rows="10"></textarea></td>
				</tr>
				<tr>
					<td>WRITER</td>
					<td><input type="text" name="memberNo" class="form-control" readonly="readonly" value="<%=loginMember.getMemberNo()%>"></td>
				</tr>
			</table>
			<button type="submit">글쓰기</button>
		</form>
</body>
</html>