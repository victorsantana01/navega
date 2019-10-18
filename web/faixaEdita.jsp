<%@page import="dao.ConsumoDao"%>
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
          <p>Faixas de RPM salvas com Sucesso</p>
        </div>
          
          <%
              
              String conta = session.getAttribute("conta").toString();
              String nome = request.getParameter("motor");
              String idMotor = request.getParameter("idMotor");
              String rpm400= request.getParameter("cons0");
              String rpm500= request.getParameter("cons1");
              String rpm600= request.getParameter("cons2");
              String rpm700= request.getParameter("cons3");
              String rpm800= request.getParameter("cons4");
              String rpm900= request.getParameter("cons5");
              String rpm1000= request.getParameter("cons6");
              String rpm1100= request.getParameter("cons7");
              String rpm1200= request.getParameter("cons8");
              String rpm1300= request.getParameter("cons9");
              String rpm1400= request.getParameter("cons10");
              String rpm1500= request.getParameter("cons11");
              String rpm1600= request.getParameter("cons12");
              String rpm1700= request.getParameter("cons13");
              String rpm1800= request.getParameter("cons14");
              String rpm1900= request.getParameter("cons15");
              String rpm2000= request.getParameter("cons16");
              String rpm2100= request.getParameter("cons17");
              String rpm2200= request.getParameter("cons18");
              String rpm2300= request.getParameter("cons19");
              String rpm2400= request.getParameter("cons20");
              String rpm2500= request.getParameter("cons21");
              String rpm2600= request.getParameter("cons22");
              String rpm2700= request.getParameter("cons23");
              String rpm2800= request.getParameter("cons24");
              String rpm2900= request.getParameter("cons25");
              String rpm3000= request.getParameter("cons26");
              //String descricao= request.getParameter("descricao");
              
              
              
              ConsumoDao cons = new ConsumoDao();
              cons.incluirFaixa(conta,idMotor,nome, rpm400, rpm500, rpm600, rpm700, rpm800, rpm900, rpm1000,
                      rpm1100, rpm1200, rpm1300, rpm1400, rpm1500, rpm1600, rpm1700, rpm1800,
                      rpm1900, rpm2000, rpm2100, rpm2200, rpm2300, rpm2400, rpm2500, rpm2600,
                      rpm2700, rpm2800, rpm2900, rpm3000, "");
            

    String redirectURL = "/NavegaGestor/motores.jsp";
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
