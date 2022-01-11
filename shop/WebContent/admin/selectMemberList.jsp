<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%	
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	//사용자(일반 회원)들 리스트는 관리자만 출입
	//방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	//로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;	//없으면 아래 ~~님 반갑습니다 쪽에 오류
	}
	
	// 검색어
	String searchMemberId = "";
	if(request.getParameter("searchMemberId")!=null){
		searchMemberId = request.getParameter("searchMemberId");
	}
	System.out.println(searchMemberId+" <--selectMemberList searchMemberId");
	
	//페이지
	int currentPage = 1;
	//currentPage는 값이 들어오면 1대신 그 값으로 바뀜
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+" <--selectMemberList currentPage");
	//상수(fianl) <== rowPerPage변수 10으로 초기화되면 끝까지 10이다(변하지 않음),대문자와 스네이크 표현식으로 표시한 이유는 다른사람에게 식별하기 쉽게 하기 위해서 사용
	final int ROW_PER_PAGE = 10;
	
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	 
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = null;
	if(searchMemberId.equals("") == true) { // 검색어가 없을때
		memberList = memberDao.selectMemberListAllByPage(beginRow, ROW_PER_PAGE);
	} else { // 검색어가 있을때
		memberList = memberDao.selectMemberListAllBySearchMemberId(beginRow, ROW_PER_PAGE, searchMemberId);
	}

	int totalCount = memberDao.totalMemberCount();
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>사용자(회원) 목록</title>
</head>
<body>
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<div align='center'>
	<br>
	
	<h4>회원 목록</h4>
	<table class="table">
		<thead>
			<tr>
			 	<th>memberNo</th>
			 	<th>memberId</th>
			 	<th>memberLevel</th>
			 	<th>memberName</th>
			 	<th>memberAge</th>
			 	<th>memberGender</th>
			 	<th>updateDate</th>
			 	<th>createDate</th>
			 	<th>등급수정</th>
			 	<th>비밀번호수정</th>
			 	<th>강제탈퇴</th>
			</tr>
		</thead>
		<tbody>
			<%
			for(Member m : memberList){
			%>
			<tr>
				<td><%=m.getMemberNo()%></td>
				<td><%=m.getMemberId()%></td>
				<td>
					<%	//level이 0,1로 출력되니 일반 회원,관리자 계정으로 출력되도록 함
						if(m.getMemberLevel()==0){
					%>
							<span>일반 회원</span>
					<%
						}else if(m.getMemberLevel()==1){
					%>
							<span>관리자 계정</span>
					<%
						}
					%>
					(<%=m.getMemberLevel()%>)
				</td>
				<td><%=m.getMemberName()%></td>
				<td><%=m.getMemberAge()%></td>
				<td><%=m.getMemberGender()%></td>
				<td><%=m.getUpdateDate()%></td>
				<td><%=m.getCreateDate()%></td>
				<td>
					<!-- 특정회원의 등급을 수정 -->
					<a href="<%=request.getContextPath()%>/admin/updateMemberLevelForm.jsp?memberNo=<%=m.getMemberNo()%>">등급수정</a>
				</td>
			 	<td>
			 		<!-- 특정회원의 비밀번호를 수정 -->
			 		<a href="<%=request.getContextPath()%>/admin/updateMemberPwForm.jsp?memberNo=<%=m.getMemberNo()%>">비밀번호수정</a>
			 	</td>
			 	<td>
			 		<!-- 특정회원을 강제 탈퇴 -->
			 		<a href="<%=request.getContextPath()%>/admin/deleteMember.jsp?memberNo=<%=m.getMemberNo()%>">강제탈퇴</a>
			 	</td>
			</tr>
			<%	
			}
			%>
		</tbody>
	</table>
	<div>
	<%
		// ISSUE : 페이지 잘되었는데... 검색한후 페이징하면 안된다 -> ISSUE 해결
		if (currentPage > 1) {
	%>
		<a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=currentPage-1%>&searchMemberId=<%=searchMemberId%>">이전</a>
	<%
		}
	%>
	<%		
		int lastPage = totalCount / ROW_PER_PAGE;
		
		if (totalCount % ROW_PER_PAGE != 0) {
			lastPage += 1;
		}
	
		if (currentPage < lastPage) {
	%>
		<a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=currentPage+1%>&searchMemberId=<%=searchMemberId%>">다음</a>
	<%
	}
	%>
	</div>
	<!-- memberId로 검색 -->
	<div>
		<form action="<%=request.getContextPath()%>/admin/selectMemberList.jsp" method="get">
			memberId :
			<input type="text" name="searchMemberId">
			<button type="submit">검색</button>
		</form>
	</div>
</div>
</body>
</html>









