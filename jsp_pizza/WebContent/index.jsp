<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/css.css">
<title>이정훈</title>
</head>
<%
String section = request.getParameter("section") != null ? request.getParameter("section") : "";
%>
<body>
	<%@ include file="static/header.jsp" %>
	<%@ include file="static/nav.jsp" %>
	
	<%
	switch(section){
	case "insert_pizza":
		%><%@include file="page/insert_pizza.jsp" %><%
		break;
	case "select_sales":
		%><%@include file="page/select_sales.jsp" %><%
		break;
	case "select_point_sales":
		%><%@include file="page/select_point_sales.jsp" %><%
		break;
	case "select_product_sales":
		%><%@include file="page/select_product_sales.jsp" %><%
		break;
	default:
		%><%@include file="static/index.jsp" %><%
	}
	%>
	
	<%@ include file="static/footer.jsp" %>
</body>
</html>