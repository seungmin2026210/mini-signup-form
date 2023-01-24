<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
	<link href="mainCss.css" rel="stylesheet" type="text/css">
</head>
<body>

   <h1>
      <img src="heart.png" width="100" height="auto">
   </h1>
   
  <%
//session안에 있는 id값을 가져와서 사용
String id = (String)session.getAttribute("id");

//1단계 JDBC안에 있는 Driver 프로그램 불러오기
Class.forName("com.mysql.cj.jdbc.Driver");

//2단계 Driver 프로그램 이용해서 디비연결
String dbUrl="jdbc:mysql://localhost:3306/minidb1";
String dbUser="root";
String dbPass="1234";
Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);

//3단계 SQL구문 만들어서 실행할 준비(insert)
String sql = "select * from memberlist where id=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1,id);

//4단계 SQL구문을 실행 -> 결과 저장
ResultSet rs = pstmt.executeQuery();

//5.결과 출력, 데이터 담기 (select)
if(rs.next()){
%> 
   
   
   
         <div class="submit">
     <h3> <%=rs.getString("nickname") %> <br> Welcome ! </h3> <br>
     
         <div class="button_div">
            <button type="button" onclick="location.href = 'myPage.jsp' ">마이페이지</button><br>
            <button type="button" onclick="location.href = 'list.jsp' ">회원목록</button><br>
            <button type="button" onclick="location.href = 'logout.jsp' ">로그아웃</button><br>
         </div>
	</div>
	
<%
}
%>
	
</body>
</html>