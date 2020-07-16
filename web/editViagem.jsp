<%@page import="dao.ComandanteDao"%>
<%@page import="dao.BarcoDao"%>
<%@page import="dao.ViagemDao"%>
<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="logic.Format"%>
<%@page import="dao.Rpm"%>

<!DOCTYPE html>
<html>
    <head>
        <title>NAVEGA GESTOR</title>
        <!--Cabe�alho Para Materialize-->
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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <!--Materialize CSS -->
        <link rel="stylesheet" type="text/css" href="css/materialize.css">
        
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </head>

    <body>
        <style>
            .daterangepicker .drp-calendar .calendar-time select{
                display:inline !important;
            }
            .modal-dialog{
                margin: 0px !important;
            }
        </style>
        <%
            /* Inicio de Sess�o */
            String conta = session.getAttribute("conta").toString();
            System.out.println("Numero da conta � >>>>> " + conta);
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
        %>
        <script>
            $(document).ready(function(){
                $('.dropdown-trigger').dropdown();
                $('select').formSelect();
                $('.collapsible').collapsible();
                $(".dropdown-trigger").dropdown('toggle');
            });
        </script>
        <script>
            $(function () {
                $('input[name="datetimes22"]').daterangepicker({
                    timePicker: true,
                    startDate: moment().startOf('hour'),
                    endDate: moment().startOf('hour').add(24, 'hour'),
                    "timePicker24Hour": true,
                    locale: {
                        format: 'DD/MM/YYYY hh:mm'
                    }
                });
            });

        </script>

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
                    <li><a href="listarMacros.jsp">Defini��o da Macro</a></li>
                    <li><a href="viagens.jsp">Viagens</a></li>
                    <!-- Dropdown Trigger -->
                    <li><a class="dropdown-trigger" href="#!" data-target="dropdown1">Cadastro<i class="material-icons right">arrow_drop_down</i></a></li>
                    <li><a href="tables.jsp">Tabela de Consumo</a></li>
                    <li><a href="motores.jsp">Motores</a></li>
                    <li><a href="login.jsp">Sair</a></li>
                </ul>
            </div>
        </nav>

        <!-- INICIO Bot�o de Add -->
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

            <div class="card">
                <div class="card-content black-text ">
                    <span class="card-title center"><b>Cadastro de Viagem</b></span>
                    <div class="row">
                        <div class="container col s12">
                            <div class="row ">

                                <form id="mod" name="tab" action="editarViagem.jsp" method="get">
                                    <!--FAZ UMA PESQUISA APARTI DE UM ID, E SALVA O RESULTADO EM UM ARRAY-->
                                    <%
                                        String idViagem = request.getParameter("idViagem");
                                        System.out.println("idViagem: "+idViagem);
                                        ViagemDao viagem = new ViagemDao();
                                        String[][] viagemE = viagem.pesquisarViagens(conta, con, stmt,idViagem);
                                        System.out.println(viagemE[0][0]);
                                        System.out.println(viagemE[1][0]);
                                        System.out.println(viagemE[2][0]);
                                        System.out.println(viagemE[3][0]);
                                        System.out.println("BEFORE");
                                        System.out.println(viagemE[4][0]);
                                        System.out.println(viagemE[6][0]);
                                        System.out.println("AFTER");
                                        String datIn = viagemE[4][0].substring(0, 16).replace('-','/');
                                        String datOut = viagemE[6][0].substring(0, 16).replace('-','/');
                                        String[] datInArray = datIn.split(" ");
                                        String[] datOutArray = datOut.split(" ");
                                        datIn = datInArray[0].split("/")[2]+"/"+datInArray[0].split("/")[1]+"/"+datInArray[0].split("/")[0]+" "+datInArray[1];
                                        datOut = datOutArray[0].split("/")[2]+"/"+datOutArray[0].split("/")[1]+"/"+datOutArray[0].split("/")[0]+" "+datOutArray[1];
                                        System.out.println(datIn);
                                        System.out.println(datOut);
                                        String datt = datIn+" - "+datOut;
                                        System.out.println(datt);
                                        
                                    %>
                                    <div class="form-group col s12">
                                        <div class="form-row col s6 ">
                                            <div class="input-field col s12">
                                                <input name="id" class="validate black-text" type=hidden id="id" value="<%=viagemE[0][0]%>" type="text" required>
                                                <input name="nomeViagem" class="validate black-text" id="nomeViagem" value="<%=viagemE[1][0]%>" type="text" required>
                                                <label for="nomeViagem" class="active">Nome da Viagem</label>
                                            </div>
                                        </div>
                                                <% System.out.println("-----------------------"+viagemE[0][0]+"------------------");%>
                                                <% System.out.println("-----------------------"+viagemE[1][0]+"------------------");%>
                                                <% System.out.println("-----------------------"+viagemE[2][0]+"------------------");%>
                                                <% System.out.println("-----------------------"+viagemE[3][0]+"------------------");%>
                                        <div class="col s6">
                                            <select class="browser-default" name="status" value="<%= viagemE[2][0]%>" required >
                                                <option value="" disabled>Status de Viagem</option>
                                                <% if (viagemE[2][0] =="0") { %>
                                                <option value="0" selected>Agendado</option>
                                                <% } else { %>
                                                <option value="0">Agendado</option>
                                                <% }
                                                    if (viagemE[2][0] == "1") {
                                                %>
                                                <option value="1" selected>Em Progresso</option>
                                                <% } else { %>
                                                <option value="1">Em Progresso</option>
                                                <%}
                                                    if (viagemE[2][0] == "2") {
                                                %>
                                                <option value="2" selected>Finalizado</option>
                                                <%} else { %>
                                                <option value="2">Finalizado</option>
                                                <% }%>
                                            </select>
                                        </div>
                                        <div class="form-group col s12">
                                            <div class="input-field col s6">
                                                <div class="input-field col s12">
                                                    <input name="origem" class="validate black-text" id="origem" type="text" value="<%=viagemE[3][0]%>" required>
                                                    <label for="origem" class="active">Origem</label>
                                                </div>
                                                <div class="input-field col s12">
                                                    <input name="destino" class="validate black-text" id="destino" type="text" value="<%=viagemE[5][0]%>" required>
                                                    <label for="destino" class="active">Destino</label>
                                                </div>
                                            </div>
                                            <div class="input-field col s6">
                                                <input type="text" name="datetimes22" id="datetimes22" value="<%= datt%>" />
                                                <label for="datetimes22">Datas e Horarios</label>
                                            </div> 
                                        </div>
                                        <div class="form-group col s12">
                                            <span class="card-title center"><b>Embarca��o</b></span>

                                            <div class="col s6">
                                                <select class="browser-default black-text" name="barco" value="<%=viagemE[7][0]%>" required > 
                                                    <option class="black-text" value="" disabled>Barco</option>
                                                    <!--PESQUISA OS BARCOS E PREENCHE O MENU SELECT E SELECIONA A OPCAO  GRAVADA.-->
                                                    <%
                                                        BarcoDao bar = new BarcoDao();
                                                        String[][] barcos = bar.pesquisaBarcos(conta, con, stmt).clone();
                                                        for (int i = 0; i < 50; i++) {
                                                            if (barcos[0][i] == null) {
                                                                i = 100;
                                                            } else {
                                                                if (barcos[1][i].equals(viagemE[7][0])) {%>
                                                    <option class="black-text" value="<%=barcos[1][i]%>" selected><%=barcos[2][i]%></option>
                                                    <%
                                                    } else {%>
                                                    <option class="black-text" value="<%=barcos[1][i]%>"><%=barcos[2][i]%></option>

                                                    <%
                                                                }
                                                            }
                                                        }%>
                                                </select>
                                            </div>
                                            <div class="col s6"> 
                                                <select class="browser-default black-text" name="comandante" id="comandante" value="<%=viagemE[8][0]%>" required>
                                                    <option class="black-text" value="" disabled>Comandante</option>
                                                    <%
                                                        ComandanteDao com = new ComandanteDao();
                                                        String[][] comandantes = com.pesquisarComandantes(conta, con, stmt).clone();
                                                        for (int i = 0; i < 200; i++) {
                                                            if (comandantes[0][i] == null) {
                                                                i = 500;
                                                            } else {
                                                                if (comandantes[1][i].equals(viagemE[8][0])) {
                                                    %>
                                                    <option class="black-text" value="<%=comandantes[0][i]%>" selected><%=comandantes[1][i]%></option>
                                                    <%
                                                    } else {
                                                    %>
                                                    <option class="black-text" value="<%=comandantes[0][i]%>"><%=comandantes[1][i]%></option>

                                                    <%
                                                                }
                                                            }
                                                        }%>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-action col s12">
                                        <input type="submit" class="btn col s4 center-align push-s4 z-depth-5 blue " >Editar />
                                    </div>

                                </form>
                            </div>
                        </div>

                    </div>

                </div>
            </div>

        </div><!--FIM DO CORPO DA PAGINA-->
        <script>
            $(function () {
                $('input[name="datetimes22"]').daterangepicker({
                    timePicker: true,
                    timePicker24Hour: true,
                    startDate: "<%=datIn%>",
                    endDate: "<%=datOut%>",
                    locale: {
                        format: 'DD/MM/YYYY HH:mm'
                    }
                });
            });

        </script>
        <script type="text/javascript">
            function confirma(form) {
                form.submit();
                return false;
            }
        </script>
        <!--Materialize JS -->
        <script src="js/materialize.js"></script>
    </body>
</html>
