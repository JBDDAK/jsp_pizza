<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import = "java.text.DecimalFormat" %>
<table border="1">
  <tr>
    <th>지점 코드</th>
    <th>지점 명</th>
    <th>총매출액</th>
  </tr>
<%
	DecimalFormat formatter2 = new DecimalFormat("###,###");
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
		String query = "select shop.scode, shop.sname, sum(salelist.amount*pizza.cost) from tbl_pizza_01 PIZZA, tbl_shop_01 SHOP, tbl_salelist_01 SALELIST "+
				"WHERE shop.scode = salelist.scode "+
				"and salelist.pcode = pizza.pcode "+
				"group by shop.scode, shop.sname "+ 
				"order by shop.scode";
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
				out.print("<tr>");
				out.print("<td>"+ rs.getString(1) + "</td>");
				out.print("<td>"+ rs.getString(2) + "</td>");
				out.print("<td>\\"+ formatter2.format(rs.getInt(3)) + "</td>");
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