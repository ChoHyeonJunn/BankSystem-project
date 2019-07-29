<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="jspDB_error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="inc_header.html" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>카드 등록:작성화면</title>
	<link rel="stylesheet" href="jspDB.css" type="text/css" media="screen" />
	
	<script>
	function accountList(CUST_JUMIN) {
		document.location.href = "jspDB_control.jsp?action=RedirectAccList&CUST_JUMIN=" + CUST_JUMIN;
	}
</script>
</head>

<body>
	<div align="center" class="container w-50 mx-auto m-5 p-5 bg-ligth shadow">
		<H2>카드 등록:작성화면</H2>
		<HR>
		<a href="javascript:accountList('<%=request.getParameter("CUST_JUMIN")%>')" class="btn btn-warning">계좌목록으로 되돌아가기</a>
		<P>
		<form name=form1 method=post action=jspDB_control.jsp>
			<input type=hidden name="action" value="cardinsert">
			<table class="table">
				<tr>
					<th class="table-dark">카드ID</th>
					<td class="table-dark"><input class="form-control" type="text" name="CARD_ID" value="(자동생성)" readonly></td>
				</tr>
				<tr>
					<th class="table-dark">한도</th>
					<td class="table-dark"><input class="form-control" type="text" name="CARD_LIMIT_MONEY"></td>
				</tr>
				<tr>
					<th class="table-dark">카드종류</th>
					<td class="table-dark"><input class="form-control" type="text" name="CARD_TYPE" maxlength="10"></td>
				</tr>
				<tr>
					<th class="table-dark">주민번호</th>
					<td class="table-dark"><input class="form-control" type="email" name="CUST_JUMIN" value="<%=request.getParameter("CUST_JUMIN")%>" readonly></td>
				</tr>
				<tr>
					<th class="table-dark">계좌ID</th>
					<td class="table-dark"><input class="form-control"s type="text" name="ACC_ID"
						value="<%=request.getParameter("ACC_ID")%>" readonly></td>
				</tr>
				<tr>
					<td class="table-light" colspan=2 align=center>
					<button type=submit class="btn btn-warning">저장</button>
					<a href="javascript:accountList('<%=request.getParameter("CUST_JUMIN")%>')" class="btn btn-danger">취소</a>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>