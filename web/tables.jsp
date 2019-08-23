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
       <div class="navbar-fixed z-depth-5">

         <nav class="#00838f cyan darken-3">
             
                 <div class="nav-wrapper" >
                     &nbsp;&nbsp;<a href="index.jsp" class="brand-logo right-aligned"><b><i class="material-icons">directions_boat</i><h5>NAVEGA GESTOR</h5></b></a>
                     <ul id="nav-mobile" class="right hide-on-med-and-down">
                         <li class="left-align"><a href="index.jsp" ><b class="center-align  waves-effect">Inicio</b></a></li>
                         <li class="left-align"><a href="relatorio1.jsp"><b class=" waves-effect">Relatorio RPM</b></a></li>
                         <li class="left-align"><a href="relatorio2.jsp"><b class=" waves-effect">Relatorio Consolidado</b></a></li>
                         <li class="left-align"><a href="tables.jsp"><b class="center-align  waves-effect">Tabela de Consumo</b></a></li>
                         <li class="left-align"><a href="motores.jsp"><b class=" waves-effect">Motores</b></a></li>
                         <li class="left-align"><a href="login.jsp"><b class=" waves-effect">Sair</b></a></li>
                     </ul>
                 </div>
          
         </nav>
       </div>
        <!--INICIO do Corpo do App -->
          
      
       
        <div class=" container "><br>
            <div class="row ">
                <div class="col s12">
                    <div class="card blue-grey darken-1 offset-s5">
                        <div class="card-content white-text ">
                            <span class="card-title">Tabela de consumo</span>
                            <div class="row">
                                <div class="container col s12">
                                    <div class="row ">

                                        <form id="mod" name="tab" action="faixasalva.jsp" method="get">
                                            <div class="form-group">
                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">Motor</label>
                                                        <input name="motor" class="form-control" id="exampleInputName" type="text" aria-describedby="nameHelp" placeholder="Motor">

                                                    </div>
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputLastName">400RPM</label>
                                                        <input name="cons0" class="form-control" id="exampleInputLastName" type="text"  aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="form-group" >
                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">500RPM</label>
                                                        <input name="cons1" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">600RPM/Hora</label>
                                                        <input name="cons2" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">


                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">700RPM</label>
                                                        <input name="cons3" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>

                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">800RPM</label>
                                                        <input name="cons4" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">

                                                    </div>
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">900RPM</label>
                                                        <input name="cons5" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">

                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">1000RPM</label>
                                                        <input name="cons6" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">1100RPM</label>
                                                        <input name="cons7" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">1200RPM</label>
                                                        <input name="cons8" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">

                                                    </div>
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">1300RPM</label>
                                                        <input name="cons9" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">

                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">1400RPM</label>
                                                        <input name="cons10" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">1500RPM</label>
                                                        <input name="cons11" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">

                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">1600RPM</label>
                                                        <input name="cons12" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">              
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">1700RPM</label>
                                                        <input name="cons13" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>



                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">1800RPM</label>
                                                        <input name="cons14" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">   
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">1900RPM</label>
                                                        <input name="cons15" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">2000RPM</label>
                                                        <input name="cons16" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">    
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">2100RPM</label>
                                                        <input name="cons17" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">             
                                                    </div>
                                                </div>


                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">2200RPM</label>
                                                        <input name="cons18" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">2300RPM</label>
                                                        <input name="cons19" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>


                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">2400RPM</label>
                                                        <input name="cons20" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">2500RPM</label>
                                                        <input name="cons21" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">2600RPM</label>
                                                        <input name="cons22" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">2700RPM</label>
                                                        <input name="cons23" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">

                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">2800RPM</label>
                                                        <input name="cons24" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">2900RPM</label>
                                                        <input name="cons25" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="input-field col s6">
                                                        <label for="exampleInputName">3000RPM</label>
                                                        <input name="cons26" class="form-control" id="exampleInputName" type="number" aria-describedby="nameHelp" placeholder="Litros">              
                                                    </div>
                                                </div>


                                                <div class="card-action">
                                                    <a  class="btn col s6 center-align push-s3 z-depth-5  " onclick ='confirma(tab)'>Salvar<i class="material-icons right">send</i></a>
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