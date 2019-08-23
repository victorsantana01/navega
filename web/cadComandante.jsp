<%@page import="logic.Format"%>
<%@page import="dao.ComandanteDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
 
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
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <!--FIM Cabeçalho Para Materialize-->
        <script src="js/jquery.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
    
    
    </head>
    <body class="background #eeeeee grey lighten-3"> 
         
         <!--Materialize INICIALIZA o menu para Mobile -->
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
                         <li class="left-align">
                             <a class="dropdown-trigger" href="#!" data-target="dropdown1">
                                 <b class="center-align  waves-effect">Cadastros</b>
                             <i class="material-icons right">arrow_drop_down</i>
                             </a>
                             <ul id="dropdown1" class="dropdown-content">
                                <li class="left-align"><a href="cadViagem.jsp"><b class=" waves-effect">Cadastrar Viagem</b></a></li>
                                <li class="left-align"><a href="cadComandante.jsp"><b class=" waves-effect">Cadastrar Comandante</b></a></li>
                                <li class="left-align"><a href="cadBarco.jsp"><b class=" waves-effect">Cadastrar Barco</b></a></li>
                             </ul>
                         </li>
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
                            <span class="card-title">Cadastro de Comandante</span>
                            <div class="row">
                                <div class="container col s12">
                                    <div class="row ">

                                        <form id="mod" name="tab" action="cadastrarComandante.jsp" method="get">
                                            
                                            <div class="form-group col s12">
                                                <div class="form-row col s6 center-align">
                                                    <div class="input-field col s12 push-s6 center-align">
                                                        <input nome="nomeComandante" class="validate white-text" id="nomeComandante" type="text" placeholder="Nome" >
                                                        <label for="nomeComandate">Nome do Comandante</label>
                                                    </div>
                                                    <div class="input-field col s12 push-s6 center-align">
                                                        <input nome="matricula" class="validate white-text" id="matricula" type="text" placeholder="Matricula" >
                                                        <label for="matricula">Matricula</label>
                                                    </div>
                                                    <div class="input-field col s12 push-s6 center-align">
                                                        <input name="contato" class="validate white-text" id="contato" type="date"  placeholder="Contato">
                                                        <label for="matricula">Contato</label>
                                                    </div>
                                                </div>
                                                
                                                
                                                
                                            </div>
                                            <div class="card-action col s12">
                                                <a  class="btn col s4 center-align push-s4 z-depth-5  " onclick ='confirma(tab)'>Salvar<i class="material-icons right">send</i></a>
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

              $(".dropdown-trigger").dropdown();
          </script>
   
          <!--FIM do Corpo do App -->
        
        <!--Materialize JS -->
        <script src="js/materialize.js">
            
                document.addEventListener('DOMContentLoaded', function() {
                    var elems = document.querySelectorAll('select');
                    var instances = M.FormSelect.init(elems, options);
                });
                
        </script>
        <!--Materialize NavBar -->    
       
        
       
    </body>
</html>