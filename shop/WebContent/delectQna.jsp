<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 한글 인코딩
	request.setCharacterEncoding("utf-8");
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println("[DEBUG] 강제삭제 : " + qnaNo);
	// 방어코드
	if(request.getParameter("qnaNo") == null) {
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
	
	QnaDao qnaDao = new QnaDao();
	qnaDao.deleteQna(qnaNo);
	System.out.println("Qna 삭제 성공");
	response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
%>