<%@page import="src.Comandante"%>
<%@page import="logic.Format"%>
<%@page import="dao.ComandanteDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>

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
        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

    </head>
    <body >
        <script>
            $(document).ready(function(){
                $('.dropdown-trigger').dropdown();
                $('select').formSelect();
                $('.collapsible').collapsible();
                $(".dropdown-trigger").dropdown('toggle');
            });
        </script>
        <%
        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> " + conta);
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
    %>

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
        
        <!-- INCLUDE DA NAVBAR -->
        <jsp:include page="navbar.jsp"></jsp:include>  
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
                            <span class="card-title center black-text"><b>Cadastro de Comandante</b></span>
                            <div class="row">
                                <div class="container col s12">
                                    <div class="row ">

                                        <form id="mod" name="tab" action="cadastrarComandante.jsp" method="get">

                                            <div class="form-group col s12">
                                                <div class="form-row col s6 center-align">
                                                    <div class="input-field col s12 push-s6 center-align">
                                                        <input name="idC" class="validate black-text" type=hidden id="idC"  type="text" >
                                                        <input name="nome" class="validate black-text" id="nome" type="text" required >
                                                        <label for="nomeComandate">Nome do Comandante</label>
                                                    </div>
                                                    <div class="input-field col s12 push-s6 center-align">
                                                        <input name="matricula" class="validate black-text" id="matricula" type="text" required >
                                                        <label for="matricula">Matricula</label>
                                                    </div>
                                                    <div class="input-field col s12 push-s6 center-align">
                                                        <input name="contato" class="validate black-text" id="contato" type="text" required>
                                                        <label for="contato">Contato</label>
                                                    </div>
                                                </div>
                                                <div class="card-action col s12">
                                                    <input type="submit" class="btn col s4 center-align push-s4 z-depth-5 blue" >Salvar<i class="material-icons right">send</i>/>
                                                </div>
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
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;Nome</th>
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;Matricula</th>
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;Contato</th>
                                <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;</th>
                            </tr></b>
                        </thead>

                        <%
                            ComandanteDao coman = new ComandanteDao();
                            List<Comandante> comandantes = coman.pesquisarComandantesX(conta, con, stmt);
                            Iterator<Comandante> comandantesAsInterator = comandantes.iterator();
                            while(comandantesAsInterator.hasNext()){
                                Comandante comandante = comandantesAsInterator.next();
                        %>
                        <tr>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= comandante.getNome()%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= comandante.getMatricula()%></th>
                            <th><i class="material-icons"></i>&nbsp;&nbsp;<%= comandante.getContato()%></th>
                            <th style="width:250px">
                                <i class="material-icons"></i>&nbsp;&nbsp;<a class="btn" href="editComandante.jsp?idComandante=<%= comandante.getIdComandante()%>"><i class="material-icons">create</i>Editar</a>
                                <i class="material-icons"></i>&nbsp;&nbsp;<a class="btn" href="excluirComandante.jsp?idComandante=<%= comandante.getIdComandante()%>"><i class="material-icons">delete</i>Deletar</a></th>
                        </tr>
                        <%  }
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
        }
        );

    </script>
    <!--Materialize NavBar -->    



</body>
</html>