<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	
	//로그인 session확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품상세보기</title>
</head>
<body>
	<% if(session.getAttribute("loginMember") == null || loginMember.getMemberLevel() < 1) { %>
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	<%	} else { %>
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<%	} %>
	<div class="container" style="font-size: 19px;">
	<br>
	<h2 class="font-weight-bold">상세보기</h2>
	<div>
		<!-- 상품상세출력 -->
		<%
			EbookDao ebookDao = new EbookDao();
			Ebook ebook = ebookDao.selectEbookOne(ebookNo);
			Ebook list = ebookDao.selectProductList(ebookNo);
			String price = String.format("%,d", ebook.getEbookPrice());
		%>
		
		<div id="article" class="row rounded-lg p-4 mb-4 mt-4">
		
			<div class="col-sm-4">
				<img src="<%=request.getContextPath()%>/image/<%=ebook.getEbookImg()%>" width="300" height="450">
			</div>
			<div class="col-sm-8">
			
				<div class="row">
				
					<div class="col">
						<h3 class="font-weight-bold"><%=list.getEbookTitle() %></h3>
						<p><%=ebook.ebookAuthor%> | <%=ebook.ebookCompany %></p>
						<p>판매가 : <%=price%> 원</p>
						<p><%=ebook.categoryName %></p>
						<p>출간일 : <%=ebook.createDate%></p>
						<p><%=ebook.ebookSummary %>
						<br><br>
						<h5>전자책 주문</h5>
					</div>
					</div>
		
		<%
			if(loginMember == null) {
		%>
					로그인 후에 주문이 가능합니다. 
					<a href="<%=request.getContextPath()%>/loginForm.jsp">로그인 페이지로</a>
		<%		
			} else {
		%>
				<form method="post" action="<%=request.getContextPath()%>/insertOrderAction.jsp">
					<input type="hidden" name="ebookNo" value="<%=ebookNo%>">
					<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>">
					<input type="hidden" name="ebookPrice" value="<%=ebook.getEbookPrice()%>">
					<button type="submit">주문하기</button>
				</form>
		<%
			}
		%>
	</div>
	</div>
	<div>
		<h5>상품 후기</h5>
		<!-- 이 상품의 별점의 평균 -->
		<!-- select avg(order_score) from order_comment where ebook_no=? order by ebook_no -->
		<%
			OrderCommentDao orderCommentDao = new OrderCommentDao();
			double avgScore = orderCommentDao.selectOrderScoreAvg(ebookNo);
		%>
			별점 평균 : <%=avgScore%>
		
		<br>
		<div>
		<br><br>
			<h5>후기 목록</h5>
			
				<!-- 이 상품의 상품 후기(페이징) -->
				<%
				// 페이징
				// 페이지번호 = 전달 받은 값이 없으면 currentPage를 1로 디폴트
				int currentPage = 1;
				// current가 null이 아니라면 값을 int 타입으로로 바꾸어서 페이지 번호로 사용
				if(request.getParameter("currentPage") != null) { 
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				}
				// 디버깅
				System.out.println("currentPage(현재 페이지 번호) : "+currentPage);
				
				// limit 값 설정 beginRow부터 rowPerPage만큼 보여주세요
				// ROW_PER_PAGE 변수를 상수로 설정하여서 10으로 초기화하면 끝까지 10이다.
				final int ROW_PER_PAGE = 10;
				int beginRow = (currentPage-1) * ROW_PER_PAGE;
				
				ArrayList<OrderComment> commentList = new ArrayList<OrderComment>();
				commentList = orderCommentDao.selectCommentList(beginRow, ROW_PER_PAGE, ebookNo);
				
				// 마지막 페이지(lastPage)를 구하는 orderCommentDao의 메서드 호출
				// int 타입의 lastPage에 저장
				// 전체 행을 COUNT 하는 selectCommentListLastPage메서드 호출
				int lastPage = orderCommentDao.selectCommentListLastPage(ROW_PER_PAGE, ebookNo);
				
				// 화면에 보여질 페이지 번호의 갯수
				int displayPage = 10;
				
				// 화면에 보여질 시작 페이지 번호
				// ((현재페이지번호 - 1) / 화면에 보여질 페이지 번호) * 화면에 보여질 페이지 번호 + 1
				// (currentPage - 1)을 하는 이유는 현재페이지가 10일시에도 startPage가 1이기 위해서
				int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
					
				// 화면에 보여질 마지막 페이지 번호
				// 만약에 마지막 페이지 번호(lastPage)가 화면에 보여질 페이지 번호(displayPage)보다 작다면 화면에 보여질 마지막 페이지번호(endPage)를 조정한다
				// 화면에 보여질 시작 페이지 번호 + 화면에 보여질 페이지 번호 - 1
				// -1을 하는 이유는 페이지 번호의 갯수가 10개이기 때문에 statPage에서 더한 1을 빼준다
				int endPage = 0;
				if(lastPage<displayPage){
					endPage = lastPage;
				} else if (lastPage>=displayPage){
					endPage = startPage + displayPage - 1;
				}
				
				// 디버깅
				System.out.println("startPage(화면에 보여질 시작 페이지 번호) : "+startPage+", endPage(화면에 보여질 마지막 페이지 번호) : "+endPage);
				%>
				<table class="table mt-1">
					<tr>
						<td style="width:10%; text-align:center">GRADE</td>
						<td style="width:10%; text-align:center">COMMENT</td>
						<td style="width:10%; text-align:center">DATE</td>
					</tr>
					<%
						for(OrderComment c : commentList) {
					%>
							<tr>
								<td style="width:10%; text-align:center"><%=c.getOrderScore()%></td>
								<td style="width:10%; text-align:center"><%=c.getOrderCommentContent()%></td>
								<td style="width:10%; text-align:center"><%=c.getCreateDate()%></td>
							</tr>
					<%
						}
					%>
				</table>
				
				<div align="center">
				<%
				// 처음으로 버튼
				// 제일 첫번째 페이지로 이동할때 = 1 page로 이동
				if(currentPage != 1){
				%>
					<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=1%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary center-block">◀처음</a>
				<%
				}
					
				// 이전 버튼
				// 화면에 보여질 시작 페이지 번호가 화면에 보여질 페이지 번호의 갯수보다 크다면 이전 버튼을 생성
				if(startPage > displayPage){
				%>
					<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=startPage-displayPage%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary">&lt;이전</a>
				<%
				}
							
				// 페이징버튼
				// 화면에 보여질 시작 페이지 번호를 화면에 보여질 마지막 페이지 번호까지 반복하면서 페이지 번호 생성
				// 만약에 화면에 보여질 마지막 페이지 번호가 마지막 페이지보다 크다면 for문을 break로 종료시킴
				for(int i=startPage; i<=endPage; i++){
					if(currentPage == i){
				%>
						<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=i%>&ebookNo=<%=ebookNo%>" class="btn btn-secondary"><%=i%></a>
				<%
					} else if(endPage<lastPage || endPage == lastPage){
				%>
						<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=i%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary"><%=i%></a>
				<%	
					} else if(endPage>lastPage){
						break;
					}
				}
					
				// 다음 버튼
				// 화면에 보여질 마지막 페이지 번호가 마지막페이지보다 작다다면 이전 버튼을 생성
				if(endPage < lastPage){
				%>
					<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=startPage+displayPage%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary">다음></a>
				<%
					}
							
				// 끝으로 버튼
				// 가장 마지막 페이지로 바로 이동하는 버튼
				if(currentPage != lastPage){
				%>
					<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=lastPage%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary">끝▶</a>
				<%
				}
				%>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>





