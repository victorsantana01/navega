<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="dao.ComandanteDao"%>
<%@page import="dao.ViagemDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>SB Admin - Start Bootstrap Template</title>
        <!-- Bootstrap core CSS-->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom fonts for this template-->
        <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <!-- Custom styles for this template-->
        <link href="css/sb-admin.css" rel="stylesheet">
    </head>

    <body class="bg-dark">
        <div class="container">
            <div class="card card-login mx-auto mt-5">
                <div class="card-header">Consumo</div>
                <div class="card-body">
                    <div class="text-center mt-4 mb-5">
                        <h4>Feito!</h4>
                        <p>Comandante excluido com sucesso!</p>
                    </div>
                    <%
                        String conta = session.getAttribute("conta").toString();
                        System.out.println("Numero da conta é >>>>> " + conta);
                        Connection con = ConexaoMySQL.getConexaoMySQL();
                        Statement stmt = con.createStatement();
                        
                        String idComandante = request.getParameter("idComandante");
                        System.out.println("************************************************************* "+idComandante);
                        ComandanteDao cons = new ComandanteDao();
                        cons.excluirComandante(conta, con, stmt, idComandante);
                        System.out.println("COMANDANTE EXCLUIDO COM SUCESSO!!!!!!!");
                        String redirectURL = "/NavegaGestor/cadComandante.jsp";
                        response.sendRedirect(redirectURL);
                    %>
                    <a class="btn btn-primary btn-block" href="tables.jsp">Reset Password</a>

                    <div class="text-center">

                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JavaScript-->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- Core plugin JavaScript-->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    </body>

</html>
