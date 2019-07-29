<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="jspDB_error.jsp"
	import="java.util.*, dbProject.jspDB.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="inc_header.html" %>


<!DOCTYPE HTML>
<html>
<head>
<!-- <link rel="stylesheet" href="jspDB.css" type="text/css" media="screen" />
 -->
<script type="text/javascript">
	function check(CUST_JUMIN) {
		pwd = prompt('수정/삭제 하려면 비밀번호를 입력하세요');
		document.location.href = "jspDB_control.jsp?action=edit&CUST_JUMIN="
				+ CUST_JUMIN + "&upasswd=" + pwd;
	}
	function account(CUST_JUMIN, CUST_NAME) {
		document.location.href = "jspDB_control.jsp?action=accList&CUST_JUMIN="
				+ CUST_JUMIN + "&CUST_NAME=" + encodeURI(CUST_NAME);
	}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주소록:목록화면</title>

</head>

<body>
	<div align="center" class="container mx-auto m-5 p-5 bg-ligth shadow">
		<H2>은행 고객 : 목록화면</H2>
		<HR>
		<form>
			<a href="jspDB_customerForm.jsp" class="btn btn-warning">고객 등록</a>
			<HR>
			<table border="1" class="table">
				<tr>
					<th>주민번호</th>
					<th>이 름</th>
					<th>주 소</th>
					<th>생 일</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>직 업</th>
					<th>수정/삭제</th>
					<th>계 좌/CARD</th>
				</tr>
				<c:forEach items="${customerList}" var="cus">
					<tr class="table-primary">
						<td>${cus.getCUST_JUMIN()}</td>
						<td>${cus.getCUST_NAME()}</td>
						<td>${cus.getCUST_ADDR()}</td>
						<td>${cus.getCUST_BIRTH()}</td>
						<td>${cus.getCUST_EMAIL()}</td>
						<td>${cus.getCUST_PHNUM()}</td>
						<td>${cus.getCUST_JOB()}</td>
						<td><a href="javascript:check('${cus.getCUST_JUMIN()}')" class="btn btn-warning">수정/삭제</a></td>
						<td><a href="javascript:account('${cus.getCUST_JUMIN()}','${cus.getCUST_NAME()}')" class="btn btn-warning">계좌/CARD 확인</a></td>
					</tr>
				</c:forEach>

			</table>
		</form>

	</div>
</body>
</html>