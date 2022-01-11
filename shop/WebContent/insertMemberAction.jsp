<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*"%>
<%
	request.setCharacterEncoding("utf-8");
//로그인시 접근불가(로그인상태와 회원가입정보가 null일때 접근 불가)
	if(session.getAttribute("loginMember")!=null){	//로그인이 된 상태(로그인멤버값이 null인 상태)
		//브라우저에게 다른곳을 '요청'(위치로 보내는 것(go)이 아닌(보내주는 것이 아니라 간 것) 해당 위치로 내보내는(rollback) 것(쫒아내는 것,되돌리는 것))
		response.sendRedirect(request.getContextPath()+"/index.jsp");	//로그인이 된 상태니 인덱스로
		return;	//if문 이후 코드가 작동하지 않도록 값 리턴
	}
	//회원가입 유효성 검사(위의 방어코드와 한번에 적는 것이 좋으나 보기편하게 분할)null일 시
	if(request.getParameter("memberId")==null||request.getParameter("memberPw")==null||request.getParameter("memberName")==null||request.getParameter("memberAge")==null||request.getParameter("memberGender")==null){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");	//회원정보가 없으니 인서트멤버폼으로 
		return;	//if문 이후 코드가 작동하지 않도록 값 리턴
	}
	
	//회원가입 유효성검사(위의 방어코드와 한번에 적는 것이 좋으나 보기편하게 분할)값이 ""(공백 값)일 시
	if(request.getParameter("memberId").equals("")||request.getParameter("memberPw").equals("")||request.getParameter("memberName").equals("")||request.getParameter("memberAge").equals("")||request.getParameter("memberGender").equals("")){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");	//회원정보가 없으니 인서트멤버폼으로 
		return;	//if문 이후 코드가 작동하지 않도록 값 리턴
	}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	String memberGender = request.getParameter("memberGender");
	//디버깅 request매게값 디버깅코드
	System.out.println("memberId :"+memberId);
	System.out.println("memberPw :"+memberPw);
	System.out.println("memberName :"+memberName);
	System.out.println("memberAge :"+memberAge);
	System.out.println("memberGender :"+memberGender);
	
	Member member = new Member();
	//request parma => member bo로 보냄
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	member.setMemberAge(memberAge);
	member.setMemberGender(memberGender);
			
	MemberDao memberDao = new MemberDao();
	
	memberDao.insertMember(member);
	
	response.sendRedirect(request.getContextPath()+"/index.jsp");

%>