<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>

<%
	request.setCharacterEncoding("utf-8");

	// categoryNameCheck 공백인지 
	if(request.getParameter("categoryNameCheck")==null || request.getParameter("categoryNameCheck").equals("")){
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp?categoryCheckResult=%EC%B9%B4%ED%85%8C%EA%B3%A0%EB%A6%AC%EB%A5%BC%20%EC%9E%85%EB%A0%A5%ED%95%B4%EC%A3%BC%EC%84%B8%EC%9A%94.");
		return;
	}
	
	String categoryNameCheck = request.getParameter("categoryNameCheck");
	String categoryNameCheckURL = java.net.URLEncoder.encode(categoryNameCheck,"utf-8");
	
	CategoryDao categoryDao = new CategoryDao();
	String result = categoryDao.selectCategoryNameCheck(categoryNameCheck);
	
	if(result == null){
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp?categoryNameCheck="+categoryNameCheckURL+"&categoryCheckResult=%EC%82%AC%EC%9A%A9%EA%B0%80%EB%8A%A5%ED%95%9C%20%EC%B9%B4%ED%85%8C%EA%B3%A0%EB%A6%AC%20%EC%9D%B4%EB%A6%84%EC%9E%85%EB%8B%88%EB%8B%A4.");
	} else {
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp?categoryCheckResult=%EC%9D%B4%EB%AF%B8%20%EC%82%AC%EC%9A%A9%EC%A4%91%EC%9D%B8%20%EC%B9%B4%ED%85%8C%EA%B3%A0%EB%A6%AC%EC%9E%85%EB%8B%88%EB%8B%A4.");
	}
%>