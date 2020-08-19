<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page import="dao.BarcoDao"%>
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
</head>

<body class="bg-dark">
    <!-- INCLUDE DA NAVBAR -->
    <jsp:include page="navbar.jsp"></jsp:include>

    <div class="container">
        <div class="card card-login mx-auto mt-5">
            <div class="card-header"><h3 style="margin: 20px; text-align: center;" >Tipo de Dado</h3></div>
            <div class="card-body">
                <div class="text-center mt-4 mb-5">
                  <h4>Feito!</h4>
                  <p>Comandante editado com sucesso!</p>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
