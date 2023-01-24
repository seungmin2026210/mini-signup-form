<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>


<%
//폼에서 입력한 내용이 서버에 전달 => request 내장객체 저장
//request 한글처리
request.setCharacterEncoding("utf-8");

//request 태그이름에 해당하는 값을 가져오기 => 변수에 저장
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String nickname = request.getParameter("nickname");
String birth = request.getParameter("birth");
String gender = request.getParameter("gender");
String chbox = request.getParameter("chbox"); // 체크박스 객체 수신은 컬렉션 형태의 자료 

String address = request.getParameter("address");
String address_detail = request.getParameter("address_detail");
Timestamp join_date = new Timestamp(System.currentTimeMillis());

//1단계 JDBC안에 있는 Driver 프로그램 불러오기
Class.forName("com.mysql.cj.jdbc.Driver");

//2단계 Driver 프로그램 이용해서 디비연결
String dbUrl="jdbc:mysql://localhost:3306/minidb1";
String dbUser="root";
String dbPass="1234";
Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);

//3단계 SQL구문 만들어서 실행할 준비(insert)
String sql = "insert into memberlist (id,pass,name,nickname,address,address_detail,birth,gender,join_date) values(?,?,?,?,?,?,?,?,?)";
PreparedStatement pstmt = con.prepareStatement(sql);

pstmt.setString(1, id);
pstmt.setString(2, pass);
pstmt.setString(3, name);
pstmt.setString(4, nickname);
pstmt.setString(5, address);
pstmt.setString(6, address_detail);
pstmt.setString(7, birth);
pstmt.setString(8, gender);
pstmt.setTimestamp(9, join_date);

//4단계 SQL구문을 실행(insert,update,delete)
pstmt.executeUpdate();

//로그인이동
response.sendRedirect("loginForm.jsp");

%>

</body>
</html>