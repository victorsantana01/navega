<%@page import="logic.Format"%>
<%@page import="dao.ComandanteDao"%>
<%@page import="dao.BarcoDao"%>
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
    <%
   

  if( session.getAttribute("user") != null){
   System.out.println("Está logado o usuario: "+ session.getAttribute("user"));

  }else{
response.sendRedirect( "login.jsp" );
  }%>
    <body class="background #eeeeee grey lighten-3"> 
         
    <script type="text/javascript">
     $(".dropdown-trigger").dropdown();
        $(document).ready(function(){
            $('.datepicker').datepicker();
        });
     
     </script>
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
          
      
       
        <div class=" container"><br>
            <div class="row ">
                <div class="col s12">
                    <div class="card blue-grey darken-1 offset-s5 z-depth-5">
                        <div class="card-content white-text ">
                            <span class="card-title">Cadastro de Viagem</span>
                            <div class="row">
                                <div class="container col s12">
                                    <div class="row ">

                                        <form id="mod" name="tab" action="cadastrarViagem.jsp" method="get">
                                            
                                            <div class="form-group col s12">
                                                <div class="form-row col s6 ">
                                                    <div class="input-field col s12">
                                                        <input name="nomeViagem" class="validate white-text" id="nomeViagem" type="text" required>
                                                        <label for="nomeViagem">Nome da Viagem</label>
                                                    </div>
                                                </div>
                                                <div class="input-field col s6">
                                                        <select class="browser-default" name="status" required >
                                                            <option value="" disabled selected>Status de Viagem</option>
                                                           <option value="0">Agendado</option>
                                                           <option value="1">Em Progresso</option>
                                                           <option value="2">Finalizado</option>
                                                        </select>
                                                </div>
                                                <div class="form-group col s12">
                                                    <div class="input-field col s6">
                                                        <input name="origem" class="validate white-text" id="origem" type="text" required>
                                                        <label for="origem">Origem</label>
                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input name="dataInicio" class="form-control col s8" id="dataInicio" type="date"  aria-describedby="nameHelp" required>
                                                        <label for="dataInicio">Data de Inicio </label> 
                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input name="destino" class="validate white-text" id="destino" type="text" required> 
                                                        <label for="destino">Destino</label>
                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input name="dataFim" class="form-control col s8" id="dataFim" type="date"  aria-describedby="nameHelp" required>
                                                        <label for="dataFim">Data de Termino </label>
                                                    </div> 
                                                </div>
                                                <div class="form-group col s12">
                                                     <span class="card-title">Embarcação</span>
                                                    
                                                     <div class="input-field col s6">
                                                        <select class="browser-default" name="barco" required > 
                                                            <option value="" disabled selected>Barco</option>
                                                                                                                    <%
                                                                BarcoDao bar = new BarcoDao();
                                                                String[][] barcos = bar.pesquisaBarcos().clone();
                                                                for (int i = 0; i < 10; i++) {
                                                                    if (barcos[i][0] == null) {
                                                                        i = 50;
                                                                    } else {
                                                            %>
                                                           <option value="<%=barcos[i][0]%>"><%=barcos[i][1]%></option>

                                                            <%
                                                                    }
                                                                }%>
                                                        </select>
                                                    </div>
                                                    <div class="input-field col s6"> 
                                                        <select class="browser-default" name="comandante" id="comandante" required>
                                                            <option value="" disabled selected>Comandante</option>
                                                                                                                    <%
                                                                ComandanteDao com = new ComandanteDao();
                                                                String[][] comandantes = com.pesquisaComandantes().clone();
                                                                for (int i = 0; i < 10; i++) {
                                                                    if (comandantes[i][0] == null) {
                                                                        i = 50;
                                                                    } else {
                                                            %>
                                                           <option value="<%=comandantes[i][0]%>"><%=comandantes[i][1]%></option>

                                                            <%
                                                                    }
                                                                }%>
                                                        </select>
                                                    </div>

                                                </div>
                                                
                                                
                                                
                                            </div>
                                            <div class="card-action col s12">
                                                <input type="submit" class="btn col s4 center-align push-s4 z-depth-5  " >Salvar<i class="material-icons right">send</i>/>
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