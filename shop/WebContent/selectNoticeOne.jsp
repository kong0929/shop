<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 방어코드 - 공지사항번호(noticeNo)를 입력받았는지 유효성검사
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/selectNoticeList.jsp");
		System.out.println("noticeNo가 없습니다");
		return;
	}
	
	// request 값 저장
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	// dao 객체 생성
	NoticeDao noticeDao = new NoticeDao();
	// 공지사항을 SELECT하는 noticeDao의 selectNoticeOne 메서드
	// 성공시 : returnNotice라는 객체에 저장시켜서 출력
	// 실패시 : null
	Notice returnNotice = noticeDao.selectNoticeOne(noticeNo);
	if(returnNotice==null) {
		System.out.println("공지사항 불러오기 실패");
		response.sendRedirect(request.getContextPath()+"/selectNoticeList.jsp");
	} else {
		System.out.println("공지사항 불러오기 성공");
		System.out.println("[DEBUG] returnNotice.getNoticeNo() : " + returnNotice.getNoticeNo());
		System.out.println("[DEBUG] returnNotice.getNoticeTitle() : " + returnNotice.getNoticeTitle());
		System.out.println("[DEBUG] returnNotice.getNoticeContent() : " + returnNotice.getNoticeContent());
		System.out.println("[DEBUG] returnNotice.getCreateDate() : " + returnNotice.getCreateDate());
	}
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>selectNoticeOne.jsp</title>
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
	<table class="table" style="text-align: center;">
		<tr>
			<td>noticeNo</td>
			<td><%=returnNotice.getNoticeNo() %></td>
		</tr>
		<tr>
			<td>noticeTitle</td>
			<td><%=returnNotice.getNoticeTitle()%></td>
		</tr>
		<tr>
			<td>noticeContent</td>
			<td><%=returnNotice.getNoticeContent()%></td>
		</tr>
		<tr>
			<td>Create</td>
			<td><%=returnNotice.getCreateDate() %></td>
		</tr>
		<!-- 관리자만 수정, 삭제를 선택가능 -->
		<%	if(loginMember.getMemberLevel() > 0) { %>
		<tr>
			<td><button type="button" class="btn btn-outline-primary" a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=returnNotice.getNoticeNo() %>">수정</button></td>
			<td><button type="button" class="btn btn-outline-danger" a href="<%=request.getContextPath()%>/admin/deleteNoticeForm.jsp?noticeNo=<%=returnNotice.getNoticeNo() %>">삭제</button></td>
		</tr>
		<% } %>
		</tbody>
	</table>
</div>
</body>
</html>