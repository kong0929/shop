<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 한글인코딩
	request.setCharacterEncoding("utf-8");

	// noticeNo를 받았는지 유효성검사하는 방어코드
	//if(request.getParameter("noticeNo")==null || request.getParameter("noticeNo").equals("") || request.getParameter("noticeTitle")==null || request.getParameter("noticeTitle").equals("") || request.getParameter("noticeContent")==null || request.getParameter("noticeContent").equals("") || request.getParameter("memberNo")==null || request.getParameter("memberNo").equals("")) {
	//	response.sendRedirect(request.getContextPath()+"/admin/selectNoticeList.jsp");
	//	return;
	//}
	
	// dao 객체생성
	QnaDao qnaDao = new QnaDao();
	
	// request값 저장
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	String qnaCategory = request.getParameter("qnaCategory");
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	
	System.out.println("[DEBUG] qnaNo :" + qnaNo);
	System.out.println("[DEBUG] qnaCategory :" + qnaCategory);
	System.out.println("[DEBUG] qnaTitle :" + qnaTitle);
	System.out.println("[DEBUG] qnaContent :" + qnaContent);
	
	// 받아온 값 저장
	Qna paramQna = new Qna();
	paramQna.setQnaNo(qnaNo);
	paramQna.setQnaCategory(qnaCategory);
	paramQna.setQnaTitle(qnaTitle);
	paramQna.setQnaContent(qnaContent);
	
	// updateNoticeByAdmin 호출
	if(qnaDao.updateQna(paramQna)) {
		response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
		return;
	}
	
	
	response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
%>