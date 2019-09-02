<%@page import="dao.ComandanteDao"%>
<%@page import="dao.BarcoDao"%>
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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <!--Materialize CSS -->
        <link rel="stylesheet" type="text/css" href="css/materialize.css">
        <!--FIM Cabeçalho Para Materialize-->
        <script src="js/jquery.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

    </head>

    <body>
        <%
            /* Inicio de Sessão */
            String conta = session.getAttribute("conta").toString();
            System.out.println("Numero da conta é >>>>> " + conta);
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
            con.close();
        %>

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
                                        ViagemDao viagem = new ViagemDao();
                                        String[][] viagemE = viagem.pesquisarViagens(idViagem);
                                    %>
                                    <div class="form-group col s12">
                                        <div class="form-row col s6 ">
                                            <div class="input-field col s12">
                                                <input name="id" class="validate black-text" type=hidden id="id" value="<%=viagemE[0][0]%>" type="text" required>
                                                <input name="nomeViagem" class="validate black-text" id="nomeViagem" value="<%=viagemE[1][0]%>" type="text" required>
                                                <label for="nomeViagem" class="active">Nome da Viagem</label>
                                            </div>
                                        </div>
                                        <div class="col s6">
                                            <select class="browser-default" name="status" value="<%= viagemE[2][0]%>" required >
                                                <option value="" disabled>Status de Viagem</option>
                                                <% if (viagemE[2][0].equals("0")) { %>
                                                <option value="0" selected>Agendado</option>
                                                <% } else { %>
                                                <option value="0">Agendado</option>
                                                <% }
                                                    if (viagemE[2][0].equals("1")) {
                                                %>
                                                <option value="1" selected>Em Progresso</option>
                                                <% } else {%>
                                                <option value="1">Em Progresso</option>
                                                <%}
                                                    if (viagemE[2][0].equals("2")) {
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
                                                <input type="text" name="datetimes22" id="datetimes22" value="<%= viagemE[4][0] + " " + viagemE[6][0]%>" />
                                                <label for="datetimes22">Datas e Horarios</label>
                                            </div> 
                                        </div>
                                        <div class="form-group col s12">
                                            <span class="card-title center"><b>Embarcação</b></span>

                                            <div class="col s6">
                                                <select class="browser-default black-text" name="barco" value="<%=viagemE[7][0]%>" required > 
                                                    <option class="black-text" value="" disabled>Barco</option>
                                                    <!--PESQUISA OS BARCOS E PREENCHE O MENU SELECT E SELECIONA A OPCAO  GRAVADA.-->
                                                    <%
                                                        BarcoDao bar = new BarcoDao();
                                                        String[][] barcos = bar.pesquisaBarcos().clone();
                                                        for (int i = 0; i < 10; i++) {
                                                            if (barcos[0][i] == null) {
                                                                i = 50;
                                                            } else {
                                                                if (barcos[0][i].equals(viagemE[7][0])) { %>
                                                    <option class="black-text" value="<%=barcos[0][i]%>" selected><%=barcos[1][i]%></option>
                                                    <%
                                                    } else { %>
                                                    <option class="black-text" value="<%=barcos[0][i]%>"><%=barcos[1][i]%></option>

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
                                                        String[][] comandantes = com.pesquisarComandantes().clone();
                                                        for (int i = 0; i < 200; i++) {
                                                            if (comandantes[0][i] == null) {
                                                                i = 500;
                                                            } else {
                                                                if (comandantes[0][i].equals(viagemE[8][0])) {
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
