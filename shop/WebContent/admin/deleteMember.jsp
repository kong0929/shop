<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// encoding
	request.setCharacterEncoding("utf-8");

	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// debug
	System.out.println("강제탈퇴" + memberNo);

	// 방어코드
	if(request.getParameter("memberNo") == null) {
		response.sendRedirect("./selectMemberList.jsp?currentPage=1");
		return;
	}
	
	// dao
	MemberDao memberDao = new MemberDao();
	
	memberDao.deleteMemberByAdmin(memberNo);
	System.out.println("회원 강제탈퇴 성공");
	response.sendRedirect(request.getContextPath() + "/admin/selectMemberList.jsp");
%>