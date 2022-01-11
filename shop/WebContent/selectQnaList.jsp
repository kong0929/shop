<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	// dao 객체 생성
	QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> qnaList = qnaDao.selectQnaList();
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% if(session.getAttribute("loginMember") == null || loginMember.getMemberLevel() < 1) { %>
	<!-- 사용자가 접속 시 사용자 메뉴 출력 -->
	<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	<%	} else { %>
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<%	} %>
	
	<div align='center' class="container">
	<br>
	<h4>QnA 게시판</h4>
	<div align="right"><a href="<%=request.getContextPath() %>/insertQnaForm.jsp">입력</a></div>
	<br>
	<table class="table">
		<thead>
			<tr>
				<th>QnaNo</th>
				<th>QnaCategory</th>
				<th>QnaTitle</th>
				<th>Secret</th>
				<th>QnaCreateDate</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Qna q : qnaList) {
			%>
			<tr>
				<td><%=q.getQnaNo() %></td>
				<td><%=q.getQnaCategory()%></td>
				<td><!-- 제목링크누르면 이동하게 -->
					<a href="<%=request.getContextPath() %>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo() %>"><%=q.getQnaTitle() %></a>
				</td>
				<td><!-- 비밀글 아이콘출력 -->
				<%
					if(q.getQnaSecret().equals("Y")) {
				%>
						<img src="<%=request.getContextPath() %>/image/lockO.png" width="20" height="20">
				<%
					} else {
				%>
						<img src="<%=request.getContextPath()%>/image/lockX.png" width="20" height="20">
				<%
					}
				%>
				</td>
				<td><%=q.getCreateDate() %></td>
			<%
					}
			%>
			</tr>
		</tbody>
	</table>
</div>
</body>
</html>