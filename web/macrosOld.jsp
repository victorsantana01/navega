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
        <!--Materialize Icones -->  
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Materialize CSS -->
        <link rel="stylesheet" type="text/css" href="css/materialize.css">
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <!--FIM Cabeçalho Para Materialize-->
        <script src="js/jquery.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        
        <!-- css datatables -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/jq-3.3.1/dt-1.10.18/datatables.min.css"/>
 
        <script type="text/javascript" src="https://cdn.datatables.net/v/dt/jq-3.3.1/dt-1.10.18/datatables.min.js"></script>
        <!-- javascript datatables -->
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/dataTables.buttons.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.flash.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.html5.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.print.min.js"></script>
        <!-- Materializecss -->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    </head>
    
    <body>
<!--        <script>
            $.post('/MacroDao.java', {RAND:RAND, redePl:redePl, excluidoPl:excluidoPl}, function(json){
                
            });
        </script>-->
        <%
        /* Inicio de Sessão */
        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> "+conta);
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        Statement stmt2 = con.createStatement();
        %>
        
        <div class="row">
            <div class="col s3">
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
                    <li class="left-align"><a href="listarMacros.jsp"><b><i class="material-icons">directions_boat</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Definição da Macro</h6></b></a></li>
                    <li class="left-align"><a href="macros.jsp"><b><i class="material-icons">directions_boat</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Listar Macros</h6></b></a></li>
                    <li class="left-align"><a href="tables.jsp"><b><i class="material-icons">receipt</i>&nbsp;&nbsp;&nbsp;</b><b class="center-align  waves-effect"><h6>Tabela de Consumo</h6></b></a></li>
                    <li class="left-align"><a href="motores.jsp"><b><i class="material-icons">build</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Motores</h6></b></a></li>
                    <li class="left-align"><a href="login.jsp"><b><i class="material-icons">assignment_ind</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Sair</h6></b></a></li>
                </ul>
            </div>
            <div class="col s9 fixed"><!-- INICIO Botão de Add -->
                <div class="fixed-action-btn  click-to-toggle " style="bottom: 35px; right: 45px;">
                    <a class="btn-floating z-depth-5 #4db6ac teal lighten-0 btn-large waves-effect z-depth-4"><i class="material-icons">add</i></a>
                    <ul>
                        <li>
                            <a href="lista.html" class="btn-floating z-depth-5 #4db6ac teal lighten-3 btn-large waves-effect z-depth-4">
                                <i class="material-icons">directions_run</i>clolse</a>
                        </li>
                    </ul>
                </div>
                <div class="container">
                    <div class="card " style="margin-top:25px"><!--INCIO DO CORPO DA PAGINA-->
                        <form id="viagens2" name="macros" action="macrolistar.jsp" method="get">
                            <div class="row">
                                <span class="card-title center col s12"><b>Selecione a Macro<br></b></span><br><br>
                                <div class="col s12">
                                    <div class="container">
                                        <div class="container">
                                            <select class="browser-default black-text" name="macro" id="macro" required > 
                                                <option class="black-text" value="" disabled selected>Macro</option>
                                                <%
                                                    MacroDao macro = new MacroDao();
                                                    String[][] macroLista = macro.listarMacroCadastradas(conta, con, stmt).clone();
                                                    for (int i = 0; i < 50; i++) {
                                                        if (macroLista[0][i] == null) {
                                                            i = 50;
                                                        } else {
                                                %>
                                                <option class="black-text" value="<%=macroLista[0][i]+" --"+macroLista[1][i]%>"><%=macroLista[2][i].toUpperCase()+" MACRO "+macroLista[0][i]+" VERSAO "+macroLista[1][i]%></option>

                                                <%
                                                        }
                                                    }%>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col s12">
                                    <br>
                                    <!--<a type="btn" class="waves-effect waves-light btn col s4 center-align push-s4 z-depth-5">Pesquisar </a>-->
                                    <input type="submit" class="btn col s4 center-align push-s4 blue " style="margin-bottom:10px" >Pesquisar/>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>                
                <div>
                    <%
                        String macroEnviada = request.getParameter("macro");
                        if(macroEnviada == null){
                        }else{
                    %>
                    <table id="example" class="display nowrap striped" style="width:100%">
                        <thead class="background #0277bd light-blue darken-1">
                            <tr>
                                <%
                                    MacroDao m = new MacroDao();
                                    String[][] lista = m.getMacroDef(conta, con, stmt, macroEnviada);
                                    for (int i = 0; i < 50; i++) {
                                            if(lista[i][0] == null){
                                                i=50;
                                            }else{
                                                %>
                                                <th><%=lista[i][0]%></th>
                                <%
                                            }
                                        }
                                %>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String [][] macros;
                                macros = m.getMacroText(conta, con, stmt,macroEnviada);

                                for(int i=0; i< 5000; i++){
                                    if(macros[0][i] == null){
                                        i=5000;
                                    }else{
                                        for (int j = 0; j < 5000; j++) {
                                            if(macros[j][i] == null){
                                                j=5000;
                                            }else{
                                                %> <td><%=macros[j][i] %></td><%
                                            }
                                        }
                                    }
                                    %></tr><%
                                }
                            %>

                        </tbody>
                        <tfoot>
                            <tr>
                                <%        for (int i = 0; i < 50; i++) {
                                            if(lista[i][0] == null){
                                                i=50;
                                            }else{
                                                %>
                                                <th><%=lista[i][0]%></th>
                                <%
                                            }
                                        }
                                %>
                            </tr>
                        </tfoot>
                    </table>
                    <% }%>
                </div>
            </div><!--FIM DO CORPO DA PAGINA-->
        </div>
        

      
        
        <!--Materialize JS -->
        <script src="js/materialize.js"></script>
        <script type="text/javascript">
            function confirma(form) {
                form.submit();
                return false;
                $(".dropdown-trigger").dropdown();
            }
        </script>
        <script>
            $(document).ready(function(){
                $('.collapsible').collapsible();
            });
        </script>
        <script>
            $(document).ready(function() {
                $('#example').DataTable( {
                    dom: 'Bfrtip',
                    pageLength: 20,
                    buttons: [
                        'copy', 'csv', 'excel', {
                extend: 'pdfHtml5',
                orientation: 'landscape',
                pageSize: 'LEGAL'
            }, 'print'
                    ]
                } );
            } );
        </script>
    </body>
</html>
