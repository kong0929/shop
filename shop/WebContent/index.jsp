<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
	<!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Custom styles for this template -->
  <link href="css/shop-homepage.css" rel="stylesheet">
  
<meta charset="UTF-8">
</head>
<body>
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
		<!-- 로그인 작업 -->
			<%
				if(session.getAttribute("loginMember") == null) {
			%>
				<br>
				<div align='right' style="font-size: 18px;">
					회원이신가요?
					<a href="<%=request.getContextPath() %>/loginForm.jsp">로그인</a>
					<br>
					처음이신가요?
					<a href="<%=request.getContextPath() %>/insertMemberForm.jsp">회원가입</a>
				</div>
			<%		
				} else {
					Member loginMember = (Member)session.getAttribute("loginMember");
			%>
				<br>
				<!-- 로그인 후-->
				<div align='right' style="font-size: 18px;">
					<%=loginMember.getMemberId()%>님 반갑습니다. &nbsp;
					<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-secondary">LOGOUT</a>
					<!--  <a href="<%=request.getContextPath()%>">회원정보</a> -->
					<a href="<%=request.getContextPath()%>/selectOrderListByMember.jsp" class="btn btn-secondary">ORDER</a>
					<!-- 관리자일경우 관리자페이지 뜨게 -->
					<%
						if(loginMember.getMemberLevel() > 0) {
					%>
							<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp" class="btn btn-secondary">ADMIN</a>
					<%
							}
						}
					%>
				</div>
				<br>
	<!-- 상품 목록 -->
	<%
		// 페이징
		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
		int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	
		// 전체 목록
		EbookDao ebookDao = new EbookDao();
		
		// 인기 목록 5개(많이 주문된 5개의 ebook)
		ArrayList<Ebook> popularEbookList = ebookDao.selectPopularEbookList();
		
		// 최신 목록 5개(가장 최근에 추가된 5개의 ebook)
		ArrayList<Ebook> newestEbookList = ebookDao.selectNewestEbookList();
		
		NoticeDao noticeDao = new NoticeDao();
		ArrayList<Notice> noticeList = noticeDao.selectNoticeList();
	%>
	
	<div class="container">
	<div align='left'>
		  <div class="alert alert-info alert-dismissible">
			 <button type="button" class="close" data-dismiss="alert">&times;</button>
			 <strong>
				[공지] <a class="text-body" href="selectNoticeOne.jsp?noticeNo=11">서버 점검 안내</a><br></strong>
			</div>
			
			
			<br>
			<div class="container" style="font-size: 19px;">
				<div class="alert alert-secondary">
					<div align='left'>
						<h3>NEW</h3>
					</div>
				<table>
					<tr>
						<%
							for(Ebook e : newestEbookList) {
								String price = String.format("%,d", e.getEbookPrice());
						%>
						<td>
							<div class="card" style="width:205px">
				  				<img class="card-img-top" width="200" height="300" src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" alt="Card image">
				  				<div class="card-body">
				    		<h5 class="card-title"><%=e.getEbookTitle()%></h5>
				    			<p class="card-text">₩ <%=price%></p>
								<div></div>
				    			<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>" class="btn btn-dark">VIEW MORE</a>
				  			</div>
						</div>
					</td>
					<%	
						}		
					%>
	</tr>
	</table>
	<br>
	</div>
	</div>
		<br><br>
	</div>
	
	<div class="container" style="font-size: 19px;">
	<div class="alert alert-secondary">
	<div align='left'> <h3>BEST</h3> </div>
	<table>
		<tr>
			<%
				for(Ebook e: popularEbookList) {
					String price = String.format("%,d", e.getEbookPrice());
			%>
					<td>
						<div class="card" style="width:205px">
							<img class="card-img-top" width="200" height="300" src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" alt="Card image">
						<div class="card-body">		
					<h5 class="card-title"><%=e.getEbookTitle()%></h5>
						<p class="card-text">₩ <%=price%></p>
						<div></div>
						<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>" class="btn btn-dark">VIEW MORE</a>
						
					</div>
					</div>
					</td>
			<%
				} 
			%>
		</tr>
	</table>
	<br>
	</div>
</div>
</div>
</body>
</html>