<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="jspDB_error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="inc_header.html" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계좌 등록:작성화면</title>
<link rel="stylesheet" href="jspDB.css" type="text/css" media="screen" />

<script>
	function accountList(CUST_JUMIN) {
		document.location.href = "jspDB_control.jsp?action=RedirectAccList&CUST_JUMIN=" + CUST_JUMIN;
	}
</script>
</head>

<jsp:useBean id="b_customers" scope="request"
	class="dbProject.jspDB.B_CUSTOMERS" />

<body>
	<div align="center" class="container w-50 mx-auto m-5 p-5 bg-ligth shadow">
		<H2>계좌 등록:작성화면</H2>
		<HR>
		<a href="javascript:history.go(-1)" class="btn btn-warning">계좌 목록으로</a>
		<P>
		<form name=form1 method=post action=jspDB_control.jsp>
			<input type=hidden name="action" value="accinsert">
			<table class="table">
				<tr>
					<th class="table-dark">예금계좌</th>
					<td class="table-dark"><input class="form-control" type="text" name="ACC_ID" value="(자동생성)" readonly></td>
				</tr>
				<tr>
					<th class="table-dark">예금계좌종류</th>
					<td class="table-dark"><input class="form-control" type="text" name="ACC_TYPE" maxlength="20"></td>
				</tr>
				<tr>
					<th class="table-dark">카드신청여부</th>
					<td class="table-dark"><input class="form-control" type="text" name="CARD_ASK" value="N" readonly></td>
				</tr>
				<tr>
					<th class="table-dark">예금자이름</th>
					<td class="table-dark"><input class="form-control" type="text" name="ACC_CUST_NAME"
						value="<%=b_customers.getCUST_NAME()%>" readonly></td>
				</tr>
				<tr>
					<th class="table-dark">전화번호</th>
					<td class="table-dark"><input class="form-control" type="text" name="ACC_PHNUM"
						value="<%=b_customers.getCUST_PHNUM()%>" readonly></td>
				</tr>
				<tr>
					<th class="table-dark">이메일</th>
					<td class="table-dark"><input class="form-control" type="email" name="ACC_EMAIL"
						placeholder="기존email과 다른 email을 입력하세요,,"></td>
				</tr>
				<tr>
					<th class="table-dark">고객주민번호</th>
					<td class="table-dark"><input class="form-control" type="text" name="CUST_JUMIN"
						value="<%=b_customers.getCUST_JUMIN()%>" readonly></td>
				</tr>
			</table>
			<button class="btn btn-warning" type=submit>저장</button>
			<a href="javascript:history.go(-1)" class="btn btn-danger">취소</a>
		</form>
	</div>
</body>
</html>