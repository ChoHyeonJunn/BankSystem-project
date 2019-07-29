<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="jspDB_error.jsp"
	import="dbProject.jspDB.*"%>
<%@ include file="inc_header.html" %>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="jspDB.css" type="text/css" media="screen" />

<script type="text/javascript">
	function delcheck() {
		result = confirm("정말로 삭제하시겠습니까 ?");

		if (result == true) {
			document.form1.action.value = "delete";
			document.form1.submit();
		} else
			return;
	}
</script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>회원정보:수정화면</title>
</head>

<jsp:useBean id="b_customers" scope="request" class="dbProject.jspDB.B_CUSTOMERS" />

<body>
	<div align="center" class="container w-50 mx-auto m-5 p-5 bg-ligth shadow">
		<H2>회원정보:수정화면</H2>
		<HR>
		<a href="jspDB_control.jsp?action=list" class="btn btn-warning">회원 목록으로 되돌아가기</a>
		<p>
		
		<form name=form1 method=post action=jspDB_control.jsp>
			<input type=hidden name="CUST_JUMIN" value="<%=b_customers.getCUST_JUMIN()%>">
			<input type=hidden name="action" value="update">
			<table class="table">
				<tr>
					<th class="table-dark">주민번호</th>
					<td class="table-dark"><input class="form-control" type="text" name="CUST_JUMIN"
						value="<%=b_customers.getCUST_JUMIN()%> (수정불가)" readonly></td>
				</tr>
				<tr>
					<th class="table-dark">이 름</th>
					<td class="table-dark"><input class="form-control" type="text" name="CUST_NAME"
						value="<%=b_customers.getCUST_NAME()%>"></td>
				</tr>
				<tr>
					<th class="table-dark">주 소</th>
					<td class="table-dark"><input class="form-control" type="text" name="CUST_ADDR"
						value="<%=b_customers.getCUST_ADDR()%>"></td>
				</tr>
				<tr>
					<th class="table-dark">생 일</th>
					<td class="table-dark"><input class="form-control" type="text" name="CUST_BIRTH"
						value="<%=b_customers.getCUST_BIRTH()%> (수정불가)" readonly></td>
				</tr>
				<tr>
					<th class="table-dark">이메일</th>
					<td class="table-dark"><input class="form-control" type="text" name="CUST_EMAIL"
						value="<%=b_customers.getCUST_EMAIL()%>"></td>
				</tr>
				<tr>
					<th class="table-dark">전화번호</th>
					<td class="table-dark"><input class="form-control" type="text" name="CUST_PHNUM"
						value="<%=b_customers.getCUST_PHNUM()%>"></td>
				</tr>
				<tr>
					<th class="table-dark">직 업</th>
					<td class="table-dark"><input class="form-control" type="text" name="CUST_JOB"
						value="<%=b_customers.getCUST_JOB()%>"></td>
				</tr>
				<tr>
					<td class="table-light" colspan=2 align=center>
					<button type=submit class="btn btn-warning">저장</button>
					<a href="jspDB_control.jsp?action=list" class="btn btn-danger">취소</a>				
					<a href="javascript:delcheck()" class="btn btn-outline-danger">회원탈퇴</a>
				</tr>
			</table>
		</form>

	</div>
</body>
</html>