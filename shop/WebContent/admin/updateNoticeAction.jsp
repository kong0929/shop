<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 한글인코딩
	request.setCharacterEncoding("utf-8");
	// 관리자만 접속가능한 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
	// noticeNo를 받았는지 유효성검사하는 방어코드
	if(request.getParameter("noticeNo")==null || request.getParameter("noticeNo").equals("") || request.getParameter("noticeTitle")==null || request.getParameter("noticeTitle").equals("") || request.getParameter("noticeContent")==null || request.getParameter("noticeContent").equals("") || request.getParameter("memberNo")==null || request.getParameter("memberNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/selectNoticeList.jsp");
		return;
	}
	
	// dao 객체생성
	NoticeDao noticeDao = new NoticeDao();
	
	// request값 저장
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	System.out.println("[DEBUG] noticeNo :" + noticeNo);
	System.out.println("[DEBUG] noticeTitle :" + noticeTitle);
	System.out.println("[DEBUG] noticeContent :" + noticeContent);
	System.out.println("[DEBUG] memberNo :" + memberNo);
	
	// 받아온 값 저장
	Notice paramNotice = new Notice();
	paramNotice.setNoticeNo(noticeNo);
	paramNotice.setNoticeTitle(noticeTitle);
	paramNotice.setNoticeContent(noticeContent);
	paramNotice.setMemberNo(memberNo);
	
	// updateNoticeByAdmin 호출
	if(noticeDao.updateNoticeByAdmin(paramNotice)) {
		response.sendRedirect(request.getContextPath()+"/selectNoticeList.jsp");
		return;
	}
	
	
	response.sendRedirect(request.getContextPath()+"/selectNoticeList.jsp");
%>