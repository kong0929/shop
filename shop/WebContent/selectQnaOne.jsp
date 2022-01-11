<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	// 로그인 session확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 방어코드 - 공지사항번호(qnaNo)를 입력받았는지 유효성검사
	if(request.getParameter("qnaNo") == null || request.getParameter("qnaNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
		System.out.println("qnaNo가 없습니다");
		return;
	}
	
	// request 값 저장
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	// int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	// dao 객체 생성
	QnaDao qnaDao = new QnaDao();
	// Qna를 SELECT하는 qnaDao의 selectQnaOne 메서드
	// 성공시 : returnQna라는 객체에 저장시켜서 출력
	// 실패시 : null
	Qna returnQna = qnaDao.selectQnaOne(qnaNo);
	if(returnQna==null) {
		System.out.println("Qna 불러오기 실패");
		response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
	} else {
		System.out.println("Qna 불러오기 성공");
		System.out.println("[DEBUG] returnQna.getQnaNo() : " + returnQna.getQnaNo());
		System.out.println("[DEBUG] returnQna.getQnaCategory() : " + returnQna.getQnaCategory());
		System.out.println("[DEBUG] returnQna.getQnaTitle() : " + returnQna.getQnaTitle());
		System.out.println("[DEBUG] returnQna.getQnaContent() : " + returnQna.getQnaContent());
		System.out.println("[DEBUG] returnQna.getCreateDate() : " + returnQna.getCreateDate());
	}
	
	// dao 객체 생성
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	// Qna를 SELECT하는 qnaCommentDao의 selectQnaComment 메서드
	// 성공시 : qnaComment라는 객체에 저장시켜서 출력
	// 실패시 : null
	QnaComment qnaComment = qnaCommentDao.selectQnaComment(qnaNo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>selectQnaOne.jsp</title>
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
	<div align='center' class="container">
	<br>
	<h3>QnA</h3>
	<br>
	<%
		// 비밀글일때
		if(returnQna.getQnaSecret().equals("Y")) {
			// 관리자이거나 작성자이면 내용을 보여주고 수정 삭제버튼 보임
			if(loginMember.getMemberNo() == returnQna.getMemberNo() || loginMember.getMemberLevel() > 0) {
			%>
			<table class="table" style="text-align: center;" >
				<tr>
					<td>QnANo</td>
					<td><%=returnQna.getQnaNo() %></td>
				</tr>
				<tr>
					<td>QnACategory</td>
					<td><%=returnQna.getQnaCategory() %></td>
				</tr>
				<tr>
					<td>QnaTitle</td>
					<td><%=returnQna.getQnaTitle()%></td>
				</tr>
				<tr>
					<td>QnASecret</td>
					<td><%=returnQna.getQnaSecret() %></td>
				</tr>
				<tr>
					<td>QnaContent</td>
					<td><%=returnQna.getQnaContent()%></td>
				</tr>
				<tr>
					<td>Create</td>
					<td><%=returnQna.getCreateDate()%></td>
				</tr>
				<tr>
					<td><button type="button" class="btn btn-outline-primary" a href="<%=request.getContextPath()%>/updateQnaForm.jsp?qnaNo=<%=returnQna.getQnaNo() %>">수정</button></td>
					<td><button type="button" class="btn btn-outline-danger" a href="<%=request.getContextPath()%>/delectQna.jsp?qnaNo=<%=returnQna.getQnaNo() %>">삭제</button></td>
				</tr>
			</table>
			
			<div>
				<h3>Comment</h3>
					<!-- 비밀글 들어갔을때 댓글보이게함 -->
					<%
						if(qnaComment != null) {
					%>
							<div><%=qnaComment.getQnaCommentContent() %></div>
							<!-- 삭제 만드는데 jquery로 해보고 안되면 말기 -->
					<%
						} else {
							// 관리자일때 댓글입력창 보이게함
							if(loginMember.getMemberLevel() > 0) {
					%>
								<form action="<%=request.getContextPath() %>/admin/insertQnaCommentAction.jsp" method="post">
									<input type="text" hidden="hidden" name = "qnaNo" value="<%=returnQna.getQnaNo()%>"> <!--액션으로 넘기고 안보이게-->
									<input type="text" hidden="hidden" name = "memberNo" value="<%=loginMember.getMemberNo()%>">
									<textarea name="qnaCommentContent"></textarea>
									<button type="submit">입력</button>
								</form>	
					<% 			
							}
						}
					%>
				</div>
			<%
			// 작성자이거나 관리자가 아닐때
			} else { %>
				이 글은 비밀글입니다. 
			<% }
		// 비밀글이 아닐때
		} else {
		%>
		<table class="table" style="text-align: center;">
			<tr>
				<td>QnANo</td>
				<td><%=returnQna.getQnaNo() %></td>
			</tr>
			<tr>
				<td>QnACategory</td>
				<td><%=returnQna.getQnaCategory() %></td>
			</tr>
			<tr>
				<td>QnaTitle</td>
				<td><%=returnQna.getQnaTitle()%></td>
			</tr>
			<tr>
				<td>QnASecret</td>
				<td><%=returnQna.getQnaSecret() %></td>
			</tr>
			<tr>
				<td>QnaContent</td>
				<td><%=returnQna.getQnaContent()%></td>
			</tr>
			<tr>
				<td>Create</td>
				<td><%=returnQna.getCreateDate()%></td>
			</tr>
		</table>
		
		<div>
			<h2>Comment</h2>
			<div><%=qnaComment.getQnaCommentContent() %></div>
		</div>
	<%
		}
	%>
	</div>
</body>
</html>