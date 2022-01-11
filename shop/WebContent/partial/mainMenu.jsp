<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<ul style="font-size:25px;" class="navbar-nav"> 

		<li class="nav-item active">
			<a class="nav-link" href="<%=request.getContextPath()%>/index.jsp">HOME</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="<%=request.getContextPath()%>/selectEbookList.jsp">EBOOK</a>
		</li>
		<li class="nav-item">
			<a class="nav-link"href="<%=request.getContextPath()%>/selectNoticeList.jsp">NOTICE</a>
		</li>
		<li class="nav-item">
			<a class="nav-link"href="<%=request.getContextPath()%>/selectQnaList.jsp">QNA</a>
		</li>
	</ul>
</nav>