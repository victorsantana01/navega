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
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <!--FIM Cabeçalho Para Materialize-->
        <script src="js/jquery.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <!-- Compiled and minified JavaScript -->
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
                        <span class="card-title black-text center"><b>Editar Embarcação</b></span>
                        <div class="row">
                            <div class="container col s12">
                                <div class="row ">
                                    <form id="mod" name="tab" action="editarBarco.jsp" method="get">
                                        <!--FAZ UMA PESQUISA APARTI DE UM ID, E SALVA O RESULTADO EM UM ARRAY-->
                                        <%
                                            String idbarco = request.getParameter("idBarco");
                                            System.out.println("idbarco: "+idbarco);
                                            BarcoDao barco = new BarcoDao();
                                            String[][] barcoE = barco.pesquisarBarco(conta, con, stmt, idbarco);
                                            for (int i = 0; i < barcoE.length; i++) {
                                                System.out.println("**********************  " + barcoE[i][0]);
                                            }
                                        %>
                                        <div class="form-group col s12">
                                            <div class="form-row col s6 center-align">
                                                <div class="col s12 push-s6">
                                                    <label>Escolha o Empurrador</label>
                                                    <input name="idBarco" class="validate black-text" id="idBarco" type=hidden value="<%= barcoE[0][0]%>" type="text" >
                                                    <select class="browser-default black-text" name="mctBarco" >
                                                        <option value="" disabled>Empurrador</option>
                                                        <%
                                                            Rpm rpm = new Rpm();
                                                            String[][] veiculo = rpm.nomeEmbarcacao(conta, con, stmt,idbarco).clone();
                                                            for (int i = 0; i < 100; i++) {
                                                                if (veiculo[1][i] == null) {
                                                                    i = 100;
                                                                } else {
                                                                    if(barcoE[1][0].equals(veiculo[1][i])){
                                                                  %>
                                                                    <option value="<%=veiculo[0][i] + " - " + veiculo[1][i]%>" selected><%=veiculo[0][i] + " - " + veiculo[1][i]%> </option>
                                                        <%  
                                                                }else{
                                                        %>
                                                                    <option value="<%=veiculo[0][i] + "--" + veiculo[1][i]%>"><%=veiculo[0][i] + " - " + veiculo[1][i]%> </option>
                                                        <%}
            }
                             }%>
                                                    </select>
                                                </div>
                                                <div class="col s12 push-s6 center-align">
                                                    <label class="left">Motor</label>
                                                    <select class="browser-default black-text" name="motor" id="motor" required>
                                                        <option class="black-text"value="" disabled>Motores</option>
                                                        <%
                                                            BarcoDao com = new BarcoDao();
                                                            String[][] motores = com.pesquisaMotores(conta, con, stmt).clone();
                                                            for (int y = 0; y < 10; y++) {
                                                                if (motores[y][0] == null) {
                                                                    y = 50;
                                                                } else {
                                                                    if (barcoE[3][0].equals(motores[y][0])) {
                                                        %>
                                                        <option class="black-text" value="<%=motores[y][0]%>" selected><%=motores[y][1]%></option>
                                                        <% } else {%>
                                                        <option class="black-text" value="<%=motores[y][0]%>"><%=motores[y][1]%></option>

                                                        <%
                                                                    }
                                                                }
                                                            }%>
                                                    </select>
                                                </div>
                                                <div class="input-field col s12 push-s6 center-align">
                                                    <input name="modelo" class="validate black-text" id="modelo" type="text" value="<%=barcoE[4][0]%>" required>
                                                    <label for="modelo">modelo</label>
                                                </div>
                                                <div class="input-field col s12 push-s6 center-align">
                                                    <input name="base" class="validate black-text" id="base" value="<%=barcoE[5][0]%>"  type="text" required>
                                                    <label for="base">base</label>
                                                </div>
                                            </div>



                                        </div>
                                        <div class="card-action col s12">
                                            <input type="submit" class="btn col s4 center-align push-s4 z-depth-5 blue " >Editar<i class="material-icons right"> send</i></>
                                        </div>


                                    </form>

                                </div>



                            </div>
                        </div>

                    </div>


                </div>

            </div>
        </div>


    </div>
</div>

<script type="text/javascript">
            function confirma(form) {
                form.submit();
                return false;
                $(".dropdown-trigger").dropdown();

</script>

<!--FIM do Corpo do App -->

<!--Materialize NavBar -->    



</body>
</html>
