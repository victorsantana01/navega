<%@page import="logic.Format"%>
<%@page import="dao.BarcoDao"%>
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
        <meta name="viewport" content="initial-scale=1, maximum-scale=1">
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
    <body> 


    </div>
    <%
        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> " + conta);
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
        <li class="left-align"><a href="cadViagem.jsp"><b><i class="material-icons">map</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Cadastro Viagem</h6></b></a></li>
        <li class="left-align"><a href="cadComandante.jsp"><b><i class="material-icons">person_add</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Cadastro Comandante</h6></b></a></li>
        <li class="left-align"><a href="cadBarco.jsp"><b><i class="material-icons">directions_boat</i>&nbsp;&nbsp;&nbsp;</b><b class=" waves-effect"><h6>Cadastro Barco</h6></b></a></li>
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

    <div class=" container "><br>
        <div class="row ">
            <div class="col s12">
                <div class="card offset-s5">
                    <div class="card-content white-text ">
                        <span class="card-title black-text center">Cadastro Embarcação</span>
                        <div class="row">
                            <div class="container col s12">
                                <div class="row ">
                                    <form id="mod" name="tab" action="cadastrarBarco.jsp" method="get">

                                        <div class="form-group col s12">
                                            <div class="form-row col s6 center-align">
                                                <div class="input-field col s12 push-s6 center-align">
                                                    <input name="codBarco" class="validate black-text" id="codBarco" type="text" required>
                                                    <label for="codBarco">MCT / UCC</label>
                                                </div>
                                                <div class="input-field col s12 push-s6 center-align">
                                                    <input name="nomeBarco" class="validate black-text" id="nomeBarco" type="text" required>
                                                    <label for="nomeBarco">Nome da Embarcação</label>
                                                </div>
                                                <div class="col s12 push-s6 center-align">
                                                    <label class="left">Motor</label>
                                                    <select class="browser-default black-text" name="motor" id="motor" required>
                                                        <option class="black-text"value="" disabled selected>Motores</option>
                                                        <%
                                                            BarcoDao com = new BarcoDao();
                                                            String[][] motores = com.pesquisaMotores().clone();
                                                            for (int i = 0; i < 10; i++) {
                                                                if (motores[i][0] == null) {
                                                                    i = 50;
                                                                } else {
                                                        %>
                                                        <option class="black-text" value="<%=motores[i][0]%>"><%=motores[i][1]%></option>

                                                        <%
                                                                }
                                                            }%>
                                                    </select>
                                                </div>
                                                <div class="input-field col s12 push-s6 center-align">
                                                    <input name="modelo" class="validate black-text" id="modelo" type="text" required>
                                                    <label for="modelo">modelo</label>
                                                </div>
                                                <div class="input-field col s12 push-s6 center-align">
                                                    <input name="base" class="validate black-text" id="base" type="text" required>
                                                    <label for="base">base</label>
                                                </div>
                                            </div>



                                        </div>
                                        <div class="card-action col s12">
                                            <input type="submit" class="btn col s4 center-align push-s4 z-depth-5 blue " >Salvar<i class="material-icons right"> send</i></>
                                        </div>


                                    </form>

                                </div>



                            </div>
                        </div>

                    </div>


                </div>

            </div>
        </div>


        <table class="highlight striped responsive-table z-depth-4" id="dataTable">
            <thead class=" background #0277bd light-blue darken-1">
            <b><tr>
                    <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;MCT / UCC</th>
                    <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;Empurrador</th>
                    <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;Modelo</th>
                    <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;Base</th>
                    <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;Data Cadastro</th>
                </tr></b>
            </thead>


            <%
                BarcoDao barco = new BarcoDao();
                String[][] barcos = barco.pesquisaMotores().clone();
                for (int i = 0; i < 50; i++) {
                    if (barcos[i][0] == null) {
                        i = 50;
                    } else {
            %>
            <tr>
                <th><i class="material-icons"></i>&nbsp;&nbsp;<%= barcos[i][0]%></th>
                <th><i class="material-icons"></i>&nbsp;&nbsp;<%= barcos[i][1]%></th>
                <th><i class="material-icons"></i>&nbsp;&nbsp;<%= barcos[i][2]%></th>
                <th><i class="material-icons"></i>&nbsp;&nbsp;<%= barcos[i][3]%></th>
                <th><i class="material-icons"></i>&nbsp;&nbsp;<%= barcos[i][4]%></th>
            </tr>
            <%  }
            }
            %>


        </table>

    </div>
</div>

<script type="text/javascript">
            function confirma(form) {
                form.submit();
                return false;
                $(".dropdown-trigger").dropdown();

</script>

<!--FIM do Corpo do App -->

<!--Materialize JS -->
<script src="js/materialize.js">

                document.addEventListener('DOMContentLoaded', function () {
                    var elems = document.querySelectorAll('select');
                    var instances = M.FormSelect.init(elems, options);
                }
                );

</script>
<!--Materialize NavBar -->    



</body>
</html>