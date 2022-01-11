<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//encoding
	request.setCharacterEncoding("utf-8");

	String categoryName = "";
			
	categoryName = request.getParameter("categoryName");
	
	// debug
	System.out.println("추가할 카테고리 : " + categoryName);

	// 방어코드
	if(request.getParameter("categoryName") == null || request.getParameter("categoryName").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp");
		return;
	}

	// dao
	CategoryDao categoryDao = new CategoryDao();
	
	categoryDao.insertCategory(categoryName);
	System.out.println("카테고리 추가 성공");
	response.sendRedirect(request.getContextPath() + "/admin/selectCategoryList.jsp");


%>