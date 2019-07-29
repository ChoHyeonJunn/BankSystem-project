<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="jspDB_error.jsp"
	import="java.util.*, dbProject.jspDB.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<%@ include file="inc_header.html"%>




<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>은행고객:계좌/CARD</title>

<script type="text/javascript">
	function accountForm(CUST_JUMIN) {
		document.location.href = "jspDB_control.jsp?action=accForm&CUST_JUMIN="
				+ CUST_JUMIN;
	}
	function delcheck(ACC_ID, CUST_JUMIN, CUST_NAME) {
		result = confirm("정말로 삭제하시겠습니까 ?");

		if (result == true) {
			document.location.href = "jspDB_control.jsp?action=accdelete&ACC_ID="
					+ ACC_ID + "&CUST_JUMIN=" + CUST_JUMIN + "&CUST_NAME=" + CUST_NAME;
		} else
			return;
	}
	function deposit(ACC_ID, ACC_BALANCE, CUST_JUMIN) {
		amount = prompt('입금 금액을 입력하세요.');
		document.location.href = "jspDB_control.jsp?action=deposit&ACC_ID="
				+ ACC_ID + "&amount=" + amount + "&ACC_BALANCE=" + ACC_BALANCE
				+ "&CUST_JUMIN=" + CUST_JUMIN;
	}
	function withdraw(ACC_ID, ACC_BALANCE, CUST_JUMIN) {
		amount = prompt('출금 금액을 입력하세요');
		document.location.href = "jspDB_control.jsp?action=withdraw&ACC_ID="
				+ ACC_ID + "&amount=" + amount + "&ACC_BALANCE=" + ACC_BALANCE
				+ "&CUST_JUMIN=" + CUST_JUMIN;
	}
	function transfer(ACC_ID, ACC_BALANCE, CUST_JUMIN, ACC_CUST_NAME) {
		dACC_ID = prompt('계좌번호를 입력하세요');
		amount = prompt('이체 금액을 입력하세요');
		document.location.href = "jspDB_control.jsp?action=transfer&ACC_ID="
				+ ACC_ID + "&dACC_ID=" + dACC_ID + "&amount=" + amount
				+ "&ACC_BALANCE=" + ACC_BALANCE + "&CUST_JUMIN=" + CUST_JUMIN
				+ "&ACC_CUST_NAME=" + encodeURI(ACC_CUST_NAME);
	}
	function trades(ACC_ID, CUST_JUMIN) {
		document.location.href = "jspDB_control.jsp?action=trades&ACC_ID="
				+ ACC_ID + "&CUST_JUMIN=" + CUST_JUMIN;
	}	
	function cardForm(ACC_ID, CUST_JUMIN) {
		document.location.href = "jspDB_cardsForm.jsp?ACC_ID="
				+ ACC_ID + "&CUST_JUMIN=" + CUST_JUMIN;
	}
	
</script>

</head>
<body>
	<div align="center" class="container mx-auto m-5 p-5 bg-ligth shadow">
		<H2>${CUST_NAME}고객님 : 계좌/CARD</H2>
		<HR>
		<form>
			<a href="jspDB_control.jsp?action=list" class="btn btn-warning">회원목록으로</a>
			<a href="javascript:accountForm('${CUST_JUMIN}')" class="btn btn-warning">계좌등록</a>
			<HR>
			<H5 align="left">${CUST_NAME}고객님 : 계좌</H5>
			<table border="1" class="table">
				<tr>
					<th>이름</th>
					<th>전화번호</th>
					<th>계좌ID</th>
					<th>계좌종류</th>
					<th>카드신청여부</th>
					<th>예금개설일</th>
					<th>잔고</th>
					<th>거래</th>
					<th>거래내역</th>
					<th>삭제</th>
				</tr>
				<c:forEach items="${accountList}" var="acc">
					<tr class="table-primary">
						<td rowspan="3">${acc.getACC_CUST_NAME()}</td>
						<td rowspan="3">${acc.getACC_PHNUM()}</td>
						<td rowspan="3">${acc.getACC_ID()}</td>
						<td rowspan="3">${acc.getACC_TYPE()}</td>
						<td rowspan="3" align="center">
							${acc.getCARD_ASK()}<p><p><p><p><p><p>
							<a href="javascript:cardForm('${acc.getACC_ID()}','${CUST_JUMIN}')" class="btn btn-warning">카드등록</a>
						</td>
						<td rowspan="3">${acc.getACC_REGISTER_DATE()}</td>
						<td rowspan="3">${acc.getACC_BALANCE()}</td>
						<td><a
							href="javascript:deposit('${acc.getACC_ID()}','${acc.getACC_BALANCE()}','${CUST_JUMIN}')"
							class="btn btn-warning">입금</a></td>
						<td rowspan="3"><a
							href="javascript:trades('${acc.getACC_ID()}','${CUST_JUMIN}')"
							class="btn btn-warning">거래내역</a></td>
						<td rowspan="3"><a
							href="javascript:delcheck('${acc.getACC_ID()}','${CUST_JUMIN}','${CUST_NAME}')"
							class="btn btn-warning">삭제</a></td>
					<tr class="table-primary">
						<td><a
							href="javascript:withdraw('${acc.getACC_ID()}','${acc.getACC_BALANCE()}','${CUST_JUMIN}')"
							class="btn btn-warning">출금</a></td>
					</tr>
					<tr class="table-primary">
						<td><a
							href="javascript:transfer('${acc.getACC_ID()}','${acc.getACC_BALANCE()}','${CUST_JUMIN}','${acc.getACC_CUST_NAME()}')"
							class="btn btn-warning">이체</a></td>
					</tr>

					</tr>
				</c:forEach>
			</table>

			<HR>
			<H5 align="left">${CUST_NAME}고객님 : CARD</H5>
			<table border="1" class="table">
				<tr>
					<th>카드ID</th>
					<th>신청일</th>
					<th>한도</th>
					<th>결재일자</th>
					<th>카드종류</th>
					<th>주민번호</th>
					<th>계좌ID</th>
				</tr>
				<c:forEach items="${cardsList}" var="card">
					<tr class="table-primary">
						<td>${card.getCARD_ID()}</td>
						<td>${card.getCARD_REGISTER_DATE()}</td>
						<td>${card.getCARD_LIMIT_MONEY()}</td>
						<td>${card.getCARD_APPROVE_DATE()}</td>
						<td>${card.getCARD_TYPE()}</td>
						<td>${card.getCUST_JUMIN()}</td>
						<td>${card.getACC_ID()}</td>
					</tr>
				</c:forEach>
			</table>
		</form>

	</div>
</body>
</html>