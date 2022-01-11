<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	// 사용자(일반 회원)들 리스트는 관리자만 출입
	// 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	// noticeNo가 null일경우 돌아가는 방어코드
	if(request.getParameter("noticeNo") == null) {
		response.sendRedirect("./selectNoticeList.jsp");
		return;
	}
	
	// request값 저장
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	// dao
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = noticeDao.selectNoticeOne(noticeNo);
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
<meta charset="UTF-8">
<title>updateNoticeForm.jsp</title>
</head>
<body>
	<!-- start : 관리자 adminMenu include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : 관리자 adminMenu include -->
	<form method="post" action="<%=request.getContextPath() %>/admin/updateNoticeAction.jsp">
		<h1>[관리자] 공지사항 수정</h1>
		<table>
			<tr>
				<td>noticeNo</td>
				<td><input type="text" name="noticeNo" value="<%=notice.getNoticeNo() %>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>noticeTitle</td>
				<td><input type="text" name="noticeTitle" value="<%=notice.getNoticeTitle() %>"></td>
			</tr>
			<tr>
				<td>noticeContent</td>
				<td><textarea name="noticeContent" cols="30" rows="10"><%=returnNotice.getNoticeContent()%></textarea></td>
			</tr>
			<tr>
				<td>memberNo</td>
				<td><input type="text" name="memberNo" readonly="readonly" value="<%=loginMember.getMemberNo()%>"></td>
			</tr>
			<tr>
				<td>updateDate</td>
				<td><input type="text" name="updateDate" readonly="readonly" value="<%=returnNotice.getUpdateDate()%>"></td>
			</tr>
			<tr>
				<td>createDate</td>
				<td><input type="text" name="createDate" readonly="readonly" value="<%=returnNotice.getCreateDate()%>"></td>
			</tr>
		</table>
		<div>
			<button type="submit">수정</button>
			<a href="<%=request.getContextPath()%>/admin/selctNoticeOne.jsp">돌아가기</a>
		</div>
	</form>
</body>
</html>