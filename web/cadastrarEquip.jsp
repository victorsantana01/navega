<%@page import="dao.EquipV"%>
<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="logic.Format"%>
<%@page import="dao.Rpm"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>NAVEGA GESTOR</title>
        <!--Cabeçalho Para Materialize-->
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%
            /* Inicio de Sessão */
            String conta = session.getAttribute("conta").toString();
            System.out.println("Numero da conta é >>>>> " + conta);
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
            Statement stmt2 = con.createStatement();
            String equips = request.getParameter("mcts");
            
            EquipV equip = new EquipV();
            equip.setEquips(conta, con, stmt, stmt2, equips);
            
            String redirectURL = "/NavegaGestor/equipamentos.jsp";
            response.sendRedirect(redirectURL);
            
        %>

    </body>
</html>
