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
<title>내 정보 수정</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
	<link href="editCss.css" rel="stylesheet" type="text/css">
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

//3단계 SQL구문 만들어서 실행할 준비(select)
String sql = "select * from memberlist where id=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1,id);

//4단계 SQL구문을 실행 -> 결과 저장
ResultSet rs = pstmt.executeQuery();

//5.결과 출력, 데이터 담기 (select)
if(rs.next()){
%> 
	
	<form id="edit" action="editPro.jsp" method="post">
		<fieldset>

			<h3>Edit Information</h3>
			<ul>
				<li><label for="userid"> 아이디 </label> 
					<input type="text" id="id" name="id" value="<%=id %>" readonly style="border: 0 solid black"></li>
	
				<li><label for="pass"> 비밀번호 </label> 
					<input type="password" id="pass" name="pass" required placeholder="확인을 위해 비밀번호를 입력하세요"></li>

				<li><label for="name"> 이름 </label> 
					<input type="text" id="name" name="name" value="<%=rs.getString("name") %>"></li>

				<li><label for="nickname"> 닉네임 </label> 
					<input type="text" id="nickname" name="nickname" value="<%=rs.getString("nickname") %>" readonly style="border: 0 solid black"></li>

				<li><label for="birth"> 생일 </label> 
					<input type="text" id="birth" name="birth" value="<%=rs.getString("birth") %>" readonly style="border: 0 solid black"></li>

				<li><label for="gender"> 성별 </label> 
					<input type="text" name="gender" readonly value="<%=rs.getString("gender") %>" style="border: 0 solid black"></li>

				<li><label for="address"> 주소 </label> 
						<input type="text" id="address" name="address" value="<%=rs.getString("address") %>" ><br> 
					<label for="address_detail">상세주소</label> 
						<input type="text" id="address_detail" name="address_detail" value="<%=rs.getString("address_detail") %>" ></li>
			</ul>
			<div class="submit">
				<button type="submit">수정</button>
				<button type="button" onclick="location.href = 'myPage.jsp' ">이전으로 돌아가기</button>
			</div>
		</fieldset>
	</form>
<%
	}	
%>
</body>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

window.onload = function(){
	
    document.getElementById("address").addEventListener("click", function(){ 
    	//주소입력칸을 클릭하면 카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address").value = data.address; // 주소 넣기
                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}

function RadioCk() {
	
	
}

</script>
</html>