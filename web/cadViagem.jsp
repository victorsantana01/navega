<%@page import="logic.Format"%>
<%@page import="dao.ComandanteDao"%>
<%@page import="dao.BarcoDao"%>
<%@page import="dao.ViagemDao"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@page import="java.sql.Statement"%>
<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>


<!DOCTYPE html>
<html>
    <head>
        <title>NAVEGA GESTOR</title>
        <!--Cabe?alho Para Materialize-->
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <!--FIM Cabe?alho Para Materialize-->
        <script src="js/jquery.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

    </head>
    <%

        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta � >>>>> " + conta);
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
    %>


    <body> 
        <style>
            .daterangepicker .drp-calendar .calendar-time select{
                display:inline !important;
            }
            .modal-dialog{
                margin: 0px !important;
            }
            a:hover {text-decoration: none;}
        </style>
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
                        format: 'DD/MM/YYYY HH:mm'
                    }
                });
            });
        </script>
        <!--Materialize INICIALIZA o menu para Mobile -->
        <!-- INICIO Bot?o de Add -->
        <div class="fixed-action-btn  click-to-toggle " style="bottom: 35px; right: 45px;">
            <a class="btn-floating z-depth-5 #4db6ac teal lighten-0 btn-large waves-effect z-depth-4"><i class="material-icons">add</i></a>
            <ul>
                <li>
                    <a href="lista.html" class="btn-floating z-depth-5 #4db6ac teal lighten-3 btn-large waves-effect z-depth-4">
                        <i class="material-icons">directions_run</i>clolse</a>
                </li>
            </ul>
        </div>
        <!-- FIM Bot?o de Add -->
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


        <!-- INICIO Bot?o de Add -->
        <div class="fixed-action-btn  click-to-toggle " style="bottom: 35px; right: 45px;">
            <a class="btn-floating z-depth-5 #4db6ac teal lighten-0 btn-large waves-effect z-depth-4"><i class="material-icons">add</i></a>
            <ul>
                <li>
                    <a href="lista.html" class="btn-floating z-depth-5 #4db6ac teal lighten-3 btn-large waves-effect z-depth-4">
                        <i class="material-icons">directions_run</i>clolse</a>
                </li>
            </ul>
        </div>
        <!--INICIO do Corpo do App -->

        <div class=" container"><br>
            <div class="row ">
                <div class="col s12">
                    <div class="card">
                        <div class="card-content black-text ">
                            <span class="card-title center"><b>Cadastro de Viagem</b></span>
                            <div class="row">
                                <div class="container col s12">
                                    <div class="row ">

                                        <form id="mod" name="tab" action="cadastrarViagem.jsp" method="get">

                                            <div class="form-group col s12">
                                                <div class="form-row col s6 ">
                                                    <div class="input-field col s12">
                                                        <input name="nomeViagem" class="validate black-text" id="nomeViagem" type="text" required>
                                                        <label for="nomeViagem">Nome da Viagem</label>
                                                    </div>
                                                </div>
                                                <div class="col s6">
                                                    <select class="browser-default" name="status" required >
                                                        <option value="" disabled selected>Status de Viagem</option>
                                                        <option value="0">Agendado</option>
                                                        <option value="1">Em Progresso</option>
                                                        <option value="2">Finalizado</option>
                                                    </select>
                                                </div>
                                                <div class="form-group col s12">
                                                    <div class="input-field col s6">
                                                        <div class="input-field col s12">
                                                            <input name="origem" class="validate black-text" id="origem" type="text" required>
                                                            <label for="origem">Origem</label>
                                                        </div>
                                                        <div class="input-field col s12">
                                                            <input name="destino" class="validate black-text" id="destino" type="text" required>
                                                            <label for="destino">Destino</label>
                                                        </div>
                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input type="text" name="datetimes22" id="datetimes22" />
                                                        <label for="datetimes22" class="active">Datas e Horarios</label>
                                                    </div> 
                                                </div>
                                                <div class="form-group col s12">
                                                    <span class="card-title center"><b>Embarca��o</b></span>

                                                    <div class="col s6">
                                                        <select class="browser-default black-text" name="barco" required > 
                                                            <option class="black-text" value="" disabled selected>Barco</option>
                                                            <%
                                                                BarcoDao bar = new BarcoDao();
                                                                String[][] barcos = bar.pesquisaBarcos(conta, con, stmt).clone();
                                                                for (int i = 0; i < 10; i++) {
                                                                    if (barcos[0][i] == null) {
                                                                        i = 50;
                                                                    } else {
                                                            %>
                                                            <option class="black-text" value="<%=barcos[1][i]%>"><%=barcos[2][i]%></option>

                                                            <%
                                                                    }
                                                                }%>
                                                        </select>
                                                    </div>
                                                    <div class="col s6"> 
                                                        <select class="browser-default black-text" name="comandante" id="comandante" required>
                                                            <option class="black-text" value="" disabled selected>Comandante</option>
                                                            <%
                                                                ComandanteDao com = new ComandanteDao();
                                                                String[][] comandantes = com.pesquisarComandantes(conta, con, stmt).clone();
                                                                for (int i = 0; i < 200; i++) {
                                                                    if (comandantes[0][i] == null) {
                                                                        i = 500;
                                                                    } else {
                                                            %>
                                                            <option class="black-text" value="<%=comandantes[0][i]%>"><%=comandantes[1][i]%></option>

                                                            <%
                                                                    }
                                                                }%>
                                                        </select>
                                                    </div>


                                                </div>

                                            </div>
                                            <div class="card-action col s12">
                                                <input type="submit" class="btn col s4 center-align push-s4 z-depth-5 blue ">Salvar />
                                            </div>

                                        </form>
                                    </div>



                                </div>

                            </div>

                        </div>
                    </div>

                    <table class="highlight striped responsive-table z-depth-4" id="dataTable">
                        <thead class=" background #0277bd light-blue darken-1">
                        <b><tr>
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;nome Viagem</th>
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;status</th>
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;origem</th>
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;inicio Viagem</th>
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;destino</th>
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;fim Viagem</th>
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp; MCT / UCC</th>
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;comandante</th>
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;Data de Cadastro</th>
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;</th>
                            </tr></b>
                        </thead>

                        <%
                            Format format = new Format();
                            String inicio = "";
                            String fim = "";
                            String cadastro = "";
                            ViagemDao viagem = new ViagemDao();
                            String[][] viagens = viagem.pesquisarViagens(conta, con, stmt).clone();
                            for (int i = 0; i < 1000; i++) {
                                if (viagens[0][i] == null) {
                                    i = 2000;
                                } else {
                        %>
                        <tr id="<%= viagens[0][i]%>">
                            <%
                                inicio = format.DataFormat(viagens[4][i]);
                                fim = format.DataFormat(viagens[6][i]);
                                cadastro = format.DataFormat(viagens[9][i]);
                                System.out.println(viagens[1][i]);
                            %>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[1][i]%></th> <!-- nome Viagem -->
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[2][i]%></th> <!-- status -->
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[3][i]%></th> <!-- origem -->
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= inicio%></th>        <!-- inicio viagem -->
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[5][i]%></th> <!-- destino -->
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= fim%></th>           <!-- fim viagem -->
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[7][i]%></th> <!--  MCT / UCC-->
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[8][i]%></th> <!-- comandante -->
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= cadastro%></th>      <!-- data decadastro -->
                            <th>
                                <i class="material-icons"></i>&nbsp;&nbsp;<a class="btn" href="editViagem.jsp?idViagem=<%= viagens[0][i]%>"><i class="material-icons">create</i>Editar</a>      <!-- data decadastro -->
                                <i class="material-icons"></i>&nbsp;&nbsp;<a class="btn" href="excluirViagem.jsp?idViagem=<%= viagens[0][i]%>"><i class="material-icons">delete</i>Deletar</a>
                            </th>      <!-- data decadastro -->
                        </tr>
                        <%  }
                            }
                        %>


                    </table>

                </div>
            </div>
        </div>
    </div>
    

    <script type="text/javascript">
        function confirma(form) {
            form.submit();
            return false;
        }
        function pegaNome() {
            var nome = $('#origem').val();
            alert(nome);
        }
    </script>
    <!--FIM do Corpo do App -->

    <!--Materialize JS -->



</body>
</html>