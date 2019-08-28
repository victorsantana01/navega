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
          <p>viagem salvo com sucesso!</p>
        </div>
          
          <%
              
              String nomeViagem= request.getParameter("nomeViagem");
              String status = request.getParameter("status");
              String origem = request.getParameter("origem");
//              String dataInicio = request.getParameter("dataInicio");
              String destino = request.getParameter("destino");
//              String dataFim = request.getParameter("dataFim");
              String idBarco = request.getParameter("barco");
              String idcomandante = request.getParameter("comandante");
              String usuario = session.getAttribute("conta").toString();
              String date = request.getParameter("datetimes").replace("/", "-");
              String data[] = date.split(" - ");
              System.out.println("dateTimes - INICIO: "+data[0]);
              System.out.println("dateTimes - FIM: "+data[1]);
              String dataInicio = data[0];
              String dataFim =data[1];
              
              
              ViagemDao cons = new ViagemDao();
              cons.incluirViagem(nomeViagem, status, usuario, origem,dataInicio,destino,dataFim,idBarco,idcomandante);
              System.out.println("VIAGEM CADASTRADA COM SUCESSO!!!!!!!");
    String redirectURL = "/NavegaGestor/cadViagem.jsp";
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
