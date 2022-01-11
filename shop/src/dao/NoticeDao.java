package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Notice;

public class NoticeDao {
	
	// [관리자] 공지사항 수정
	public boolean updateNoticeByAdmin(Notice notice) throws ClassNotFoundException, SQLException {
		boolean result = false;
		
		System.out.println("[DEBUG] NoticeDao.updateNotice noticeNo : " + notice.getNoticeNo());
		System.out.println("[DEBUG] NoticeDao.updateNotice noticeTitle : " + notice.getNoticeTitle());
		System.out.println("[DEBUG] NoticeDao.updateNotice noticeContent : " + notice.getNoticeContent());
		System.out.println("[DEBUG] NoticeDao.updateNotice memberNo : " + notice.getMemberNo());
	
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리생성 및 실행
		String sql = "UPDATE notice SET notice_title=?, notice_content=?, member_no=?, update_date=now() WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getMemberNo());
		stmt.setInt(4, notice.getNoticeNo());
		int row = stmt.executeUpdate();
		if(row == 1) {
			result = true;
		}
		stmt.close();
		conn.close();
		
		return result;
	}
	// [관리자] 공지사항 삭제
	public void deleteNotice(int noticeNo) throws ClassNotFoundException, SQLException {
		System.out.println("[DEBUG] noticeNo :" + noticeNo);
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리생성 및 실행
		String sql = "DELETE FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		System.out.println("[DEBUG] NoticeDao.delectNotice stmt : " + stmt);
		System.out.println("[DEBUG] NoticeDao.delectNotice rs : " + rs);
		
		rs.close();
		stmt.close();
		conn.close();
	}
	// [관리자] 공지사항 입력
	public boolean insertNoticeByAdmin(Notice notice) throws ClassNotFoundException, SQLException {
		boolean result = false;
		System.out.println("[DEBUG] NoticeDao.insertNotice noticeTitle : " + notice.getNoticeTitle());
		System.out.println("[DEBUG] NoticeDao.insertNotice noticeContent : " + notice.getNoticeContent());
		System.out.println("[DEBUG] NoticeDao.insertNotice memberNo : " + notice.getMemberNo());

		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리생성 및 실행
		String sql = "INSERT INTO notice(notice_title, notice_content, member_no, update_date, create_date) VALUES (?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3,notice.getMemberNo());
		System.out.println("[DEBUG] NoticeDao.insertNotice stmt :" + stmt);
		int row = stmt.executeUpdate();
		if(row == 1) {
			result = true;
		}
		//접속종료
		stmt.close();
		conn.close();
		
		return result;
	}
	
	// [공통] 제목 누르면 세부내용으로 들어가는
	public Notice selectNoticeOne(int noticeNo) throws ClassNotFoundException, SQLException {
		// notice객체를 사용하기 위해 null로 초기화
		Notice notice = null;
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리생성 및 실행
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_Content noticeContent, member_no memberNo, create_date createDate, update_date updateDate FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setMemberNo(rs.getInt("memberNo"));
			notice.setCreateDate(rs.getString("createDate"));
			notice.setUpdateDate(rs.getString("updateDate"));
		}
		// 접속종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return notice;
	}
	// [공통] 공지사항 리스트 출력
	public ArrayList<Notice> selectNoticeList() throws ClassNotFoundException, SQLException {
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리생성 및 실행
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, member_no memberNo, create_date createDate, update_date updateDate FROM notice ORDER BY create_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		// 리스트에 값 넣기
		while(rs.next()) {
			Notice noticeResult = new Notice();
			noticeResult.setNoticeNo(rs.getInt("noticeNo"));
			noticeResult.setNoticeTitle(rs.getString("noticeTitle"));
			noticeResult.setNoticeContent(rs.getString("noticeContent"));
			noticeResult.setMemberNo(rs.getInt("memberNo"));
			noticeResult.setCreateDate(rs.getString("createDate"));
			noticeResult.setUpdateDate(rs.getString("updateDate"));
			list.add(noticeResult);
		}
		// 접속종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
		
	}
}
