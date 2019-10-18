<%@page import="java.sql.Statement"%>
<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page import="java.sql.Connection"%>
<%@page import="logic.Format"%>
<%@page import="dao.Rpm"%>  
<%@page import="dao.ConsumoDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
    <head>
        <title>NAVEGA GESTOR</title>
        <!--Cabeçalho Para Materialize-->
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style type="text/css">
     html { height: 100% }
     body { height: 100%; margin: 0; padding: 0 }
     .wrap { max-width: 110em; min-height: 90em; height:100%; width:100%; margin: 0 auto; padding-top: 2.5%;}
     #map-canvas { height: 100%; }
        </style>
        <!--Materialize Icones -->  
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Materialize CSS -->
        <link rel="stylesheet" type="text/css" href="css/materialize.css">
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <!--FIM Cabeçalho Para Materialize-->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </head>
    <%
   

  if( session.getAttribute("user") != null){
   System.out.println("Está logado o usuario: "+ session.getAttribute("user"));

  }else{
response.sendRedirect( "login.jsp" );
  }
    String conta = session.getAttribute("conta").toString();
    Connection con = ConexaoMySQL.getConexaoMySQL();
    Statement stmt = con.createStatement();
    String idMotorRecebido = request.getParameter("idMotor");
    ConsumoDao cons = new ConsumoDao();
    String[] dado = cons.getConsumoById(conta, con, stmt, idMotorRecebido) .clone();
    %>
    <body class=""> 
        <script type="text/javascript">

        $(document).ready(function(){
            $('.dropdown-trigger').dropdown();
            $('select').formSelect();
            $('.collapsible').collapsible();
        });
        </script>
        <!-- INICIO Botão de Add -->
        <div class="fixed-action-btn  click-to-toggle " style="bottom: 35px; right: 45px;">
            <a class="btn-floating z-depth-5 #4db6ac teal lighten-0 btn-large waves-effect z-depth-4"><i class="material-icons">add</i></a>
            <ul>
                <li>
                    <a href="lista.html" class="btn-floating z-depth-5 #4db6ac teal lighten-3 btn-large waves-effect z-depth-4">
                        <i class="material-icons">directions_run</i>clolse</a>
                </li>
            </ul>
        </div>
        <!-- FIM Botão de Add -->
        <!-- Dropdown Structure -->
        <ul id="dropdown1" class="dropdown-content">
            <li><a href="cadBarco.jsp">Barco</a></li>
            <li class="divider"></li>
            <li><a href="cadComandante.jsp">Comandante</a></li>
            <li class="divider"></li>
            <li><a href="cadViagem.jsp">Viagem</a></li>
        </ul>
        <nav>
            <div class="nav-wrapper" style="background-color: #0277bd !important;">
                <a href="index.jsp" class="brand-logo">NAVEGA GESTOR</a>
                <ul class="right hide-on-med-and-down">
                    <li><a href="macros.jsp">Macros</a></li>
                    <li><a href="listarMacros.jsp">Definição da Macro</a></li>
                    <li><a href="viagens.jsp">Viagens</a></li>
                    <!-- Dropdown Trigger -->
                    <li><a class="dropdown-trigger" href="#!" data-target="dropdown1">Cadastro<i class="material-icons right">arrow_drop_down</i></a></li>
                    <li><a href="tables.jsp">Tabela de Consumo</a></li>
                    <li><a href="motores.jsp">Motores</a></li>
                    <li><a href="login.jsp">Sair</a></li>
                </ul>
            </div>
        </nav>
        <!--INICIO do Corpo do App -->
          
      
       
        <div class=" container "><br>
            <div class="row ">
                <div class="col s12">
                    <div class="card offset-s5">
                        <div class="card-content black-text ">
                            <span class="card-title"><b>Tabela de consumo</b></span>
                            <div class="row">
                                <div class="container col s12">
                                    <div class="row ">

                                        <form id="mod" name="tab" action="faixaEdita.jsp" method="get">
                                            <div class="form-group">
                                                <div class="form-row">
                                                    <div class="input-filed col s12">
                                                        <label for="exampleInputName">IdMotor</label>
                                                        <input name="idMotor" class="form-control" id="idMotor" type="text" aria-describedby="nameHelp" value="<%=dado[29]%>" disabled>
                                                    </div>
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">Motor</label>
                                                        <input name="motor" class="form-control" id="exampleInputName" type="text" aria-describedby="nameHelp" placeholder="Motor" value="<%=dado[0]%>" required>

                                                    </div>
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputLastName">400RPM</label>
                                                        <input name="cons0" class="form-control" id="exampleInputLastName" type="number"  aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[28]%>" required>
                                                    </div>
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">500RPM</label>
                                                        <input name="cons1" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[1]%>" required>
                                                    </div>
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">600RPM/Hora</label>
                                                        <input name="cons2" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[2]%>" required>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="form-group" >
                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">700RPM</label>
                                                        <input name="cons3" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[3]%>" required>
                                                    </div>

                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">800RPM</label>
                                                        <input name="cons4" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[4]%>" required>

                                                    </div>
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">900RPM</label>
                                                        <input name="cons5" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[5]%>" required>

                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1000RPM</label>
                                                        <input name="cons6" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[6]%>" required>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1100RPM</label>
                                                        <input name="cons7" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[7]%>" required>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1200RPM</label>
                                                        <input name="cons8" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[8]%>" required>

                                                    </div>
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1300RPM</label>
                                                        <input name="cons9" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[9]%>" required>

                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1400RPM</label>
                                                        <input name="cons10" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[10]%>" required>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1500RPM</label>
                                                        <input name="cons11" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[11]%>" required>

                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1600RPM</label>
                                                        <input name="cons12" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[12]%>" required>              
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1700RPM</label>
                                                        <input name="cons13" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[13]%>" required>
                                                    </div>
                                                </div>



                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1800RPM</label>
                                                        <input name="cons14" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[14]%>" required>
                                                    </div>
                                                </div>

                                                <div class="form-row">   
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1900RPM</label>
                                                        <input name="cons15" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[15]%>" required>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2000RPM</label>
                                                        <input name="cons16" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[16]%>" required>
                                                    </div>
                                                </div>

                                                <div class="form-row">    
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2100RPM</label>
                                                        <input name="cons17" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[17]%>" required>             
                                                    </div>
                                                </div>


                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2200RPM</label>
                                                        <input name="cons18" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[18]%>" required>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2300RPM</label>
                                                        <input name="cons19" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[19]%>" required>
                                                    </div>
                                                </div>


                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2400RPM</label>
                                                        <input name="cons20" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[20]%>" required>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2500RPM</label>
                                                        <input name="cons21" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[21]%>" required>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2600RPM</label>
                                                        <input name="cons22" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[22]%>" required>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2700RPM</label>
                                                        <input name="cons23" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[23]%>" required>

                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2800RPM</label>
                                                        <input name="cons24" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[24]%>" required>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2900RPM</label>
                                                        <input name="cons25" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[25]%>" required>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">3000RPM</label>
                                                        <input name="cons26" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros" value="<%=dado[26]%>" required>              
                                                    </div>
                                                </div>


                                                <div class="card-action col s12">
                                                    <a  class="btn col s6 center-align push-s3 z-depth-5  " style="margin-top: 20px;" onclick ='confirma(tab)'>Editar<i class="material-icons right">send</i></a>
                                                </div>


                                        </form>
                                    </div>


                                </div>
                            </div>

                        </div>


                    </div>

                </div>
            </div>
        </div>
    </div>
   
    <script type="text/javascript">
             function confirma (form){
              form.submit();
              return false;   
             }
          </script>
   
          <!--FIM do Corpo do App -->
        
        <!--Materialize JS -->
        <script src="js/materialize.js"></script>
         <!--Materialize INICIALIZA o menu para Mobile -->
       
        
       
    </body>
</html>