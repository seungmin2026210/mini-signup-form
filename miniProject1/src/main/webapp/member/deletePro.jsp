<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
</head>
<body>


<%

String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");

//1단계 JDBC안에 있는 Driver 프로그램 불러오기
Class.forName("com.mysql.cj.jdbc.Driver");

//2단계 Driver 프로그램 이용해서 디비연결
String dbUrl="jdbc:mysql://localhost:3306/minidb1";
String dbUser="root";
String dbPass="1234";
Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);

//3단계 SQL구문 만들어서 실행할 준비(select)
String sql = "select * from memberlist where id=? and pass=?";
PreparedStatement pstmt=con.prepareStatement(sql);
pstmt.setString(1, id);
pstmt.setString(2, pass);

ResultSet rs = pstmt.executeQuery();

if(rs.next()){
	
	String sql2="delete from memberlist where id=?";
	PreparedStatement pstmt2=con.prepareStatement(sql2);
	pstmt2.setString(1, id);
	//4단계 SQL구문을 실행(insert,update,delete)
	pstmt2.executeUpdate();

	//세션값 초기화 
	session.invalidate();
	
	//main.jsp 이동 
	response.sendRedirect("loginForm.jsp");
} else {
%>
<script type="text/javascript">
	alert("비밀번호가 일치하지 않습니다.");
	history.back();
</script>

<%
}
%>


</body>
</html>