package dbProject.jspDB;

import java.sql.*;
import java.util.*;

public class uBankBean {
	Connection conn = null;
	PreparedStatement pstmt = null;

	/* Oracle �������� */
	String jdbc_driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "U_BANK";
	String pwd = "U_BANK";

	// DB���� �޼���
	void connect() {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(url, userid, pwd);

			/*
			 * DBCP version Context initContext = new InitialContext(); Context envContext =
			 * (Context)initContext.lookup("java:/comp/env"); DataSource ds =
			 * (DataSource)envContext.lookup("jdbc/mysql"); conn = ds.getConnection();
			 */
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// DB���� ���� �޼���
	void disconnect() {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// CUSTOMER �ű� ȸ������ ���
	public boolean insertCUS(B_CUSTOMERS b_customers) {
		connect();

		String sql = "insert into b_customers(CUST_JUMIN, CUST_NAME, CUST_ADDR, CUST_BIRTH, CUST_EMAIL, CUST_PHNUM, CUST_JOB) values(?,?,?,?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_customers.getCUST_JUMIN());
			pstmt.setString(2, b_customers.getCUST_NAME());
			pstmt.setString(3, b_customers.getCUST_ADDR());
			pstmt.setString(4, b_customers.getCUST_BIRTH());
			pstmt.setString(5, b_customers.getCUST_EMAIL());
			pstmt.setString(6, b_customers.getCUST_PHNUM());
			pstmt.setString(7, b_customers.getCUST_JOB());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;// ������Ʈ ���� ������ ���� false
		} finally { // �����ϴ� �������� �ʴ� DB���� Ŀ�ؼ��� ���´�.
			disconnect();
		}
		return true;// ���������� return true
	}

	// CUSTOMER ȸ������ ����
	public boolean updateCUS(B_CUSTOMERS b_customers) {
		connect();

		String sql = "update b_customers set CUST_NAME=?, CUST_ADDR=?, CUST_EMAIL=?, CUST_PHNUM=?, CUST_JOB=? where CUST_JUMIN=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_customers.getCUST_NAME());
			pstmt.setString(2, b_customers.getCUST_ADDR());
			pstmt.setString(3, b_customers.getCUST_EMAIL());
			pstmt.setString(4, b_customers.getCUST_PHNUM());
			pstmt.setString(5, b_customers.getCUST_JOB());
			pstmt.setString(6, b_customers.getCUST_JUMIN());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	// CUSTOMER ȸ������ ����
	public boolean deleteCUS(String CUST_JUMIN) {
		connect();

		String sql = "delete from b_customers where CUST_JUMIN=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, CUST_JUMIN);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	// CUSTOMER Ư�� ȸ������
	public B_CUSTOMERS getCUS(String CUST_JUMIN) {
		connect();

		String sql = "select * from b_customers where CUST_JUMIN=?";
		B_CUSTOMERS b_customers = new B_CUSTOMERS();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, CUST_JUMIN);
			ResultSet rs = pstmt.executeQuery();

			// �����Ͱ� �ϳ��� �����Ƿ� rs.next()�� �ѹ��� ���� �Ѵ�.
			while (rs.next()) {
				b_customers.setCUST_JUMIN(rs.getString("CUST_JUMIN"));
				b_customers.setCUST_NAME(rs.getString("CUST_NAME"));
				b_customers.setCUST_ADDR(rs.getString("CUST_ADDR"));
				b_customers.setCUST_BIRTH(rs.getString("CUST_BIRTH"));
				b_customers.setCUST_EMAIL(rs.getString("CUST_EMAIL"));
				b_customers.setCUST_PHNUM(rs.getString("CUST_PHNUM"));
				b_customers.setCUST_JOB(rs.getString("CUST_JOB"));
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return b_customers;
	}

	// CUSTOMER �� ���̺�(B_CUSTOMERS TABLE)�� ��ü ����Ʈ
	public ArrayList<B_CUSTOMERS> getCUSList() {
		connect();
		ArrayList<B_CUSTOMERS> customerList = new ArrayList<B_CUSTOMERS>();

		String sql = "select * from b_customers";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				B_CUSTOMERS b_customers = new B_CUSTOMERS();

				b_customers.setCUST_JUMIN(rs.getString("CUST_JUMIN"));
				b_customers.setCUST_NAME(rs.getString("CUST_NAME"));
				b_customers.setCUST_ADDR(rs.getString("CUST_ADDR"));
				b_customers.setCUST_BIRTH(rs.getString("CUST_BIRTH"));
				b_customers.setCUST_EMAIL(rs.getString("CUST_EMAIL"));
				b_customers.setCUST_PHNUM(rs.getString("CUST_PHNUM"));
				b_customers.setCUST_JOB(rs.getString("CUST_JOB"));

				customerList.add(b_customers);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return customerList;
	}

	// ACCOUNTS �ű� �������� ���
	public boolean insertAC(B_ACCOUNTS b_accounts) {
		connect();

		String sql = "insert into B_ACCOUNTS(ACC_ID, ACC_TYPE, ACC_BALANCE, CARD_ASK, ACC_REGISTER_DATE, ACC_CUST_NAME, ACC_PHNUM, ACC_EMAIL, CUST_JUMIN) values(ACC_ID.nextval,?,?,?,SYSDATE,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			// pstmt.setString(1, "ACC_ID.nextval"); // ORACLE ���ο��� ���� SEQUENCE (1000����
			// �ڵ�����)
			pstmt.setString(1, b_accounts.getACC_TYPE());
			pstmt.setInt(2, 1000); // ACC_BALANCE �� �⺻���� 1000������ ��
			pstmt.setString(3, "N"); // CARD_ASK ī��������� default N
			// pstmt.setString(4, SYSDATE); // ACC_REGISTER_DATE ���� �������� sysdate
			pstmt.setString(4, b_accounts.getACC_CUST_NAME());
			pstmt.setString(5, b_accounts.getACC_PHNUM());
			pstmt.setString(6, b_accounts.getACC_EMAIL());
			pstmt.setString(7, b_accounts.getCUST_JUMIN());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;// ������Ʈ ���� ������ ���� false
		} finally { // �����ϴ� �������� �ʴ� DB���� Ŀ�ؼ��� ���´�.
			disconnect();
		}
		return true;// ���������� return true
	}

	// ACCOUNTS �������� ����
	public boolean deleteAC(String ACC_ID) {
		connect();

		String sql = "delete from b_accounts where acc_id=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ACC_ID);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	// ACCOUNTS Ư�� ��������
	public B_ACCOUNTS getAC(String ACC_ID) {
		connect();

		String sql = "select * from b_accounts where ACC_ID=?";
		B_ACCOUNTS b_accounts = new B_ACCOUNTS();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ACC_ID);
			ResultSet rs = pstmt.executeQuery();

			// �����Ͱ� �ϳ��� �����Ƿ� rs.next()�� �ѹ��� ���� �Ѵ�.
			while (rs.next()) {
				b_accounts.setACC_ID(rs.getString("ACC_ID"));
				b_accounts.setACC_TYPE(rs.getString("ACC_TYPE"));
				b_accounts.setACC_BALANCE(rs.getInt("ACC_BALANCE"));
				b_accounts.setCARD_ASK(rs.getString("CARD_ASK"));
				b_accounts.setACC_REGISTER_DATE(rs.getString("ACC_REGISTER_DATE"));
				b_accounts.setACC_CUST_NAME(rs.getString("ACC_CUST_NAME"));
				b_accounts.setACC_PHNUM(rs.getString("ACC_PHNUM"));
				b_accounts.setACC_EMAIL(rs.getString("ACC_EMAIL"));
				b_accounts.setCUST_JUMIN(rs.getString("CUST_JUMIN"));
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return b_accounts;
	}

	// ACCOUNTS �� ���̺�(B_CUSTOMERS TABLE)�� ��ü ����Ʈ (ȸ�� �ֹι�ȣ �μ��� ���)
	public ArrayList<B_ACCOUNTS> getACList(String CUST_JUMIN) {
		connect();
		ArrayList<B_ACCOUNTS> accountList = new ArrayList<B_ACCOUNTS>();

		String sql = "select * from b_accounts where cust_jumin=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, CUST_JUMIN);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				B_ACCOUNTS b_accounts = new B_ACCOUNTS();

				b_accounts.setACC_ID(rs.getString("ACC_ID"));
				b_accounts.setACC_TYPE(rs.getString("ACC_TYPE"));
				b_accounts.setACC_BALANCE(rs.getInt("ACC_BALANCE"));
				b_accounts.setCARD_ASK(rs.getString("CARD_ASK"));
				b_accounts.setACC_REGISTER_DATE(rs.getString("ACC_REGISTER_DATE"));
				b_accounts.setACC_CUST_NAME(rs.getString("ACC_CUST_NAME"));
				b_accounts.setACC_PHNUM(rs.getString("ACC_PHNUM"));
				b_accounts.setACC_EMAIL(rs.getString("ACC_EMAIL"));
				b_accounts.setCUST_JUMIN(rs.getString("CUST_JUMIN"));

				accountList.add(b_accounts);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return accountList;
	}	

	// CARDS ī�� ���̺�(B_CARDS TABLE)�� ��ü ����Ʈ (ȸ�� �ֹι�ȣ �μ��� ���)
	public ArrayList<B_CARDS> getCARDList(String CUST_JUMIN) {
			connect();
			ArrayList<B_CARDS> cardsList = new ArrayList<B_CARDS>();

			String sql = "select * from b_cards where cust_jumin=?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, CUST_JUMIN);
				ResultSet rs = pstmt.executeQuery();
				while (rs.next()) {
					B_CARDS b_cards = new B_CARDS();

					b_cards.setCARD_ID(rs.getString("CARD_ID"));
					b_cards.setCARD_REGISTER_DATE(rs.getString("CARD_REGISTER_DATE"));
					b_cards.setCARD_LIMIT_MONEY(rs.getInt("CARD_LIMIT_MONEY"));
					b_cards.setCARD_APPROVE_DATE(rs.getString("CARD_APPROVE_DATE"));
					b_cards.setCARD_TYPE(rs.getString("CARD_TYPE"));
					b_cards.setCUST_JUMIN(rs.getString("CUST_JUMIN"));
					b_cards.setACC_ID(rs.getString("ACC_ID"));

					cardsList.add(b_cards);
				}
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				disconnect();
			}
			return cardsList;
		}

	// CARDS �ű� �������� ���
	public boolean insertCARD(B_CARDS card) {
		connect();
		//System.out.println(card.getCARD_LIMIT_MONEY() + card.getCARD_TYPE() + card.getCUST_JUMIN() + card.getACC_ID());
		String sql = "insert into b_cards(CARD_ID, CARD_REGISTER_DATE, CARD_LIMIT_MONEY, CARD_APPROVE_DATE, CARD_TYPE, CUST_JUMIN, ACC_ID)"
				+ " values(CARD_ID.nextval, SYSDATE, ?, SYSDATE, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, card.getCARD_LIMIT_MONEY());
			pstmt.setString(2, card.getCARD_TYPE());
			pstmt.setString(3, card.getCUST_JUMIN());
			pstmt.setString(4, card.getACC_ID());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;// ������Ʈ ���� ������ ���� false
		} finally { // �����ϴ� �������� �ʴ� DB���� Ŀ�ؼ��� ���´�.
			disconnect();
		}
		return true;// ���������� return true
	}

	// CARDS ACCOUNTS ī���û���� ������Ʈ
	public boolean updateCARD_ASK(String ACC_ID) {
		connect();

		String sql = "update b_accounts set card_ask='Y' where acc_id=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ACC_ID);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}
	
	// ACCOUNTS �Ա�
	public boolean deposit(String ACC_ID, String amount) {
		connect();

		String sql = "update b_accounts set acc_balance = acc_balance+? where acc_id=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, amount);
			pstmt.setString(2, ACC_ID);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	// ACCOUNTS ���
	public boolean withdraw(String ACC_ID, String amount) {
		connect();

		String sql = "update b_accounts set acc_balance = acc_balance-? where acc_id=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, amount);
			pstmt.setString(2, ACC_ID);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	// ACCOUNTS ��ü
	public boolean transfer(String ACC_ID, String dACC_ID, String amount) {
		connect();

		String sql = "update b_accounts set acc_balance = acc_balance-? where acc_id=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, amount);
			pstmt.setString(2, ACC_ID);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	// ACC_TRADES �ŷ����� ����
	public boolean write(String ACC_ID, String amount, String ACC_CLASS, String ACC_CONTENTS, String ACC_BALANCE) {
		connect();

		String sql = "insert into b_acc_trades(ACC_ID, IMP_EXP_DATE, TRADE_ID, ACC_CLASS, ACC_CONTENTS, TRADE_MONEY, ACC_BALANCE) values(?,SYSDATE, TRADE_ID.nextval,?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ACC_ID);// ����ID
			pstmt.setString(2, ACC_CLASS);// ����� ����
			pstmt.setString(3, ACC_CONTENTS);// ��ü����
			pstmt.setString(4, amount);// �ݾ�
			pstmt.setString(5, ACC_BALANCE);// �ܱ�
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	// B_ACC_TRADES �ŷ����� ���̺�(B_ACC_TRADES TABLE)�� ��ü ����Ʈ (����ID �μ��� ���)
	public ArrayList<B_ACC_TRADES> getB_ACC_TRADESList(String ACC_ID) {
		connect();
		ArrayList<B_ACC_TRADES> b_acc_tradesList = new ArrayList<B_ACC_TRADES>();

		String sql = "select * from b_acc_trades where acc_id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ACC_ID);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				B_ACC_TRADES b_acc_trades = new B_ACC_TRADES();

				b_acc_trades.setACC_ID(rs.getString("ACC_ID"));
				b_acc_trades.setIMP_EXP_DATE(rs.getString("IMP_EXP_DATE"));
				b_acc_trades.setTRADE_ID(rs.getInt("TRADE_ID"));
				b_acc_trades.setACC_CLASS(rs.getString("ACC_CLASS"));
				b_acc_trades.setACC_CONTENTS(rs.getString("ACC_CONTENTS"));
				b_acc_trades.setTRADE_MONEY(rs.getInt("TRADE_MONEY"));
				b_acc_trades.setACC_BALANCE(rs.getInt("ACC_BALANCE"));

				b_acc_tradesList.add(b_acc_trades);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return b_acc_tradesList;
	}

}
