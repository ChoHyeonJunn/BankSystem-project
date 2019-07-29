<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="jspDB_error.jsp"%>
	
<%@ include file="inc_header.html"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>고객 등록:작성화면</title>
<link rel="stylesheet" href="jspDB.css" type="text/css" media="screen" />
</head>
<body>
	<div align="center" class="container w-50 mx-auto m-5 p-5 bg-ligth shadow">
		<H2>고객 등록:작성화면</H2>
		<HR>
		<a href="jspDB_control.jsp?action=list" class="btn btn-warning">회원 목록으로</a>
		<P>
		<form name=form1 method=post action=jspDB_control.jsp><%--?action=insert 라고 뒤에 붙여도 되고--%>
			<input type=hidden name="action" value="insert"><%--이런식으로 타입을 히든이라고 하고 액션을 인서트라고 해도 된다. --%>
			<table class="table">
				<tr>
					<th class="table-dark">주민번호</th>
					<td class="table-dark"><input class="form-control" type="text" name="CUST_JUMIN" maxlength="20"></td>
				</tr>
				<tr>
					<th class="table-dark">이 름</th>
					<td class="table-dark"><input class="form-control" type="text" name="CUST_NAME" maxlength="15"></td>
				</tr>
				<tr>
					<th class="table-dark">주 소</th>
					<td class="table-dark"><input class="form-control" type="text" name="CUST_ADDR" maxlength="50"></td>
				</tr>
				<tr>
					<th class="table-dark">생 일</th>
					<td class="table-dark"><input class="form-control" type="date" name="CUST_BIRTH"></td>
				</tr>
				<tr>
					<th class="table-dark">이메일</th>
					<td class="table-dark"><input class="form-control" type="email" name="CUST_EMAIL" maxlength="50"></td>
				</tr>
				<tr>
					<th class="table-dark">전화번호</th>
					<td class="table-dark"><input class="form-control" type="tel" name="CUST_PHNUM"></td>
				</tr>
				<tr>
					<th class="table-dark">직 업</th>
					<td class="table-dark"><input class="form-control" type="text" name="CUST_JOB"></td>
				</tr>
				<tr>
					<td class="table-light" colspan=2 align=center>
					<button type=submit class="btn btn-warning">저장</button>
		<a href="jspDB_control.jsp?action=list" class="btn btn-danger">취소</a>
				</tr>
			</table>
		</form>

	</div>
</body>
</html>