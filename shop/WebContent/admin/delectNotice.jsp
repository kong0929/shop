<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println("[DEBUG] 강제삭제 : " + noticeNo);
	// 방어코드
	if(request.getParameter("noticeNo") == null) {
		response.sendRedirect(request.getContextPath() + "/admin/selectNoticeList.jsp");
		return;
	}
	
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.deleteNotice(noticeNo);
	System.out.println("공지사항 삭제 성공");
	response.sendRedirect(request.getContextPath() + "/selectNoticeList.jsp");
%>
