<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	//로그인 session확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 로그인 멤버값이 없을때 접근불가
	if(loginMember==null){
		System.out.println("로그인필요");
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	// qnaNo가 null일경우 돌아가는 방어코드
	if(request.getParameter("qnaNo") == null) {
		response.sendRedirect("./selectQnaList.jsp");
		return;
	}
	// request값 저장
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	//dao
	QnaDao qnaDao = new QnaDao();
	Qna qna = qnaDao.selectQnaOne(qnaNo);
	
	// Qna을 SELECT하는 qnaDao의 selectQnaOne 메서드
	// 성공시 : returnQna라는 객체에 저장시켜서 출력
	// 실패시 : null
	Qna returnQna = qnaDao.selectQnaOne(qnaNo);
	if(returnQna==null) {
		System.out.println("Qna 불러오기 실패");
		response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
	} else {
		System.out.println("Qna 불러오기 성공");
		System.out.println("[DEBUG] returnQna.getQnaNo() : " + returnQna.getQnaNo());
		System.out.println("[DEBUG] returnQna.getQnaTitle() : " + returnQna.getQnaTitle());
		System.out.println("[DEBUG] returnQna.getQnaCategory() : " + returnQna.getQnaCategory());
		System.out.println("[DEBUG] returnQna.getQnaContent() : " + returnQna.getQnaContent());
		System.out.println("[DEBUG] returnQna.getCreateDate() : " + returnQna.getCreateDate());	
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% if(loginMember.getMemberLevel() < 1) { %>
	<!-- 사용자가 접속 시 사용자 메뉴 출력 -->
	<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	<%	} else { %>
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<%	} %>
	
	<form method="post" action="<%=request.getContextPath() %>/updateQnaAction.jsp">
		<h1>Qna 수정</h1>
			<table>
				<tr>
					<td>QnaNo</td>
					<td><input type="text" name="qnaNo" value="<%=qna.getQnaNo() %>" readonly="readonly"></td>
				</tr>
				<tr>
					<td>QnaTitle</td>
					<td><input type="text" name="qnaTitle" value="<%=qna.getQnaTitle() %>"></td>
				</tr>
				<tr>
					<td>QnaCategory</td>
					<td>
						<input type="radio" class="qnaCategory" name="qnaCategory" value="전자책관련">전자책관련
						<input type="radio" class="qnaCategory" name="qnaCategory" value="개인정보관련">개인정보관련
						<input type="radio" class="qnaCategory" name="qnaCategory" value="기타">기타
					</td>
				</tr>
				<tr>
					<td>QnaContent</td>
					<td><textarea name="qnaContent" class="form-control" cols="30" rows="10" value="<%=returnQna.getQnaContent()%>"><%=returnQna.getQnaContent()%></textarea></td>	
				</tr>
			</table>
			<button type="submit">수정하기</button>
			<a href="<%=request.getContextPath()%>/selctQnaOne.jsp">돌아가기</a>
	</form>
</body>
</html>