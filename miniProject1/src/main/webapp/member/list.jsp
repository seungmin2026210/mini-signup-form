<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 조회</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
	<link href="listCss.css" rel="stylesheet" type="text/css">
</head>
<body>
<body>
	<h1>
		<img src="heart.png" width="100" height="auto">
	</h1>
<%
//1단계 JDBC안에 있는 Driver 프로그램 불러오기
Class.forName("com.mysql.cj.jdbc.Driver");

//2단계 Driver 프로그램 이용해서 디비연결
String dbUrl="jdbc:mysql://localhost:3306/minidb1";
String dbUser="root";
String dbPass="1234";
Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);

//3단계 SQL구문 만들어서 실행할 준비(insert)
String sql = "select * from memberlist";
PreparedStatement pstmt = con.prepareStatement(sql);

//4단계 SQL구문을 실행 -> 결과 저장
ResultSet rs = pstmt.executeQuery();

%>
	
	<form id="list" action="main.jsp" method="post">
		<fieldset>
			<h3>Members List</h3>
			<div class="list">
			<table>
				<tr><th>아이디</th><th>이름</th><th>닉네임</th><th>가입일</th>
				</tr>
			<%
			while(rs.next()){
			%>
				<tr><td><%=rs.getString("id") %></td>
					<td><%=rs.getString("name") %></td>
					<td><%=rs.getString("nickname") %></td>
					<td><%=rs.getTimestamp("join_date") %></td>
				</tr>
			<%
			}
			%>
			</table>
			</div><br>
			<div class="submit">
				<button type="submit">이전으로 돌아가기</button>
			</div>
		</fieldset>
	</form>
</body>
</html>