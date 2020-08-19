<%@page import="dao.Rpm"%>
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
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"><'+'/script>')</script>
        <!--FIM Cabeçalho Para Materialize-->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <!-- Compiled and minified JavaScript -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        
        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>  

    </head>
    <body> 


    </div>
    <%
        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> " + conta);
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        Statement stmt2 = con.createStatement();
        Statement stmt3 = con.createStatement();
    %>
    <script>
        $(document).ready(function(){
            $('.dropdown-trigger').dropdown();
            $('select').formSelect();
            $('.collapsible').collapsible();
            $(".dropdown-trigger").dropdown('toggle');
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
                    <li><a href="equipamentos.jsp">Equipamentos</a></li>
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


    
    
</div>

<script type="text/javascript">
    $(".dropdown-trigger").dropdown();

</script>

<!--FIM do Corpo do App -->

<!--Materialize NavBar -->    



</body>
</html>
