<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="jspDB_error.jsp"
	import="dbProject.jspDB.*, java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="bankBean" class="dbProject.jspDB.uBankBean" />
<jsp:useBean id="cus" class="dbProject.jspDB.B_CUSTOMERS" />
<jsp:useBean id="acc" class="dbProject.jspDB.B_ACCOUNTS" />
<jsp:useBean id="card" class="dbProject.jspDB.B_CARDS" />
<jsp:setProperty name="cus" property="*" />
<jsp:setProperty name="acc" property="*" />
<jsp:setProperty name="card" property="*" />
<%
	String cCUST_NAME = null;
	// 컨트롤러 요청 파라미터
	String action = request.getParameter("action");

	// 파라미터에 따른 요청 처리
	/*               */
	/*고객 관련 controler*/
	/*               */
	// 고객 목록 요청인 경우
	if (action.equals("list")) {
		ArrayList<B_CUSTOMERS> customerList = bankBean.getCUSList();
		request.setAttribute("customerList", customerList);
		pageContext.forward("jspDB_customerList.jsp");
	}
	// 고객 등록 요청인 경우
	else if (action.equals("insert")) {
		if (bankBean.insertCUS(cus))
			response.sendRedirect("jspDB_control.jsp?action=list");
		else
			throw new Exception("DB 입력오류");
	}
	// 고객정보 수정/삭제 요청인 경우
	else if (action.equals("edit")) {
		B_CUSTOMERS b_customers = bankBean.getCUS(cus.getCUST_JUMIN());
		if (!request.getParameter("upasswd").equals("1234")) {
			out.println("<script>alert('비밀번호가 틀렸습니다.!!');history.go(-1);</script>");
		} else {
			request.setAttribute("b_customers", b_customers);
			pageContext.forward("jspDB_customerEdit.jsp");
		}
	}
	// 고객정보 수정 등록 요청인 경우
	else if (action.equals("update")) {
		if (bankBean.updateCUS(cus)) {
			response.sendRedirect("jspDB_control.jsp?action=list");
		} else
			throw new Exception("DB 갱신오류");
	}
	// 고객정보 삭제 요청인 경우
	else if (action.equals("delete")) {
		if (bankBean.deleteCUS(cus.getCUST_JUMIN())) {
			response.sendRedirect("jspDB_control.jsp?action=list");
		} else
			throw new Exception("DB 삭제 오류");
	}
	/*               */
	/*계좌 관련 controler*/
	/*               */
	// 계좌목록/card목록 요청인 경우
	else if (action.equals("accList")) {
		ArrayList<B_ACCOUNTS> accountList = bankBean.getACList(cus.getCUST_JUMIN());
		ArrayList<B_CARDS> cardsList = bankBean.getCARDList(cus.getCUST_JUMIN());

		request.setAttribute("CUST_NAME", cus.getCUST_NAME());
		request.setAttribute("CUST_JUMIN", cus.getCUST_JUMIN());
		request.setAttribute("accountList", accountList);
		request.setAttribute("cardsList", cardsList);
		pageContext.forward("jspDB_accountList.jsp");

	}
	// 트레이드 완료 후 계좌목록
	else if (action.equals("RedirectAccList")) {
		ArrayList<B_ACCOUNTS> accountList = bankBean.getACList(cus.getCUST_JUMIN());
		ArrayList<B_CARDS> cardsList = bankBean.getCARDList(cus.getCUST_JUMIN());

		request.setAttribute("CUST_NAME", accountList.get(0).getACC_CUST_NAME());
		request.setAttribute("CUST_JUMIN", cus.getCUST_JUMIN());
		request.setAttribute("accountList", accountList);
		request.setAttribute("cardsList", cardsList);
		pageContext.forward("jspDB_accountList.jsp");

	}
	// 삭제 후 계좌목록
		else if (action.equals("RedirectdAccList")) {
			ArrayList<B_ACCOUNTS> accountList = bankBean.getACList(cus.getCUST_JUMIN());
			ArrayList<B_CARDS> cardsList = bankBean.getCARDList(cus.getCUST_JUMIN());

			request.setAttribute("CUST_NAME", cCUST_NAME);
			request.setAttribute("CUST_JUMIN", cus.getCUST_JUMIN());
			request.setAttribute("accountList", accountList);
			request.setAttribute("cardsList", cardsList);
			pageContext.forward("jspDB_accountList.jsp");

		}
	// 계좌 등록 페이지로 넘어가는 요청일 경우(회원정보를 넘겨줌)
	else if (action.equals("accForm")) {
		B_CUSTOMERS b_customers = bankBean.getCUS(cus.getCUST_JUMIN());
		request.setAttribute("b_customers", b_customers);
		pageContext.forward("jspDB_accountForm.jsp");

	}
	// 계좌 등록 요청인 경우
	else if (action.equals("accinsert")) {
		if (bankBean.insertAC(acc))
			response.sendRedirect("jspDB_control.jsp?action=RedirectAccList&CUST_JUMIN=" + cus.getCUST_JUMIN());
		else
			throw new Exception("DB 입력오류");
	}
	// 고객정보 삭제 요청인 경우
	else if (action.equals("accdelete")) {
		if (bankBean.deleteAC(acc.getACC_ID())) {
			cCUST_NAME = cus.getCUST_NAME();
			response.sendRedirect("jspDB_control.jsp?action=RedirectdAccList&CUST_JUMIN=" + cus.getCUST_JUMIN());
		} else
			throw new Exception("DB 삭제 오류");
	}
	// 입금
	else if (action.equals("deposit")) {
		//입금 결과 금액(거래금액 + 잔액) 을 계산
		String balance = Integer.toString(Integer.parseInt(request.getParameter("amount").trim())
				+ Integer.parseInt(request.getParameter("ACC_BALANCE").trim()));
		out.println(balance);
		if (bankBean.deposit(acc.getACC_ID(), request.getParameter("amount"))
				&& bankBean.write(acc.getACC_ID(), request.getParameter("amount"), "입금", "입금", balance)) {
			response.sendRedirect("jspDB_control.jsp?action=RedirectAccList&CUST_JUMIN=" + cus.getCUST_JUMIN());

		} else
			throw new Exception("DB 입금 오류");
	}
	// 출금
	else if (action.equals("withdraw")) {
		if (Integer.parseInt(request.getParameter("amount").trim()) > Integer
				.parseInt(request.getParameter("ACC_BALANCE").trim())) {
			out.println("<script>alert('잔액이 부족합니다!!');history.go(-1);</script>");
		} else {
			//입금 결과 금액(거래금액 - 잔액) 을 계산
			String balance = Integer.toString(Integer.parseInt(request.getParameter("ACC_BALANCE").trim())
					- Integer.parseInt(request.getParameter("amount").trim()));
			if (bankBean.withdraw(acc.getACC_ID(), request.getParameter("amount"))
					&& bankBean.write(acc.getACC_ID(), request.getParameter("amount"), "출금", "출금", balance)) {
				response.sendRedirect(
						"jspDB_control.jsp?action=RedirectAccList&CUST_JUMIN=" + cus.getCUST_JUMIN());
				//out.println("<script>alert('출금이 완료되었습니다!!');</script>");
			} else
				throw new Exception("DB 출금 오류");
		}
	}
	// 이체
	else if (action.equals("transfer")) {
		B_ACCOUNTS b_accounts = bankBean.getAC(request.getParameter("dACC_ID"));

		if (b_accounts.getACC_ID() == null)
			out.println("<script>alert('해당 계좌가 존재하지 않습니다!!');history.go(-1);</script>");
		else if (b_accounts.getACC_ID().equals(acc.getACC_ID()))
			out.println("<script>alert('같은 계좌에 이체할 수 없습니다!!');history.go(-1);</script>");
		else {
			if (Integer.parseInt(request.getParameter("amount").trim()) > Integer
					.parseInt(request.getParameter("ACC_BALANCE").trim()))
				out.println("<script>alert('잔액이 부족합니다!!');history.go(-1);</script>");
			else {
				/*	모든 이체 조건에 만족 했을때 	 */
				//입금 결과 금액(거래금액 - 잔액) 을 계산
				String balance = Integer.toString(Integer.parseInt(request.getParameter("ACC_BALANCE").trim())
						- Integer.parseInt(request.getParameter("amount").trim()));
				//입금 결과 금액(거래금액 + d잔액) 을 계산
				String d_balance = Integer.toString(
						Integer.parseInt(request.getParameter("amount").trim()) + b_accounts.getACC_BALANCE());
				if (bankBean.withdraw(acc.getACC_ID(), request.getParameter("amount"))
						&& bankBean.write(acc.getACC_ID(), request.getParameter("amount"), "출금",
								"이체 " + b_accounts.getACC_CUST_NAME(), balance)
						&& bankBean.deposit(request.getParameter("dACC_ID"), request.getParameter("amount"))
						&& bankBean.write(request.getParameter("dACC_ID"), request.getParameter("amount"), "입금",
								"이체 " + acc.getACC_CUST_NAME(), d_balance))
					response.sendRedirect(
							"jspDB_control.jsp?action=RedirectAccList&CUST_JUMIN=" + cus.getCUST_JUMIN());
				else
					throw new Exception("DB 출금 오류");
			}
		}
	}
	// 거래내역 요청인 경우
	else if (action.equals("trades")) {
		ArrayList<B_ACC_TRADES> b_acc_tradesList = bankBean.getB_ACC_TRADESList(acc.getACC_ID());

		request.setAttribute("CUST_JUMIN", cus.getCUST_JUMIN());
		request.setAttribute("b_acc_tradesList", b_acc_tradesList);
		pageContext.forward("jspDB_tradeList.jsp");

	}
	// 카드등록 요청인 경우
	else if (action.equals("cardinsert")) {
		if (bankBean.insertCARD(card) && bankBean.updateCARD_ASK(card.getACC_ID()))
			response.sendRedirect("jspDB_control.jsp?action=RedirectAccList&CUST_JUMIN=" + cus.getCUST_JUMIN());
		else
			throw new Exception("DB 입력오류");

	}
	// action parameter가 정확하지 않은 경우 에러 처리
	else {
		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
	}
%>