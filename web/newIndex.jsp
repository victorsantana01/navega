<%@page import="dao.ViagemDao"%>
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
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        
        <!-- css datatables -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/jq-3.3.1/dt-1.10.18/datatables.min.css"/>
 
        <script type="text/javascript" src="https://cdn.datatables.net/v/dt/jq-3.3.1/dt-1.10.18/datatables.min.js"></script>
        <!-- javascript datatables -->
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>        
        <script src="js/jquery.js"></script>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
            
    </head>
    
    <body>
        <%
            String conta = session.getAttribute("conta").toString();
            System.out.println("Numero da conta é >>>>> " + conta);
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
            Statement stmt1 = con.createStatement();
            Statement stmt2 = con.createStatement();

        %>
        <script>
            $(document).ready(function(){
                $('.dropdown-trigger').dropdown();
            });
        </script>
<!--        <ul id="dropdown1" class="dropdown-content">
            <li><a href="cadBarco.jsp">Barco</a></li>
            <li class="divider"></li>
            <li><a href="cadComandante.jsp">Comandante</a></li>
            <li class="divider"></li>
            <li><a href="cadViagem.jsp">Viagens</a></li>
        </ul>-->
        
<!--        <nav>
            <div class="nav-wrapper" style="background-color: #0277bd !important;">
                <a href="index.jsp" class="brand-logo">Logo</a>
                <ul id="nav-mobile" class="right hide-on-med-and-down">
                    <li><a href="macros.jsp"><b><i class="material-icons">description</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Macros</h6></b></a></li>
                    <li><a href="listarMacros.jsp"><b><i class="material-icons">description</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Definição da Macro</h6></b></a></li>
                    <li><a href="viagens.jsp"><b><i class="material-icons">directions_boat</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Viagens</h6></b></a></li>
                     Dropdown Trigger 
                    <li><a class="dropdown-trigger" data-target="dropdown1">Cadastrar<i class="material-icons right">arrow_drop_down</i></a></li>
                    <li><a href="tables.jsp"><b><i class="material-icons">receipt</i>&nbsp;&nbsp;&nbsp;</b><b class="center-align  waves-effect"><h6>Tabela de Consumo</h6></b></a></li>
                    <li><a href="motores.jsp"><b><i class="material-icons">build</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Motores</h6></b></a></li>
                    <li><a href="login.jsp"><b><i class="material-icons">assignment_ind</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Sair</h6></b></a></li>
                </ul>
            </div>
        </nav>-->
       

            <div class="card">
                <table id="example" class="display" style="width:100%">
                    <thead>
                        <tr>
                            <th><i class="material-icons">directions_boat</i>&nbsp;&nbsp;Empurrador</th>
                            <th><i class="material-icons">network_cell</i>&nbsp;&nbsp;MCT/UCC</th>
                            <th><i class="material-icons">update</i>&nbsp;&nbsp;Ultima Posição</th>
                            <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;Status Viagem</th>
                            <th><i class="material-icons">description</i>&nbsp;&nbsp;Relatorios</th>
                            <th><i class="material-icons">location_on</i>&nbsp;&nbsp;LandMark</th>
                            <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;Velocidade</th>
                            <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;RPM-1</th>
                            <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;RPM-2</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Format format = new Format();
                            String position = "";
                            Rpm re = new Rpm();
                            String[][] painel = re.painelAtualizado(conta, con, stmt,stmt1,stmt2).clone();
                            for (int i = 0; i < 100; i++) {

                                        if (painel[1][i] == null) {
                                            i = 100;

                                        } else {
                                            ViagemDao viagem = new ViagemDao();
                                            String status = viagem.pesquisarViagemStatusPorMCT(conta, con, stmt, painel[1][i]);
                                            String idViagem = viagem.pesquisarViagemPorMCT(conta, con, stmt, painel[1][i]);
                                            String statusColor = "#808080";
                                            String statusIcone = "";
                                            if(status.equals("0")){
                                                status = "AGENDADO";
                                                statusColor = "yellow";
                                                statusIcone = "schedule";
                                            }else if(status.equals("1")){
                                                status = "EM PROGRESSO";
                                                statusColor = "blue";
                                                statusIcone = "directions_boat";
                                            }else if(status.equals("2")){
                                                status = "FINALIZADO";
                                                statusColor = "#00FF00";
                                                statusIcone = "check";
                                            }else{
                                                statusColor = "#808080";
                                                statusIcone = "clear";
                                            }
                        %>
                        <tr>
                            <% position = format.DataFormat(painel[2][i]); %>
                            <th><i class="material-icons">directions_boat</i>&nbsp;&nbsp; <%=painel[0][i]%></th>
                            <th><i class="material-icons">network_cell</i>&nbsp;&nbsp;<%=painel[1][i]%></th>
                            <th><i class="material-icons">update</i>&nbsp;&nbsp;<%=position%></th>
                            <th style="color:<%=statusColor%>;"><i class="material-icons"><%=statusIcone%></i>&nbsp;&nbsp;<%=status%></th>
                            <th>
                                <ul id="dropdown2" href="#" class="dropdown-content">
                                    <li><a href="relatorioConsolidado.jsp?idViagem=<%=idViagem%>">Consolidado</a></li>
                                    <li><a href="relatorioDetalhado.jsp?idViagem=<%=idViagem%>">Detalhado</a></li>
                                </ul>
                                <a class="btn dropdown-trigger" data-target="dropdown2">Relatorios<i class="material-icons right">arrow_drop_down</i></a>
                            </th>
                            <th><i class="material-icons">location_on</i>&nbsp;&nbsp;<%=painel[4][i]%></th>
                            <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;<%=painel[3][i]%></th>
                            <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;<%=painel[5][i]%></th>
                            <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;<%=painel[6][i]%></th>
                        </tr>
                        <%
                            }
                        }
                        %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th><i class="material-icons">directions_boat</i>&nbsp;&nbsp;Empurrador</th>
                            <th><i class="material-icons">network_cell</i>&nbsp;&nbsp;MCT/UCC</th>
                            <th><i class="material-icons">update</i>&nbsp;&nbsp;Ultima Posição</th>
                            <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;Status Viagem</th>
                            <th><i class="material-icons">description</i>&nbsp;&nbsp;Relatorios</th>
                            <th><i class="material-icons">location_on</i>&nbsp;&nbsp;LandMark</th>
                            <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;Velocidade</th>
                            <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;RPM-1</th>
                            <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;RPM-2</th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        
        <!--Materialize JS -->
        <script src="js/materialize.js"></script>
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
            }, 'print', 'pageLength'
                    ]
                } );
            } );
        </script>
        <script>
            $(document).ready(function(){
                $('.collapsible').collapsible();
            });
        </script>
        <script>
            $(document).ready(function(){
                $('select').formSelect();
            });
        </script>        
    </body>
</html>
