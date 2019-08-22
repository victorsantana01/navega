<%-- 
    Document   : login2
    Created on : 17/08/2017, 15:55:27
    Author     : Victor Santana
--%>

<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="dao.LoginDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">  
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
    <%

        String usuario = request.getParameter("user");
        String senha = request.getParameter("senha").toString();
        String contaCliente = "";

        Connection con = ConexaoMySQL.getConexaoMySQL();

        Statement stmt = con.createStatement();

        LoginDao lo = new LoginDao();
        String result = lo.getCredenci(usuario, senha, con, stmt);
        if (result != null) {

            response.sendRedirect("index.jsp");
            session.setAttribute("user", lo.getResponsavelSession(usuario, senha, con, stmt)[0][0]);
            session.setAttribute("conta", lo.getResponsavelSession(usuario, senha,  con, stmt)[2][0]);

        } else {
            response.sendRedirect("acessoNegado.jsp");
    }
        
    %>
    
    <%
   con.close();
   stmt.close();
   %>
</body>
</html>