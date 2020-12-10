<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection
				("jdbc:oracle:thin:@//localhost/xe", "system", "1234");
%>

<script>
	var valueCk = true
	function chake(inputBox, errorMsg) {
		if ((inputBox.value === "" || inputBox.value <= 0) && valueCk == true) {
			if(!inputBox === document.input_form.gender){
				inputBox.focus();
			}
			alert(errorMsg);
			valueCk = fasle;
			return;
		} else {
			return;
		}
		valueCk = true;
	}
	function submit_form() {
			alert("정상적으로 처리되었습니다.")
			document.input_form.submit();
	}

	function reset_form() {
		document.input_form.reset();
	}
</script>
<form action="action/insert_pizza_action.jsp" method="post" name="input_form">
	<table border="1">
		<tr>
			<td>매출전표번호</td>
			<td><input type="text" name="saleno"></td>
		</tr>
		<tr>
			<td>지점코드</td>
			<td><input type="text" name="scode"></td>
		</tr>
		<tr>
			<td>판매일자</td>
			<td><input type="date" name="date"></td>
		</tr>
		<tr>
			<td>피자코드</td>
			<td>
				<select name="pcode">
					<%
					Statement stmt = conn.createStatement();
					String query = "select pizza.pcode, pizza.pname from tbl_pizza_01 PIZZA";
					ResultSet rs = stmt.executeQuery(query);
					while(rs.next()){
					%>
						<option value="<%=rs.getString(1) %>"> [<%=rs.getString(1) %>] <%=rs.getString(2) %></option>
					<%
					}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td>판매수량</td>
			<td><input type="number" name="amount"></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" value="등록하기" onclick="submit_form()">
				<input type="button" value="다시쓰기" onclick="reset_form()">
			</td>
		</tr>
	</table>
</form>
<%
		stmt.close();
		conn.close();
	}
	catch (Exception e) {
		e.printStackTrace();
	}
%>