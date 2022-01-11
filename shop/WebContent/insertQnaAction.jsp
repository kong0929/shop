<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// 한글인코딩
	request.setCharacterEncoding("utf-8");
	// qnaDao 객체생성
	QnaDao qnaDao = new QnaDao();
	// session에 저장된 loginMember를 받아옴
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 입력값 방어 코드
	// 공지사항 게시글 입력값 유효성 검사
	if(request.getParameter("qnaSecret")==null || request.getParameter("qnaSecret").equals("") || request.getParameter("qnaCategory")==null || request.getParameter("qnaCategory").equals("") || request.getParameter("qnaTitle")==null || request.getParameter("qnaTitle").equals("") || request.getParameter("qnaContent")==null || request.getParameter("qnaContent").equals("") || request.getParameter("memberNo")==null || request.getParameter("memberNo").equals("")) {
		System.out.println("모든 항목을 입력해주세요");
		response.sendRedirect(request.getContextPath()+"/insertQnaForm.jsp");
		return;
	}
	
	// request값 저장
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaCategory = request.getParameter("qnaCategory");
	String qnaContent = request.getParameter("qnaContent");
	String qnaSecret = request.getParameter("qnaSecret");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// requst 매개값 디버깅 코드
	System.out.println("[DEBUG] qnaCategory :" + qnaCategory);
	System.out.println("[DEBUG] qnaTitle :" + qnaTitle);
	System.out.println("[DEBUG] qnaContent :" + qnaContent);
	System.out.println("[DEBUG] qnaSecret : " + qnaSecret);
	System.out.println("[DEBUG] qnamemberNo :" + memberNo);
	
	// 객체 생성 후 받아온 값 저장
	Qna paramQna = new Qna();
	paramQna.setQnaCategory(qnaCategory);
	paramQna.setQnaTitle(qnaTitle);
	paramQna.setQnaContent(qnaContent);
	paramQna.setQnaSecret(qnaSecret);
	paramQna.setMemberNo(memberNo);
	
	// 공지사항의 게시글을 입력하는 qnaDao의 insertQna 메서드 호출
	if(qnaDao.insertQna(paramQna)) {
		System.out.println("Qna 입력 성공");
	} else {
		System.out.println("Qna 입력 실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
%>
