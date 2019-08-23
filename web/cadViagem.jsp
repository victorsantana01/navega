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
                            <span class="card-title">Cadastro de Viagem</span>
                            <div class="row">
                                <div class="container col s12">
                                    <div class="row ">

                                        <form id="mod" name="tab" action="cadastrarViagem.jsp" method="get">
                                            
                                            <div class="form-group col s12">
                                                <div class="form-row col s6 ">
                                                    <div class="input-field col s12">
                                                        <input nome="nomeViagem" class="validate white-text" id="nomeViagem" type="text" placeholder="Viagem" >
                                                        <label for="nomeViagem">Nome da Viagem</label>
                                                    </div>
                                                </div>
                                                <div class="form-group col s12">
                                                    <div class="input-field col s6">
                                                        <input nome="origem" class="validate white-text" id="origem" type="text" placeholder="Origem" >
                                                        <label for="origem">Origem</label>
                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input name="dataInicio" class="form-control col s8" id="dataInicio" type="date"  aria-describedby="nameHelp">
                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input nome="destino" class="validate white-text" id="destino" type="text" placeholder="Destino" >
                                                        <label for="destino">Destino</label>
                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input name="dataFim" class="form-control col s8" id="dataFim" type="date"  aria-describedby="nameHelp">
                                                    </div>
                                                </div>
                                                <div class="form-group col s12">
                                                     <span class="card-title col s12 center-align">Embarcação</span>
                                                    <div class="input-field col s6">
                                                        <input nome="nomeBarco" class="validate white-text" id="nomeBarco" type="text" placeholder="Nome da Embarcação" >
                                                        <label for="nomeBarco">Nome da Embarcação</label>
                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input nome="motor" class="validate white-text" id="motor" type="text" placeholder="Motor" >
                                                        <label for="motor">Motor</label>
                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input nome="modelo" class="validate white-text" id="modelo" type="text" placeholder="Modelo" >
                                                        <label for="modelo">Modelo</label>
                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input nome="base" class="validate white-text" id="base" type="text" placeholder="Base" >
                                                        <label for="base">Base</label>
                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input nome="idComandante" class="validate white-text" id="base" type="text" placeholder="Id do Comandante" >
                                                        <select class="browser-default" name="mct" >
                                                            <option value="" disabled selected>Empurrador</option>
                                                            <%
                                                                Rpm rpm = new Rpm();
                                                                String[][] veiculo = rpm.painelAtualizado(conta,con,stmt).clone();
                                                                for (int i = 0; i < 100; i++) {
                                                                    if (veiculo[1][i] == null) {
                                                                        i = 100;
                                                                    } else {
                                                            %>
                                                            <option value="<%=veiculo[1][i]%>"><%=veiculo[0][i] + " - " + veiculo[1][i]%> </option>
                                                            <%}
                                                            }%>
                                                        </select>
                                                    </div>
                                                     <div class="col s6">
                                                        <label>Status de Viagem</label>
                                                        <select class="browser-default" name="mct" >
                                                          <option value="" disabled selected>Escolha um Status</option>
                                                          <option value="1">Agendado</option>
                                                          <option value="2">Em Pregresso</option>
                                                          <option value="3">Finalizado</option>
                                                        </select>
                                                        
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