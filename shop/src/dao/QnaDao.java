package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Qna;

public class QnaDao {
	// [회원, 관리자] QnA 삭제
	public void deleteQna(int qnaNo) throws ClassNotFoundException, SQLException {
		System.out.println("[DEBUG] QnaDao.delectQna QnaNo :" + qnaNo);
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리생성 및 실행
		String sql = "DELETE FROM qna WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		ResultSet rs = stmt.executeQuery();
		System.out.println("[DEBUG] NoticeDao.delectQna stmt : " + stmt);
		System.out.println("[DEBUG] NoticeDao.delectQna rs : " + rs);
		
		rs.close();
		stmt.close();
		conn.close();
	}
	// [회원, 관리자] QnA 수정
	public boolean updateQna(Qna qna) throws ClassNotFoundException, SQLException {
		boolean result = false;
		
		System.out.println("[DEBUG] QnaDao.updateQna qnaNo : " + qna.getQnaNo());
		System.out.println("[DEBUG] QnaDao.updateQna qnaCategory : " + qna.getQnaCategory());
		System.out.println("[DEBUG] QnaDao.updateQna qnaTitle : " + qna.getQnaTitle());
		System.out.println("[DEBUG] QnaDao.updateQna qnaContent : " + qna.getQnaContent());
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리생성 및 실행
		String sql = "UPDATE qna SET qna_category=?, qna_title=?, qna_content=?, update_date=now() WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qna.getQnaCategory());
		stmt.setString(2, qna.getQnaTitle());
		stmt.setString(3, qna.getQnaContent());
		stmt.setInt(4, qna.getQnaNo());
		int row = stmt.executeUpdate();
		if(row == 1) {
			result = true;
		}
		stmt.close();
		conn.close();
		return result;
	}
	// [회원] QnA 입력
	public boolean insertQna(Qna qna) throws ClassNotFoundException, SQLException {
		boolean result = false;
		System.out.println("[DEBUG] QnaDao.insertQna : " + qna.toString());
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리생성 및 실행
		String sql = "INSERT INTO qna(qna_category, qna_title, qna_content, qna_secret, member_no, update_date, create_date) VALUES (?,?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qna.getQnaCategory());
		stmt.setString(2, qna.getQnaTitle());
		stmt.setString(3, qna.getQnaContent());
		stmt.setString(4, qna.getQnaSecret());
		stmt.setInt(5, qna.getMemberNo());
		System.out.println("[DEBUG] NoticeDao.insertNotice stmt :" + stmt);
		int row = stmt.executeUpdate();
		if(row == 1) {
			result = true;
		}
		// 접속종료
		stmt.close();
		conn.close();
		
		return result;
	}
	// [공통] QnA 세부정보 출력
	public Qna selectQnaOne(int qnaNo) throws ClassNotFoundException, SQLException {
		// qna 객체를 사용하기 위해 null로 초기화
		Qna qna = null;
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리생성 및 실행
		String sql = "SELECT qna_no qnaNo, qna_category qnaCategory,qna_title qnaTitle, qna_content qnaContent, qna_secret qnaSecret, member_no memberNo, create_date createDate, update_date updateDate FROM qna WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategory(rs.getString("qnaCategory"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			qna.setMemberNo(rs.getInt("memberNo"));
			qna.setCreateDate(rs.getString("createDate"));
			qna.setUpdateDate(rs.getString("updateDate"));
		}
		// 접속종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return qna;
	}
	
	// [공통] QnA 리스트 출력
	public ArrayList<Qna> selectQnaList() throws ClassNotFoundException, SQLException {
		ArrayList<Qna> list = new ArrayList<Qna>();
			
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리생성 및 실행
		String sql = "SELECT qna_no qnaNo, qna_category qnaCategory, qna_title qnaTitle, qna_content qnaContent, qna_secret qnaSecret, member_no memberNo, create_date createDate, update_date updateDate FROM qna ORDER BY create_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		// 리스트에 값 넣기
		while(rs.next()) {
			Qna qnaResult = new Qna();
			qnaResult.setQnaNo(rs.getInt("qnaNo"));
			qnaResult.setQnaCategory(rs.getString("qnaCategory"));
			qnaResult.setQnaTitle(rs.getString("qnaTitle"));
			qnaResult.setQnaContent(rs.getString("qnaContent"));
			qnaResult.setQnaSecret(rs.getString("qnaSecret"));
			qnaResult.setMemberNo(rs.getInt("memberNo"));
			qnaResult.setCreateDate(rs.getString("createDate"));
			qnaResult.setUpdateDate(rs.getString("updateDate"));
			list.add(qnaResult);
		}
		// 접속종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
		}
}
