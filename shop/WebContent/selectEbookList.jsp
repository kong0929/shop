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
	
	<%
		//한글인코딩
		request.setCharacterEncoding("utf-8");
	
		CategoryDao categoryDao = new CategoryDao();
		ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		System.out.println("[Debug] currentPage : " + currentPage);
	
		final int ROW_PER_PAGE = 15; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	
		int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	
		String categoryName = "";
	
		if (request.getParameter("categoryName") != null) {
			categoryName = request.getParameter("categoryName");
		}
	
		// 카테고리별 목록 받아오기
		EbookDao ebookDao = new EbookDao();
		ArrayList<Ebook> ebookList = null;
	
		if (categoryName.equals("") == true) {
			ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
		} else {
			ebookList = ebookDao.selectEbookListByCategory(beginRow, ROW_PER_PAGE, categoryName);
		}
		
		// 검색
		String searchEbookId = "";
		if(request.getParameter("searchEbookId")!=null){
			searchEbookId = request.getParameter("searchEbookId");
		}
		System.out.println(searchEbookId+" <--selectEbookList searchEbookId");
		
		if(searchEbookId.equals("") == true) { // 검색어가 없을때
			ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
		} else { // 검색어가 있을때
			ebookList = ebookDao.selectEbookListAllBySearchEbookId(beginRow, ROW_PER_PAGE, searchEbookId);
		}
	%>
	<div align='center' class="container"><br>
		<h2>EBOOK</h2>
		<br>
		<form action="<%=request.getContextPath()%>/selectEbookList.jsp" method="get">
		<div class="input-group mb-3">
		 	<input type="text" class="form-control" placeholder="Search" name="searchEbookId">
		 		<div class="input-group-append">
    		<button class="btn btn-success" type="submit">검색</button>
  		</div>
		</div>

		
		<!-- 전자책 목록 출력 : 카테고리별 출력 -->

		<table>
		<tr>
			<%
				int j = 0;
				for(Ebook e : ebookList) {
					String price = String.format("%,d", e.getEbookPrice());
			%>	
				<td>
						<div class="card" style="width:220px">
				  				<img class="card-img-top" width="200" height="300" src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" alt="Card image">
				  				<div class="card-body">
				    		<h4 class="card-title"><%=e.getEbookTitle()%></h4>
				    			<p class="card-text">
				    			<%=e.ebookAuthor %> | <%=e.ebookCompany %>
				    			<br>
				    			<%=e.categoryName %>
				    			<br>
				    			<%=e.ebookState%>
				    			<br>
				    			₩ <%=price%>
				    			</p>
								<div></div>
				    			<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>" class="btn btn-dark">VIEW MORE</a>
				  			</div>
						</div>
					<br>
					</td>
			<%
					j+=1; // j=j+1; j++; for문 끝날때마다 j는 1씩 증가
					if(j%5 == 0) {
			%>
					</tr><tr><!-- 줄바꿈 -->
			<%	
					}
				}
			%>
		</tr>
	</table>
		
		<!-- 하단 네비게이션 바 -->
		<div>
			<a href="<%=request.getContextPath()%>/selectEbookList.jsp?currentPage=1&category=<%=categoryName%>" class="btn btn-outline-dark">처음으로</a>
			<%
			if (currentPage != 1) {
			%>
			<a href="<%=request.getContextPath()%>/selectEbookList.jsp?currentPage=<%=currentPage - 1%>&category=<%=categoryName%>" class="btn btn-outline-dark">이전</a>
			<%
			}

			int lastPage = ebookDao.selectEbookLastPage(10, categoryName);

			int displayPage = 10;

			int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
			int endPage = startPage + displayPage - 1;

			for (int i = startPage; i <= endPage; i++) {
				if (endPage <= lastPage) {
				%>
					<a href="<%=request.getContextPath()%>/selectEbookList.jsp?currentPage=<%=i%>&category=<%=categoryName%>" class="btn btn-outline-dark"><%=i%></a>
				<%
				} else if (endPage > lastPage) {
				%>
					<a href="<%=request.getContextPath()%>/selectEbookList.jsp?currentPage=<%=i%>&category=<%=categoryName%>" class="btn btn-outline-dark"><%=i%></a>
				<%
				}
				
				if (i == lastPage) {
					break;
				}
			}
			if (currentPage != lastPage) {
			%>
				<a href="<%=request.getContextPath()%>/selectEbookList.jsp?currentPage=<%=currentPage + 1%>&category=<%=categoryName%>" class="btn btn-outline-dark">다음</a>
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/selectEbookList.jsp?currentPage=<%=lastPage%>&category=<%=categoryName%>" class="btn btn-outline-dark">끝으로</a>
		</div>
	</form>
	<br><br>
	</div>
</body>