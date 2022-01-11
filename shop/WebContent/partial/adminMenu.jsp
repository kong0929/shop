<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<nav class="navbar navbar-expand-sm bg-light navbar-light">
	<ul style="font-size:25px;" class="navbar-nav">
		<!-- 회원 관리 : 목록, 수정(등급,비밀번호), 강제탈퇴 -->
		<li class="nav-item active">
			<a class="nav-link" href="<%=request.getContextPath()%>/index.jsp">메인화면</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp">회원관리</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp">전자책관리</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="<%=request.getContextPath()%>/admin/selectCategoryList.jsp">전자책카테고리관리</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp">주문관리</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="<%=request.getContextPath()%>/selectNoticeList.jsp">공지게시판관리</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="<%=request.getContextPath()%>/selectQnaList.jsp">QnA게시판관리</a>
		</li>
	</ul>
</nav>
