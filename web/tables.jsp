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
        <script src="js/jquery.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
    </head>
    <%
   

  if( session.getAttribute("user") != null){
   System.out.println("Está logado o usuario: "+ session.getAttribute("user"));

  }else{
response.sendRedirect( "login.jsp" );
  }%>
    <body class=""> 
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
         <!--Materialize NavBar -->    
       <ul id="menu-mobile" class="side-nav fixed " style="width: 300px">
            <li>
                <div class="user-view">
                    <a href="index.jsp" >
                        <div class="background">
                            <img src="img/mar.jpg" alt=""/>
                        </div>
                        <div class="center">
                            <b><h4 class="white-text">Navega Gestor</h4></b> 
                        </div>
                        <div class="center">
                            <b class="white-text">Gestão à bordo</b>
                        </div>
                    </a>
                </div>
            </li>   


            <li class="left-align"><a href="index.jsp" ><b><i class="material-icons">home</i>&nbsp;&nbsp;&nbsp;</b><b class="center-align  waves-effect"><h6>Inicio</h6></b></a></li>
            <li class="left-align"><a href="cadBarco.jsp"><b><i class="material-icons">directions_boat</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Cadastro Embarcação</h6></b></a></li>
            <li class="left-align"><a href="cadComandante.jsp"><b><i class="material-icons">person_add</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Cadastro Comandante</h6></b></a></li>
            <li class="left-align"><a href="cadViagem.jsp"><b><i class="material-icons">map</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Cadastro Viagem</h6></b></a></li>
            <li class="left-align"><a href="viagens.jsp"><b><i class="material-icons">directions_boat</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Viagens</h6></b></a></li>
            <li class="left-align"><a href="viagens2.jsp"><b><i class="material-icons">directions_boat</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Detalhe da Macro</h6></b></a></li>
            <li class="left-align"><a href="listarMacros.jsp"><b><i class="material-icons">directions_boat</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Definição da Macro</h6></b></a></li>
            <li class="left-align"><a href="tables.jsp"><b><i class="material-icons">receipt</i>&nbsp;&nbsp;&nbsp;</b><b class="center-align  waves-effect"><h6>Tabela de Consumo</h6></b></a></li>
            <li class="left-align"><a href="motores.jsp"><b><i class="material-icons">build</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Motores</h6></b></a></li>
            <li class="left-align"><a href="login.jsp"><b><i class="material-icons">assignment_ind</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Sair</h6></b></a></li>
    </ul>
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

                                        <form id="mod" name="tab" action="faixasalva.jsp" method="get">
                                            <div class="form-group">
                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">Motor</label>
                                                        <input name="motor" class="form-control" id="exampleInputName" type="text" aria-describedby="nameHelp" placeholder="Motor">

                                                    </div>
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputLastName">400RPM</label>
                                                        <input name="cons0" class="form-control" id="exampleInputLastName" type="number"  aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">500RPM</label>
                                                        <input name="cons1" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">600RPM/Hora</label>
                                                        <input name="cons2" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="form-group" >
                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">700RPM</label>
                                                        <input name="cons3" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>

                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">800RPM</label>
                                                        <input name="cons4" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">

                                                    </div>
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">900RPM</label>
                                                        <input name="cons5" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">

                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1000RPM</label>
                                                        <input name="cons6" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1100RPM</label>
                                                        <input name="cons7" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1200RPM</label>
                                                        <input name="cons8" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">

                                                    </div>
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1300RPM</label>
                                                        <input name="cons9" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">

                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1400RPM</label>
                                                        <input name="cons10" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1500RPM</label>
                                                        <input name="cons11" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">

                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1600RPM</label>
                                                        <input name="cons12" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">              
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1700RPM</label>
                                                        <input name="cons13" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>



                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1800RPM</label>
                                                        <input name="cons14" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">   
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">1900RPM</label>
                                                        <input name="cons15" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2000RPM</label>
                                                        <input name="cons16" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">    
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2100RPM</label>
                                                        <input name="cons17" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">             
                                                    </div>
                                                </div>


                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2200RPM</label>
                                                        <input name="cons18" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2300RPM</label>
                                                        <input name="cons19" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>


                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2400RPM</label>
                                                        <input name="cons20" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2500RPM</label>
                                                        <input name="cons21" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2600RPM</label>
                                                        <input name="cons22" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2700RPM</label>
                                                        <input name="cons23" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">

                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2800RPM</label>
                                                        <input name="cons24" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">2900RPM</label>
                                                        <input name="cons25" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s3">
                                                        <label for="exampleInputName">3000RPM</label>
                                                        <input name="cons26" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">              
                                                    </div>
                                                </div>


                                                <div class="card-action col s12">
                                                    <a  class="btn col s6 center-align push-s3 z-depth-5  " style="margin-top: 20px;" onclick ='confirma(tab)'>Salvar<i class="material-icons right">send</i></a>
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