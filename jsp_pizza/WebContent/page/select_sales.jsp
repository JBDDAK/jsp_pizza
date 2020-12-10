<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import = "java.text.DecimalFormat" %>
<table border="1">
  <tr>
    <th>매출전표번호</th>
    <th>지점</th>
    <th>판매일자</th>
    <th>피자코드</th>
    <th>피자명</th>
    <th>판매수명</th>
    <th>매출액</th>
  </tr>

<%
	
	DecimalFormat formatter = new DecimalFormat("###,###");
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection
				("jdbc:oracle:thin:@//localhost/xe", "system", "1234");
		if (conn != null) {
			System.out.println("Database Connected!");
		}
		else {
			System.out.println("Database Connect Fail!");
		}
		Statement stmt = conn.createStatement();
		String query = "select salelist.saleno, shop.scode || '-' || shop.sname, salelist.saledate, salelist.pcode, pizza.pname,salelist.amount, salelist.amount * pizza.cost from tbl_pizza_01 PIZZA, tbl_shop_01 SHOP, tbl_salelist_01 SALELIST "+
				"WHERE shop.scode = salelist.scode "+
				"and salelist.pcode = pizza.pcode "+
				"order by shop.sname, pizza.pcode";
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
				out.print("<tr>");
				out.print("<td>"+ rs.getString(1) + "</td>");
				out.print("<td>"+ rs.getString(2) + "</td>");
				out.print("<td>"+ rs.getString(3) + "</td>");
				out.print("<td>"+ rs.getString(4) + "</td>");
				out.print("<td>"+ rs.getString(5) + "</td>");
				out.print("<td>"+ rs.getInt(6) + "</td>");
				out.print("<td>\\"+ formatter.format(rs.getInt(7)) + "</td>");
				out.print("</tr>");
		}
		stmt.close();
		conn.close();
	}
	catch (Exception e) {
		e.printStackTrace();
	}
%>
</table>