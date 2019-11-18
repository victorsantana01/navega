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
        <!-- javascript datatables --><script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>

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
        <script>
            $(document).ready(function(){
                $('.dropdown-trigger').dropdown();
                $('select').formSelect();
                $('.collapsible').collapsible();
                $(".dropdown-trigger").dropdown('toggle');
            });
        </script>
        <%
        /* Inicio de Sessão */
        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> "+conta);
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        Statement stmt2 = con.createStatement();
        String macroEnviada = request.getParameter("macro");
        String macroN="";
        String macroE="";
        
        if(macroEnviada != null){
            macroN = macroEnviada.split("_")[0];
            macroE = macroEnviada.split("_")[1];
        }
        %>
        
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
                <div class="card " style="margin-top:25px">
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
                                                    if(macroEnviada == null){
                                            %>
                                                        <option class="black-text" value="<%=macroLista[0][i]+"_"+macroLista[1][i]%>"><%=macroLista[2][i].toUpperCase()+" MACRO "+macroLista[0][i]+" VERSAO "+macroLista[1][i]%></option>
                                            <%
                                                    }else{
                                                        if(macroN.equals(macroLista[0][i]) && macroE.equals(macroLista[1][i])){
                                            %>
                                                            <option class="black-text" value="<%=macroLista[0][i]+"_"+macroLista[1][i]%>" selected><%=macroLista[2][i].toUpperCase()+" MACRO "+macroLista[0][i]+" VERSAO "+macroLista[1][i]%></option>
                                            <%
                                                        }else{
                                            %>
                                                        <option class="black-text" value="<%=macroLista[0][i]+"_"+macroLista[1][i]%>"><%=macroLista[2][i].toUpperCase()+" MACRO "+macroLista[0][i]+" VERSAO "+macroLista[1][i]%></option>
                                            <%
                                                        }
                                                    }
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
        </div>
        <div style="overflow-y: auto; width: 90%; display: block; margin: auto">
            <%

                if(macroEnviada == null){
                }else{
            %>
            <table id="example" class="display nowrap striped" style="width:100%">
                <thead class="background #0277bd light-blue darken-1">
                    <tr>
                        <%
                            MacroDao m = new MacroDao();
                            String[][] lista = m.getMacroDef(conta, con, stmt, macroN, macroE);
                            int leng = 0;
                            for (int i = 0; i < 50; i++) {
                                    if(lista[i][0] == null){
                                        i=50;
                                    }else{
                                        leng++;
                                        %>
                                        <th><%=lista[i][0]%></th>
                        <%
                                    }
                                }
                        %>

                    </tr>
                </thead>
                <tbody>
                    <tr>
                    <%
                        String [][] macros;
                        macros = m.getMacroText(conta, con, stmt, stmt2,macroN,macroE);

                        for(int i=0; i< 5000; i++){
                            if(macros[0][i] == null){
                                i=5000;
                            }else{
                                for (int j = 0; j < 5000; j++) {
                                    if(macros[j][i] == null && j == leng){
                                        j=5000;
                                    }else{
                                        String mm;
                                        if(macros[j][i] == null){
                                            mm = "";
                                        }else{
                                            mm = macros[j][i];
                                        if(lista[j][1] != null){
                                            if(lista[j][1].equals("2") ){
                                                mm = mm.substring(0,2)+"/"+mm.substring(2,4);
                                            }
                                            if(lista[j][1].equals("3")){
                                                mm = mm.substring(0,2)+":"+mm.substring(2,4);
                                            }
                                        }
                                        }

                                        %> <td><%=mm %></td><%
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
            }, 'print', 'pageLength'
                    ]
                } );
            } );
        </script>
    </body>
</html>
