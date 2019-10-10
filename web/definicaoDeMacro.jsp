<%@page import="dao.MacroDao"%>
<%@page import="dao.BarcoDao"%>
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
                    <div class="background">
                        <img src="img/mar.jpg" alt=""/>
                    </div>
                    <div class="center">
                        <b><h4 class="white-text">Navega Gestor</h4></b> 
                    </div>
                    <div class="center">
                        <b class="white-text">Gestão à bordo</b>
                    </div>
                </div>
            </li>   
            <li class="left-align"><a href="index.jsp" ><b><i class="material-icons">home</i>&nbsp;&nbsp;&nbsp;</b><b class="center-align  waves-effect"><h6>Inicio</h6></b></a></li>
            <li class="left-align"><a href="cadBarco.jsp"><b><i class="material-icons">directions_boat</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Cadastro Embarcação</h6></b></a></li>
            <li class="left-align"><a href="cadComandante.jsp"><b><i class="material-icons">person_add</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Cadastro Comandante</h6></b></a></li>
            <li class="left-align"><a href="cadViagem.jsp"><b><i class="material-icons">map</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Cadastro Viagem</h6></b></a></li>
            <li class="left-align"><a href="relatorio1.jsp"><b><i class="material-icons">equalizer</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Relatorio RPM</h6></b></a></li>
            <li class="left-align"><a href="relatorio2.jsp"><b><i class="material-icons">equalizer</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Relatorio Consolidado</h6></b></a></li>
            <li class="left-align"><a href="listarMacros.jsp"><b><i class="material-icons">receipt</i>&nbsp;&nbsp;&nbsp;</b><b class="center-align  waves-effect"><h6>Definição de Macro</h6></b></a></li>
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
        <div class="container"><!--INCIO DO CORPO DA PAGINA-->
            
            <div class="container">
                <%
                    String id = request.getParameter("id");
                    MacroDao macrodao = new MacroDao();
                    String[][] macroSelecionada = macrodao.getMacroById(conta, con, stmt, id);
                    String[][] macroEdit = macrodao.getMacroDef(conta, con, stmt, macroSelecionada[0][0]);
                    String macroNome = macrodao.getMacroName(conta, con, stmt, macroSelecionada[0][0]);
                    System.out.println("macro");
                    for (int i = 0; i < 10; i++) {
                        if(macroSelecionada[i][0] != null){
                            System.out.println(i+" "+macroSelecionada[i][0]);                            
                        }
                    }
                %>
                <div class="card row">
                    <div class="card-content black-text ">
                        <span class="card-title center"><b>DEFINICAÇÃO DE MACRO</b></span><br>
                        
                        <div class=" col s12">
                            <form id="macro" name="macro" action="cadastrarMacro.jsp" method="get">
                                <div class="col s12">
                                    <div class="input-field col s6 right-align" style="padding-left: 0px !important">
                                        <input type="text" id="numeroMacro" name="numeroMacro" value="<%=macroSelecionada[0][0]%>" readonly />
                                        <label for="numeroMacro" style="left:0px !important">Nº Macro</label>
                                    </div>
                                    <div class="input-field col s6 right-align" style="padding-left: 0px !important">
                                        <input type="text" id="versao" name="versao" value="<%=macroSelecionada[2][0]%>" readonly />
                                        <label for="versao" style="left:0px !important">Versao</label>
                                    </div>
                                </div>
                                <div class="col s12">
                                    <div class="input-field col s6 right-align" style="padding-left: 0px !important">
                                        <% if(macroEdit[0][0] != null){ %>
                                        <input type="text" id="nome" name="nome" value="<%= macroNome %>" required />
                                        <% }else{ %>
                                        <input type="text" id="nome" name="nome" required />
                                       <% }%>
                                        <label for="nome" style="left:0px !important">Nome da Macro</label>
                                    </div>
                                </div>
                                <span class="card-title center">Nomeie os campos</span><br>
                                <%
                                    int x=0;
                                    for (int i = 3; i < 100; i++) {
                                        if(macroSelecionada[i][0] == null){
                                            
                                        }else{
                                            if(macroEdit[x][0] != null){
                                                System.out.println(macroEdit[0][0]);
                                                %>
                                        <div class="input-field col s6">
                                            <input type="text" id="label<%=x%>" name="label<%=x%>" required value="<%=macroEdit[x][0]%>" />
                                            <label for="label<%=x%>"><%=macroSelecionada[i][0]%></label>
                                        </div>
                                <%
                                            }else{
                                        %>
                                        <div class="input-field col s6">
                                                <input type="text" id="label<%=x%>" name="label<%=x%>" required />
                                                <label for="label<%=x%>"><%=macroSelecionada[i][0]%></label>
                                        </div>

                                <%
                                    }
                                    }
                                        x++;
                                    }
                                %>
                                <br>
                                <div class="card-action col s12">
                                    <input type="submit" class="btn col s4 center-align push-s4 z-depth-5 blue ">Salvar />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
            
        </div><!--FIM DO CORPO DA PAGINA-->
        
        <!--Materialize JS -->
        <script src="js/materialize.js"></script>
        <script type="text/javascript">
            function confirma(form) {
                form.submit();
                return false;
            }
        </script>
        <script>
            $(document).ready(function(){
                $('.collapsible').collapsible();
            });
        </script>
        <script>
            
        </script>
    </body>
</html>
