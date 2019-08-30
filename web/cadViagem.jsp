<%@page import="logic.Format"%>
<%@page import="dao.ComandanteDao"%>
<%@page import="dao.BarcoDao"%>
<%@page import="dao.ViagemDao"%>
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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <!--FIM Cabeçalho Para Materialize-->
        <script src="js/jquery.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

    </head>
    <%

        if (session.getAttribute("user") != null) {
            System.out.println("Está logado o usuario: " + session.getAttribute("user"));

        } else {
            response.sendRedirect("login.jsp");
        }%>


    <body> 
        <style>
            .daterangepicker .drp-calendar .calendar-time select{
                display:inline !important;
            }
            .modal-dialog{
                margin: 0px !important;
            }
        </style>
        <script type="text/javascript">

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

            $(".dropdown-trigger").dropdown('toggle');
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
                                                        <label for="datetimes22">Datas e Horarios</label>
                                                    </div> 
                                                </div>
                                                <div class="form-group col s12">
                                                    <span class="card-title center"><b>Embarcação</b></span>

                                                    <div class="col s6">
                                                        <select class="browser-default black-text" name="barco" required > 
                                                            <option class="black-text" value="" disabled selected>Barco</option>
                                                            <%
                                                                BarcoDao bar = new BarcoDao();
                                                                String[][] barcos = bar.pesquisaBarcos().clone();
                                                                for (int i = 0; i < 10; i++) {
                                                                    if (barcos[0][i] == null) {
                                                                        i = 50;
                                                                    } else {
                                                            %>
                                                            <option class="black-text" value="<%=barcos[0][i]%>"><%=barcos[1][i]%></option>

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
                                                                String[][] comandantes = com.pesquisarComandantes().clone();
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
                                                <input type="submit" class="btn col s4 center-align push-s4 z-depth-5 blue " >Salvar />
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
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;nome Embarcacao</th>
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
                            String[][] viagens = viagem.pesquisarViagens().clone();
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
                            %>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[1][i]%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[2][i]%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[3][i]%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= inicio%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[5][i]%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= fim%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[7][i]%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[8][i]%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= cadastro%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <span class="sr-only">Dropdown</span>
                                    </button>
                                    <div class="dropdown-menu">
                                        <%
                                            request.setAttribute("idViagem", viagens[0][i]);
                                        %>
                                        <!--<a class="dropdown-item" href="#" data-toggle="modal" data-target="#modalExemplo" id="" onClick="edite(this)">Editar</a>-->
                                        <a class="dropdown-item" href="editViagem.jsp"  id="<%= viagens[0][i]%>">Editar</a>
                                        <a class="dropdown-item" href="excluirViagem.jsp">Deletar</a>
                                    </div>
                                </div>
                            </th>
                        </tr>
                        <%  }
                            }
                        %>


                    </table>

                </div>
            </div>
        </div>
    </div>
    <!-- Modal EDIÇÃO -->
    <div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content col-12">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Editar Viagem</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <!-- CORPO DA MODAL DE EDIÇÃO -->
                <div class="modal-body">

                    <form id="mod2" name="tab" action="cadastrarViagem.jsp" method="get">

                        <div class="form-group col-12">
                            <div class="col-12 ">
                                <div class="input-field col-6">
                                    <input name="nomeViagem" class="validate black-text" id="nomeViagemEdit" type="text" required>
                                    <label for="nomeViagem" id="nomeLabel">Nome da Viagem</label>
                                </div>
                                <div class="col-6">
                                    <select class="browser-default col" name="status" id="statusEdit" required >
                                        <option value="" disabled selected>Status de Viagem</option>
                                        <option value="0">Agendado</option>
                                        <option value="1">Em Progresso</option>
                                        <option value="2">Finalizado</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group col-12">
                                <div class="input-field col s6">
                                    <div class="input-field col-6">
                                        <input name="origem" class="validate black-text" id="origemEdit" type="text" required>
                                        <label id="origemLabel" for="origem">Origem</label>
                                    </div>
                                    <div class="input-field col-6">
                                        <input name="destino" class="validate black-text" id="destinoEdit" type="text" required>
                                        <label id="destinoLabel" for="destino">Destino</label>
                                    </div>
                                </div>
                                <div class="input-field col s6">
                                    <input type="text" name="datetimes22" id="datetimes22Edit" />
                                    <label id="datetimeLabel" for="datetimes22">Datas e Horarios</label>
                                </div> 
                            </div>
                            <div class="form-group col s12">
                                <span class="card-title center"><b>Embarcação</b></span>

                                <div class="col s6">
                                    <select class="browser-default black-text" name="barco" id="barcoEdit" required > 
                                        <option class="black-text" value="" disabled selected>Barco</option>
                                        <%
                                            BarcoDao bar2 = new BarcoDao();
                                            String[][] barcos2 = bar2.pesquisaBarcos().clone();
                                            for (int i = 0; i < 10; i++) {
                                                if (barcos2[0][i] == null) {
                                                    i = 50;
                                                } else {
                                        %>
                                        <option class="black-text" value="<%=barcos2[0][i]%>"><%=barcos2[1][i]%></option>

                                        <%
                                                }
                                            }%>
                                    </select>
                                </div>
                                <div class="col s6"> 
                                    <select class="browser-default black-text" name="comandante" id="comandanteEdit" required>
                                        <option class="black-text" value="" disabled selected>Comandante</option>
                                        <%
                                            ComandanteDao com2 = new ComandanteDao();
                                            String[][] comandantes2 = com2.pesquisarComandantes().clone();
                                            for (int i = 0; i < 200; i++) {
                                                if (comandantes2[0][i] == null) {
                                                    i = 500;
                                                } else {
                                        %>
                                        <option class="black-text" value="<%=comandantes2[0][i]%>"><%=comandantes2[1][i]%></option>

                                        <%
                                                }
                                            }%>
                                    </select>
                                </div>


                            </div>

                        </div>

                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary">Salvar mudanças</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function confirma(form) {
            form.submit();
            return false;
        }

        
        
    </script>
    <!--FIM do Corpo do App -->

    <!--Materialize JS -->
    <script src="js/materialize.js">

    </script>
    <!--Materialize NavBar -->    



</body>
</html>