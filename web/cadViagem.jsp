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
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <!--FIM Cabeçalho Para Materialize-->
        <script src="js/jquery.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>


    </head>
    <%

        if (session.getAttribute("user") != null) {
            System.out.println("Está logado o usuario: " + session.getAttribute("user"));

        } else {
            response.sendRedirect("login.jsp");
        }%>
    <body> 

        <script type="text/javascript">
            $(".dropdown-trigger").dropdown();
            $(document).ready(function () {
                $('.datepicker').datepicker();
            });



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
        <!--INICIO do Corpo do App -->

        <div class=" container"><br>
            <div class="row ">
                <div class="col s12">
                    <div class="card">
                        <div class="card-content black-text ">
                            <span class="card-title center">Cadastro de Viagem</span>
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
                                                        <input name="origem" class="validate black-text" id="origem" type="text" required>
                                                        <label for="origem">Origem</label>
                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input name="dataInicio" class="form-control col s8" id="dataInicio" type="date"  aria-describedby="nameHelp" required>

                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input name="destino" class="validate black-text" id="destino" type="text" required> 
                                                        <label for="destino">Destino</label>
                                                    </div>
                                                    <div class="input-field col s6">
                                                        <input name="dataFim" class="form-control col s8" id="dataFim" type="date"  aria-describedby="nameHelp" required>

                                                    </div> 
                                                </div>
                                                <div class="form-group col s12">
                                                    <span class="card-title center">Embarcação</span>

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
                        <tr>
                            <%
                                System.out.println("jesus ----------------------------------");
                                inicio = format.DataFormat(viagens[4][i]);
                                System.out.println("kkkkk");
                                fim = format.DataFormat(viagens[6][i]);
                                cadastro = format.DataFormat(viagens[9][i]);
                                System.out.println("inicio: "+inicio+" , fim: "+fim+" , cadastro: "+cadastro+"-----------------------");
                            %>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[1][i]%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[2][i]%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[3][i]%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= inicio%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[5][i]%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= fim%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[7][i]%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= viagens[8][i]%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= cadastro %></th>
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
        $(".dropdown-trigger").dropdown();
    </script>

    <!--FIM do Corpo do App -->

    <!--Materialize JS -->
    <script src="js/materialize.js">

        document.addEventListener('DOMContentLoaded', function () {
            var elems = document.querySelectorAll('select');
            var instances = M.FormSelect.init(elems, options);
        });

    </script>
    <!--Materialize NavBar -->    



</body>
</html>