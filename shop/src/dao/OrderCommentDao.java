package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.OrderComment;

public class OrderCommentDao {
	
	public int selectCommentListLastPage(int ROW_PER_PAGE, int ebookNo) throws ClassNotFoundException, SQLException{
		int totalCount = 0;
		int lastPage = 0;
		
		// 매개변수 값을 디버깅
		System.out.println(ROW_PER_PAGE + "<--- OrderCommentDao.selectCommentListLastPage parem : ROW_PER_PAGE");
		System.out.println(ebookNo + "<--- OrderCommentDao.selectCommentListLastPage parem : ebookNo");
		
		// dbUtil 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT count(*) FROM order_comment WHERE ebook_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		
		ResultSet rs = stmt.executeQuery();
		// 디버깅 : 쿼리내용과 표현식의 파라미터값 확인가능
		System.out.println("총 행의 개수 stmt : "+stmt);
		
		// totalCount 저장
		if(rs.next()) {
			totalCount = rs.getInt("count(*)");
		}
		System.out.println("totalCounnt(총 행의 개수) : "+totalCount);
				
		// 마지막 페이지
		// lastPage를 전체 행의 수와 한 페이지에 보여질 행의 수(rowPerPage)를 이용하여 구한다
		lastPage = totalCount / ROW_PER_PAGE;
		if(totalCount % ROW_PER_PAGE != 0) {
			lastPage+=1;
			}
		System.out.println("lastPage(마지막 페이지 번호) : "+lastPage);
				
		rs.close();
		stmt.close();
		conn.close();
				
		return lastPage;
	}
	
	public ArrayList<OrderComment> selectCommentList(int beginRow, int rowPerPage, int ebookNo) throws ClassNotFoundException, SQLException{
		// list라는 리스트를 사용하기 위해 생성
		ArrayList<OrderComment> list = new ArrayList<OrderComment>();
		
		// 매개변수 값을 디버깅
		System.out.println(beginRow + "<--- OrderCommentDao.selectCommentList parem : beginRow");
		System.out.println(rowPerPage + "<--- OrderCommentDao.selectCommentList parem : rowPerPage");
		System.out.println(ebookNo + "<--- OrderCommentDao.selectCommentList parem : ebookNo");
		
		// DB 실행
		// dbUtil 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT order_score orderScore, order_comment_content orderCommentContent, create_date createDate FROM order_comment WHERE ebook_no=? ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		
		// 디버깅 코드 : 쿼리내용과 표현식의 파라미터값 확인가능
		System.out.println(stmt + "<--- stmt");
		
		// 데이터 가공 (자료구조화)
		// ResultSet이라는 특수한 타입에서 ArrayList라는 일반화된 타입으로 변환(가공)
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			// ebook 객체 생성 후 저장
			OrderComment orderComment = new OrderComment();
			orderComment.setOrderScore (rs.getInt("orderScore"));
			orderComment.setOrderCommentContent (rs.getString("orderCommentContent"));
			orderComment.setCreateDate (rs.getString("createDate"));
			list.add(orderComment);
		}
		// 종료
		rs.close();
		stmt.close();
		conn.close();
				
		//list를 return
		return list;
	}
	
	
	public double selectOrderScoreAvg(int ebookNo) throws SQLException, ClassNotFoundException{
		double avgScore = 0;
		DBUtil dbutil = new DBUtil();
		String sql = "select avg(order_score) av from order_comment where ebook_no=? order by ebook_no";
		Connection conn = dbutil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			avgScore = rs.getDouble("av");
		}
		rs.close();
		stmt.close();
		conn.close();
		return avgScore;
	}
	
	//[all] 
	public void insertOrderCommentReview(OrderComment comment) throws SQLException, ClassNotFoundException {
		
		DBUtil dbutil = new DBUtil();
		int check = 0; //실행성공 여부 확인 
		System.out.println(comment.getOrderNo()+"<------dao.insertOrderCommentReview - getOrderNo");
		System.out.println(comment.getEbookNo()+"<------dao.insertOrderCommentReview - getEbookNo");
		System.out.println(comment.getOrderScore()+"<------dao.insertOrderCommentReview - getOrderScore");
		System.out.println(comment.getOrderCommentContent()+"<------dao.insertOrderCommentReview - getOrderCommentContent");
		//파라미터 확인
		Connection conn = dbutil.getConnection();
		String sql ="INSERT INTO order_comment(order_no, ebook_no, order_score, order_comment_content, create_date, update_date) VALUES(?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setInt(1,comment.getOrderNo());
		stmt.setInt(2, comment.getEbookNo());
		stmt.setInt(3, comment.getOrderScore());
		stmt.setString(4, comment.getOrderCommentContent());
		System.out.println(stmt+"<------dao.insertOrderCommentReview - stmt"); //쿼리 및 파라미터 확인
		check = stmt.executeUpdate(); // 확인용
		if(check == 1) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
		stmt.close();
		conn.close();
		
		return;
		
	}
}