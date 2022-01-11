package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Member;

public class MemberDao {
	
	// [회원] 멤버 아이디 중복 검사
	public String selectMemberId(String memberIdCheck) throws ClassNotFoundException, SQLException {
		String memberId = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId FROM member WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberIdCheck);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			memberId = rs.getString("memberId");
		}
		rs.close();
		stmt.close();
		return memberId; // null -> 사용가능한ID, 아니면 이미 사용중인 ID
	}
	
	// [관리자] 회원 비밀번호 수정
	public void updateMemberPwByAdmin(Member member) throws ClassNotFoundException, SQLException {
		// debug
		System.out.println(member.getMemberNo() + " <-- MemberDao.updateMemberPwByAdmin param memberNo");
		System.out.println(member.getMemberPw() + " <-- MemberDao.updateMemberPwByAdmin param MemberPw");

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		String sql = "UPDATE member SET member_pw=PASSWORD(?) WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberPw());
		stmt.setInt(2, member.getMemberNo());
		ResultSet rs = stmt.executeQuery();
		// debug
		System.out.println(stmt + " <-- MemberDao.updateMemberPwByAdmin stmt");
		System.out.println(rs + " <-- MemberDao.updateMemberPwByAdmin rs");

		rs.close();
		stmt.close();
		conn.close();
	}

	// [관리자] 회원 강제탈퇴
	public void deleteMemberByAdmin(int memberNo) throws ClassNotFoundException, SQLException {
		// debug
		System.out.println(memberNo + " <-- MemberDao.deleteMemberByAdmin param memberNo");

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		String sql = "DELETE FROM member WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		ResultSet rs = stmt.executeQuery();
		// debug
		System.out.println(stmt + " <-- MemberDao.deleteMemberByAdmin stmt");
		System.out.println(rs + " <-- MemberDao.deleteMemberByAdmin rs");

		rs.close();
		stmt.close();
		conn.close();
	}

	// [관리자] 회원 등급 수정
	public void updateMemberLevelByAdmin(Member member) throws ClassNotFoundException, SQLException {
		// debug
		System.out.println(member.getMemberNo() + " <-- MemberDao.updateMemberLevelByAdmin param memberNo");
		System.out.println(member.getMemberLevel() + " <-- MemberDao.updateMemberLevelByAdmin param MemberLevel");

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		String sql = "UPDATE member SET member_level=? WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, member.getMemberLevel());
		stmt.setInt(2, member.getMemberNo());
		ResultSet rs = stmt.executeQuery();
		// debug
		System.out.println(stmt + " <-- MemberDao.updateMemberLevelByAdmin stmt");
		System.out.println(rs + " <-- MemberDao.updateMemberLevelByAdmin rs");

		rs.close();
		stmt.close();
		conn.close();
	}

	// [회원] 회원정보 상세 조회
	public Member selectMemberOne(int memberNo) throws ClassNotFoundException, SQLException {
		// debug
		System.out.println(memberNo + " <-- MemberDao.selectMemberOne param memberNo");

		Member member = null;

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_pw memberPw, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			member = new Member();
			member.setMemberNo(rs.getInt("memberNo"));
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberPw(rs.getString("memberPw"));
			member.setMemberName(rs.getString("memberName"));
			member.setMemberAge(rs.getInt("memberAge"));
			member.setMemberGender(rs.getString("memberGender"));
			member.setCreateDate(rs.getString("updateDate"));
			member.setUpdateDate(rs.getString("createDate"));
		}
		rs.close();
		stmt.close();
		conn.close();

		return member;
	}

	// [관리자] 회원 리스트 관리(회원목록출력)
	public ArrayList<Member> selectMemberListAllBySearchMemberId(int beginRow, int rowPerPage, String searchMemberId)
			throws ClassNotFoundException, SQLException {
		ArrayList<Member> list = new ArrayList<Member>();
		System.out.println(beginRow + "<<beinRow");
		System.out.println(rowPerPage + "<<rowPerPage");
		/*
		 * SELECT member_no memberNo, member_id memberId, member_level memberLevel,
		 * member_name memberName, member_age memberAge, member_gender memberGender,
		 * update_date updateDate, create_date createDate FROM member WHERE member_id
		 * LIKE ? ORDER BY create_date DESC LIMIT ?,?
		 */

		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member WHERE member_id LIKE ? ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + searchMemberId + "%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		// 리스트에 값 넣기
		while (rs.next()) {
			Member member = new Member();
			member.setMemberNo(rs.getInt("memberNo"));
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberName(rs.getString("memberName"));
			member.setMemberAge(rs.getInt("memberAge"));
			member.setMemberGender(rs.getString("memberGender"));
			member.setUpdateDate(rs.getString("updateDate"));
			member.setCreateDate(rs.getString("createDate"));
			list.add(member);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
	}

	// [관리자] 회원 리스트 관리(회원목록출력)
	public ArrayList<Member> selectMemberListAllByPage(int beginRow, int rowPerPage)
			throws ClassNotFoundException, SQLException {
		ArrayList<Member> list = new ArrayList<Member>();
		System.out.println(beginRow + "<<beinRow");
		System.out.println(rowPerPage + "<<rowPerPage");
		/*
		 * SELECT member_no memberNo, member_id memberId, member_level memberLevel,
		 * member_name memberName, member_age memberAge, member_gender memberGender,
		 * update_date updateDate, create_date createDate FROM member ORDER BY
		 * create_date DESC LIMIT ?,?
		 */
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		// 리스트에 값 넣기
		while (rs.next()) {
			Member member = new Member();
			member.setMemberNo(rs.getInt("memberNo"));
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberName(rs.getString("memberName"));
			member.setMemberAge(rs.getInt("memberAge"));
			member.setMemberGender(rs.getString("memberGender"));
			member.setUpdateDate(rs.getString("updateDate"));
			member.setCreateDate(rs.getString("createDate"));
			list.add(member);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
	}

	// 총 멤버 수
	public int totalMemberCount() throws ClassNotFoundException, SQLException {
		int totalCount = 0;
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리생성, 실행
		String sql = "SELECT count(*) FROM member";
		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			totalCount = rs.getInt("count(*)");
		}

		return totalCount;
	}

	// [비회원]
	public void insertMember(Member member) throws ClassNotFoundException, SQLException {

		System.out.println(member.getMemberId() + "<<memberId");
		System.out.println(member.getMemberPw() + "<<memberPw");
		System.out.println(member.getMemberName() + "<<memberName");
		System.out.println(member.getMemberAge() + "<<memberAge");
		System.out.println(member.getMemberGender() + "<<memberGender");
		/*
		 * INSERT INTO member(member_id,
		 * member_pw,member_level,member_name,member_age,member_gender,update_date,
		 * create_date) VALUES(?,PASSWORD(?),0,?,?,?,NOW(),NOW())
		 */
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member(member_id, member_pw,member_level, member_name, member_age, member_gender, update_date, create_date) VALUES (?, PASSWORD(?), 0, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		stmt.setInt(4, member.getMemberAge());
		stmt.setString(5, member.getMemberGender());
		System.out.println(stmt + "<<stmt");
		int row = stmt.executeUpdate();
		if (row == 1) {
			System.out.println("입력완료");
		}
		stmt.close();
		conn.close();
	}

	// [회원]
	public Member login(Member member) throws ClassNotFoundException, SQLException {
		Member returnMember = null;
		/*
		 * SELECT member_no memberNo, member_id memberId, member_level memberLevel FROM
		 * member WHERE member_id=? AND member_pw=PASSWORD(?)
		 */
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel FROM member WHERE member_id=? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		System.out.println(stmt + "<<stmt");
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			returnMember = new Member();
			returnMember.setMemberNo(rs.getInt("memberNo"));
			returnMember.setMemberId(rs.getString("memberId"));
			returnMember.setMemberLevel(rs.getInt("memberLevel"));
			return returnMember;
		}
		System.out.println(rs + "<<rs");
		rs.close();
		stmt.close();
		conn.close();
		return returnMember;
	}
}
