<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 한글인코딩
	request.setCharacterEncoding("utf-8");
	// dao 객체 생성
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticeList();
	// session에 저장된 loginMember 
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>selectNoticeList.jsp</title>
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
	<h4>공지사항</h4>
	<br>
	<table class="table">
		<thead>
			<tr>
				<th>noticeNo</th>
				<th>noticeTitle</th>
				<th>createDate</th>
				<% if(session.getAttribute("loginMember") == null || loginMember.getMemberLevel() < 1) { 
					} else {
				%>
					<th>내용수정</th>
					<th>삭제</th>
				<% 
					}
				%>
			</tr>
		</thead>
		<tbody>
			<%
				for(Notice n : noticeList) {
			%>
			<tr>
				<td><%=n.getNoticeNo() %></td>
				<td><!-- 제목링크누르면 이동하게 -->
					<a href="<%=request.getContextPath() %>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a>
				</td>
				<td><%=n.getCreateDate() %></td>
				<% if(session.getAttribute("loginMember") == null || loginMember.getMemberLevel() < 1) {
					} else { %>
					<td>
						<!-- 내용수정 -->
						<a href="<%=request.getContextPath() %>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>">내용수정</a>
					</td>
					<td>
						<!-- 삭제 -->
						<a href="<%=request.getContextPath() %>/admin/delectNotice.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a>
					</td>
						<a href="<%=request.getContextPath() %>/admin/insertNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>">입력</a>
				<%
					}
				%>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>
</div>
</body>
</html>