<%@page import="logic.Format"%>
<%@page import="dao.ViagemDao"%>
<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="logic.Format"%>
<%@page import="dao.Rpm"%>
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
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <!--FIM Cabeçalho Para Materialize-->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </head>
    
    <body>
        <%
        /* Inicio de Sessão */
        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> "+conta);
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        %>
        
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
            <li class="left-align"><a href="macros.jsp"><b><i class="material-icons">description</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Macros</h6></b></a></li>
            <li class="left-align"><a href="listarMacros.jsp"><b><i class="material-icons">description</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Definição da Macro</h6></b></a></li>
            <li class="left-align"><a href="tables.jsp"><b><i class="material-icons">receipt</i>&nbsp;&nbsp;&nbsp;</b><b class="center-align  waves-effect"><h6>Tabela de Consumo</h6></b></a></li>
            <li class="left-align"><a href="motores.jsp"><b><i class="material-icons">build</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Motores</h6></b></a></li>
            <li class="left-align"><a href="login.jsp"><b><i class="material-icons">assignment_ind</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Sair</h6></b></a></li>
        </ul>

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
      <div class="container" style="padding-top:20px">
          <div class="row"><!--INCIO DO CORPO DA PAGINA-->
           <% ViagemDao viagem = new ViagemDao(); 
           Format format = new Format();
           %>
            <div class="card large col s4" style="overflow-y: auto">
                <div class="card-title center"><i class="material-icons">schedule</i><b>  Viagens Agendadas</b></div>
                <ul class="collapsible">
                    <%
                        String[][] viagensAgendadas = viagem.pesquisarViagensPorStatus(conta, con, stmt,"0");
                        for(int i=0;i < 100; i++){
                            if(viagensAgendadas[0][i] == null){
                                i = 200;
                            }else{
                                String viagemDataOrigemFormatada = format.DataFormat(viagensAgendadas[4][i].split(" ")[0]);
                                String viagemDataDestinoFormatada = format.DataFormat(viagensAgendadas[6][i].split(" ")[0]);
                                String viagemDataCriacaoFormatada = format.DataFormat(viagensAgendadas[11][i].split(" ")[0]);
                                %>
                    <li>
                        <div class="collapsible-header"><i class="material-icons">filter_drama</i><span><%=viagensAgendadas[1][i].toUpperCase()%></span><span class="badge"><%=viagemDataCriacaoFormatada%></span></div>
                                <div class="collapsible-body">
                                    <p><b>Nome da Viagem: </b><%=viagensAgendadas[1][i]%></p>
                                    <p><b>Origem:</b> <%=viagensAgendadas[3][i]%><b>  Data: </b><%=viagemDataOrigemFormatada%> </p>
                                    <p><b>Destino:</b> <%=viagensAgendadas[5][i]%><b>  Data: </b><%=viagemDataDestinoFormatada%> </p>
                                    
                                    <div class="row" style="margin:0px !important">
                                        <div class="col s12">
                                            <h5 class="center col s12"><b>Relatorio</b></h5><br>
                                            <a class="btn waves-effect waves-light center col s6" href="relatorioConsolidado.jsp?idViagem=<%=viagensAgendadas[0][i]%>">Consolidado</a><br>
                                            <a class="btn waves-effect waves-light center col s6" href="relatorioDetalhado.jsp?idViagem=<%=viagensAgendadas[0][i]%>">Detalhado</a>
                                        </div>
                                    </div>
                                            
                                </div>
                                <%
                            }
                        }
                        
                    %>
                    
                    
                </li>
            </ul>
            </div>
            <div class="card large col s4" style="overflow-y: auto">
                <div class="card-title center"><i class="material-icons">directions_boat</i>  Viagens Em andamento</div>
                <ul class="collapsible">
                <%
                        String[][] viagensEmAndamento = viagem.pesquisarViagensPorStatus(conta, con, stmt, "1");
                        for(int i=0;i < 100; i++){
                            if(viagensEmAndamento[0][i] == null){
                                i = 200;
                            }else{
                                String viagemDataOrigemFormatada = format.DataFormat(viagensEmAndamento[4][i].split(" ")[0]);
                                String viagemDataDestinoFormatada = format.DataFormat(viagensEmAndamento[6][i].split(" ")[0]);
                                String viagemDataCriacaoFormatada = format.DataFormat(viagensEmAndamento[11][i].split(" ")[0]);
                                %>
                    <li>
                    
                        <div class="collapsible-header"><i class="material-icons">directions_boat</i><span><%=viagensEmAndamento[1][i].toUpperCase()%></span><span class="badge"><%=viagemDataCriacaoFormatada%></span></div>
                                <div class="collapsible-body">
                                    <p><b>Nome da Viagem: </b><%=viagensEmAndamento[1][i]%></p>
                                    <p><b>Origem:</b> <%=viagensEmAndamento[3][i]%><b>  Data: </b><%=viagemDataOrigemFormatada%> </p>
                                    <p><b>Destino:</b> <%=viagensEmAndamento[5][i]%><b>  Data: </b><%=viagemDataDestinoFormatada%> </p>
                                    <div class="row" style="margin:0px !important">
                                        <div class="col s12">
                                            <h5 class="center col s12"><b>Relatorio</b></h5>
                                            <a class="btn waves-effect waves-light center col s6" href="relatorioConsolidado.jsp?idViagem=<%=viagensEmAndamento[0][i]%>">Consolidado</a>
                                            <a class="btn waves-effect waves-light center col s6" href="relatorioDetalhado.jsp?idViagem=<%=viagensEmAndamento[0][i]%>">Detalhado</a>
                                        </div>
                                    </div>
                                      
                                </div>
                                <%
                            }
                        }
                        
                    %>
                    
                    
                </li>
            </ul>
            </div>  
            <div class="card large col s4" style="overflow-y: auto">
                <div class="card-title center"><i class="material-icons">check</i>  Viagens Finalizadas</div>
                <ul class="collapsible">
                    <%
                        String[][] viagensFinalizadas = viagem.pesquisarViagensPorStatus(conta, con, stmt, "2");
                        for(int i=0;i < 100; i++){
                            if(viagensFinalizadas[0][i] == null){
                                i = 200;
                            }else{
                                String viagemDataOrigemFormatada = format.DataFormat(viagensFinalizadas[4][i].split(" ")[0]);
                                String viagemDataDestinoFormatada = format.DataFormat(viagensFinalizadas[6][i].split(" ")[0]);
                                String viagemDataCriacaoFormatada = format.DataFormat(viagensFinalizadas[11][i].split(" ")[0]);
                                %>
                    <li>
                    <li>
                    
                        <div class="collapsible-header"><i class="material-icons">filter_drama</i><span><%=viagensFinalizadas[1][i].toUpperCase()%></span><span class="badge"><%=viagemDataCriacaoFormatada%></span></div>
                                <div class="collapsible-body">
                                    <p><b>Nome da Viagem: </b><%=viagensFinalizadas[1][i]%></p>
                                    <p><b>Origem:</b> <%=viagensFinalizadas[3][i]%><b>  Data: </b><%=viagemDataOrigemFormatada%> </p>
                                    <p><b>Destino:</b> <%=viagensFinalizadas[5][i]%><b>  Data: </b><%=viagemDataDestinoFormatada%> </p>
                                    <div class="row" style="margin:0px !important">
                                        <div class="col s12">
                                            <h5 class="center col s12"><b>Relatorio</b></h5>
                                            <a class="btn waves-effect waves-light center col s6" href="relatorioConsolidado.jsp?idViagem=<%=viagensFinalizadas[0][i]%>">Consolidado</a>
                                            <a class="btn waves-effect waves-light center col s6" href="relatorioDetalhado.jsp?idViagem=<%=viagensFinalizadas[0][i]%>">Detalhado</a>
                                        </div>
                                    </div>
                                </div>
                                <%
                            }
                        }
                        
                    %>
                    
                    
                </li>
            </ul>
            </div>
              
        </div>
      </div>
        <!--FIM DO CORPO DA PAGINA-->
        
        <!--Materialize JS -->
        <script src="js/materialize.js"></script>
        <script>
            $(document).ready(function(){
                $('.collapsible').collapsible();
            });
        </script>
    </body>
</html>
