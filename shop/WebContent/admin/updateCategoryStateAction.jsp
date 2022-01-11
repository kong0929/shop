<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//encoding
	request.setCharacterEncoding("utf-8");

	String categoryName = "";
	String categoryState = "";
	
	categoryName = request.getParameter("categoryName");
	categoryState = request.getParameter("categoryState");
	
	// debug
	System.out.println("카테고리 사용 : " + categoryState);

	// 방어코드
	if(request.getParameter("categoryState") == null || request.getParameter("categoryState").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/selectCategoryList.jsp");
		return;
	}

	// dao
	CategoryDao categoryDao = new CategoryDao();
	Category category = new Category();
	category.setCategoryName(categoryName);
	category.setCategoryState(categoryState);
	
	categoryDao.updateCategoryState(category);
	System.out.println("카테고리 사용 상태 변경 성공");
	response.sendRedirect(request.getContextPath() + "/admin/selectCategoryList.jsp");


%>