<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="jspDB_error.jsp"
	import="java.util.*, dbProject.jspDB.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="inc_header.html"%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계좌 : 거래내역</title>
<script>
	function accountList(CUST_JUMIN) {
		document.location.href = "jspDB_control.jsp?action=RedirectAccList&CUST_JUMIN=" + CUST_JUMIN;
	}
</script>

</head>
<body>
	<div align="center" class="container mx-auto m-5 p-5 bg-ligth shadow">
		<H2>계좌 : 거래내역</H2>
		<HR>
		<form>
			<P>
			<a href="javascript:accountList('${CUST_JUMIN}')" class="btn btn-warning">계좌목록으로 되돌아가기</a>
			<table border="1" class="table">
				<tr>
					<th>예금계좌ID</th>
					<th>입출금날짜</th>
					<th>거래번호</th>
					<th>예금구분</th>
					<th>예금내용</th>
					<th>거래금액</th>
					<th>예금잔고</th>
				</tr>
				<c:forEach items="${b_acc_tradesList}" var="trade">
					<tr class="table-primary">
						<td>${trade.getACC_ID()}</td>
						<td>${trade.getIMP_EXP_DATE()}</td>
						<td>${trade.getTRADE_ID()}</td>
						<td>${trade.getACC_CLASS()}</td>
						<td>${trade.getACC_CONTENTS()}</td>
						<td>${trade.getTRADE_MONEY()}</td>
						<td>${trade.getACC_BALANCE()}</td>
					</tr>
				</c:forEach>
			</table>
		</form>

	</div>
</body>
</html>