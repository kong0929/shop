package commons;

import java.sql.*;
public class DBUtil {
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://13.125.215.13/shop", "root", "java1004");
		return conn;
	}
}