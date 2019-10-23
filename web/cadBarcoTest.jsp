<%@page import="src.Barco"%>
<%@page import="dao.Rpm"%>
<%@page import="logic.Format"%>
<%@page import="dao.BarcoDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>--%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

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
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <!--FIM Cabeçalho Para Materialize-->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

    </head>
     

       <script>
            $(document).ready(function(){
                $('.dropdown-trigger').dropdown();
                $('select').formSelect();
                $('.collapsible').collapsible();
                $(".dropdown-trigger").dropdown('toggle');
            });
        </script>
    </div>
    <%
        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> " + conta);
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        Statement stmt1 = con.createStatement();
        Statement stmt2 = con.createStatement();
    %>
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
    <%
    String recebMct = "";
    recebMct = request.getParameter("enviaMct");
    %>
    <br>
        <div class="row ">
            <div class="col s12">
                <div class="card offset-s5">
                    <div class="card-content white-text ">
                        <span class="card-title black-text center"><b>Cadastro Embarcação</b></span>
                        <div class="row">
                            <div class="container col s12">
                                <div class="row ">
                                    
                                    <form id="mod" name="tab" action="cadastrarBarco.jsp" method="get">

                                        <div class="form-group col s12">
                                            <div class="form-row col s6 center-align">
                                                <div class="col s12 push-s6 center-align">
                                                    <label>Escolha o Empurrador</label>
                                                    <select class="browser-default black-text" name="mctBarco" >
                                                        <option value="" disabled selected>Empurrador</option>
                                                        <%
                                                            /*
                                                            
                                                            
                                                            */
                                                            
                                                            Rpm rpm = new Rpm();
                                                            String[][] veiculo = rpm.nomeEmbarcacao(conta, con, stmt).clone();
                                                            for (int i = 0; i < 100; i++) {
                                                                if (veiculo[1][i] == null) {
                                                                    i = 100;
                                                                } else {
                                                                    if (veiculo[1][i].equals(recebMct)) {%>
                                                                    <option selected value="<%=veiculo[0][i] + "--" + veiculo[1][i]%>"><%=veiculo[0][i] + " - " + veiculo[1][i]%> </option>
                                                        
                                                                       <% }else{
                                                        %>
                                                        <option value="<%=veiculo[0][i] + "--" + veiculo[1][i]%>"><%=veiculo[0][i] + " - " + veiculo[1][i]%> </option>
                                                        <%}}
                             }%>
                                                    </select>
                                                </div>
                                                
                                                <div class="col s12 push-s6 center-align">
                                                    <label class="left">Motor</label>
                                                    <select class="browser-default black-text" name="motor" id="motor" required>
                                                        <option class="black-text"value="" disabled selected>Motores</option>
                                                        <%
                                                            BarcoDao com = new BarcoDao();
                                                            String[][] motores = com.pesquisaMotores(conta, con, stmt).clone();
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


        
            <thead class=" background #0277bd light-blue darken-1">
            <b><tr>
                    <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;MCT / UCC</th>
                    <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;Embarcação</th>
                    <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;Motor</th>
                    <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;Modelo</th>
                    <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;Base</th>
                    <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;Data Cadastro</th>
                    <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;</th>
                    <th class="white-text"><i class="material-icons"></i>&nbsp;&nbsp;</th>
                </tr></b>
            </thead>

            <%
                Format format = new Format();
                String data;
                BarcoDao barco = new BarcoDao();
                List<Barco> barcos = barco.pesquisaBarcosX(conta, con, stmt);
                request.setAttribute("barcos",barcos); 
            %>
            <c:forEach items="${barcos}" var="b"> 
                <tr>
                    <th><i class="material-icons"></i>&nbsp;&nbsp;${b.getMct()}</th>
                    <th><i class="material-icons"></i>&nbsp;&nbsp;${b.getNome()}</th>
                    <th><i class="material-icons"></i>&nbsp;&nbsp;${b.getMotor()}</th>
                    <th><i class="material-icons"></i>&nbsp;&nbsp;${b.getModelo()}</th>
                    <th><i class="material-icons"></i>&nbsp;&nbsp;${b.getBase()}</th>
                    <th><i class="material-icons"></i>&nbsp;&nbsp;${format.DataFormat(b.getDataCad())}</th>
                    <th style="width:250px">
                        <i class="material-icons" ></i>&nbsp;&nbsp;<a class="btn" href="editBarco.jsp?idBarco=${b.getId}"><i class="material-icons">create</i>Editar</a>
                        <i class="material-icons"></i>&nbsp;&nbsp;<a class="btn" href="excluirBarco.jsp?idBarco=${b.getId}"><i class="material-icons">delete</i>Deletar</a>
                    </th>
                </tr>
            </c:forEach>

        

    
</div>

<script type="text/javascript">
    function confirma(form) {
        form.submit();
        return false;
        $(".dropdown-trigger").dropdown();
    }
</script>

<!--FIM do Corpo do App -->

<!--Materialize JS -->
<script>
    $('.dropdown-trigger').dropdown();
</script>
<!--Materialize NavBar -->    




</html>
