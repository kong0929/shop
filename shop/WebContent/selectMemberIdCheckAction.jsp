<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%
	// memberIdCheck값이 공배이거나 널인지 ....
	if(request.getParameter("memberIdCheck") == null || request.getParameter("memberIdCheck").equals("")){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}
	
	String memberIdCheck = request.getParameter("memberIdCheck");
	
	MemberDao memberDao = new MemberDao();
	String result = memberDao.selectMemberId(memberIdCheck);
	
	if(result == null) {
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?memberIdCheck="+memberIdCheck);
	} else {
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?idCheckResult=ThisIDisalreadytaken");
	}
%>
