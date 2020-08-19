<%-- 
    Document   : equipamentos2
    Created on : 29/07/2020, 10:58:52
    Author     : Lacerda
--%>

<%@page import="dao.EquipV"%>
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
            body { height: 100%; margin: 0; padding: 0;}
            .wrap { max-width: 110em; min-height: 90em; height:100%; width:100%; margin: 0 auto; padding-top: 2.5%;}
            #map-canvas { height: 100%; }
            .mctTable {overflow-y: auto; height: 500px; width: 500px;margin: auto;display: block;}
            .btnSalvar {text-align: center;}
            .tableSize {margin: 0; width: -webkit-fill-available; table-layout:fixed;}
            .list {margin-bottom: 0 !important;}
            p { margin: auto !important;}
            p.vis {text-align: center;}
            .cabecalho {background-color: #0277bd !important; color: #fff;}
        </style>
        <!--Materialize Icones -->  
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Materialize CSS -->
        <link rel="stylesheet" type="text/css" href="css/materialize.css">
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <!--FIM Cabeçalho Para Materialize-->
        <script src="js/jquery.js"></script>
        <link rel="stylesheet" type="text/css" href="css/materialize.css">
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        

    </head>

    <body>
        <%
            /* Inicio de Sessão */
            String conta = session.getAttribute("conta").toString();
            System.out.println("Numero da conta é >>>>> " + conta);
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
            
            Rpm rpm = new Rpm();
            String[][] equips = rpm.listarEquipamentos(conta);
            EquipV equipv = new EquipV();
            String equipsCadastrados = equipv.getEquips(conta, con, stmt);
            System.out.println("EQUIPS!!!");
            System.out.println(equipsCadastrados);
            
        %>
         <!-- INCLUDE DA NAVBAR -->
        <jsp:include page="navbar.jsp"></jsp:include>
        
        <div class="container col s6">
            <h5 style="text-align: center;">Selecione os equipamentos que deseja visualizar no sistema</h5>
            <form id="mod" name="tab" action="cadastrarEquip.jsp" method="get">
                <input id="mcts" type='hidden' name="mcts" value=""/>
                <div class="mctTable">
                    <div>
                        <ul class="collection">
                            <li class="collection-item cabecalho">
                                <div class="list row">
                                    <p class="col s2">MCT</p>
                                    <p class="col s6 vis">NOME</p>
                                    <p class="col s4 vis">VISUALIZAR</p>
                                </div>
                            </li>
                        
                                <%
                                    for (int i = 0; i < 100; i++) {
                                        if(equips[0][i] == null){
                                            i=100;
                                        }else{
                                            System.out.println("MCT: "+equips[0][i]);
                                            %>
                                            <li class="collection-item">
                                                <div class="list row">  
                                                    <p class="col s2"><%=equips[0][i]%></p>
                                                    <p class="col s6 vis"><%=equips[1][i]%></p>
                                                    <p class="col s4 vis">
                                                        <% 
                                                                if(equipsCadastrados.indexOf(equips[0][i]) > -1){ 
                                                                System.out.println("ENTROU NO IF");
                                                            %>
                                                                    <input type="checkbox" class="filled-in" checked="checked" id="id<%=equips[0][i]%>_<%=i%>" name="<%=equips[0][i]%>" />
                                                                    <label for="id<%=equips[0][i]%>_<%=i%>"></label>
                                                            <%  }else{ %>
                                                                    <input type="checkbox" class="filled-in" id="id<%=equips[0][i]%>_<%=i%>" name="<%=equips[0][i]%>" />
                                                                    <label for="id<%=equips[0][i]%>_<%=i%>"></label>
                                                            <%  } %>
                                                            
                                                    </p>
                                                </div>
                                            </li><%
                                        }
                                    }
                                %>               
                        </ul>
                    </div>
                </div>
                        <br>
                        <div class="col s6" style="text-align: center;">
                            <button class="waves-effect waves-light btn-large btnSalvar" style="margin: auto;" type="submit">Salvar</button>                        
                        </div>
            </form>
                    <script>
                        $(document).ready(function() {
                            $("input[type=checkbox]").change(function() {
                                console.log('kkkku');
                                var equip="";
                                var x= 0;
                                $("input[type=checkbox]").each(function(){
                                    console.log(x)
                                   if(this.checked){
                                       equip = equip+"_"+this.name;
                                   }
                                   x++;
                                });
                                $('#mcts')[0].value = equip;
                                console.log($("#mcts")[0].value);
                            });                            
                        });
                        
                    </script>
        </div>
    </body>
</html>
