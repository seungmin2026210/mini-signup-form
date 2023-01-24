<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.mysql.cj.xdevapi.PreparableStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>

<%

request.setCharacterEncoding("utf-8");
//폼에서 입력한 내용이 서버에 전달 -> request 내장객체 저장
String id = request.getParameter("id");
String pass = request.getParameter("pass");

//1단계 jdbc안에 있는 driver 프로그램 불러오기
Class.forName("com.mysql.cj.jdbc.Driver");

//2단계 Driver 프로그램 이용해서 db연결
String dbUrl="jdbc:mysql://localhost:3306/minidb1";
String dbUser="root";
String dbPass="1234";
Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);

//3단계 sql 구문 만들어서 실행 할 준비 
String sql = "select * from memberlist where id=? and pass=?";
PreparedStatement pstmt = con.prepareStatement(sql);

pstmt.setString(1,id);
pstmt.setString(2,pass);

//4단계 sql구문 실행 (select) -> 결과 저장
ResultSet rs = pstmt.executeQuery();


//5단계 결과 출력, 데이터 담기(select)

if(rs.next()){
	session.setAttribute("id", id); //아이디가 있으면 세션값 생성
	response.sendRedirect("main.jsp");
} else {
	%>
	<script type="text/javascript">
		alert("아이디 비밀번호가 일치하지 않습니다.");
		history.back();
	</script>
	<%
}
%>


</body>
</html>