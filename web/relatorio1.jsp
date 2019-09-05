<%@page import="java.sql.Statement"%>
<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page import="java.sql.Connection"%>
<%@page import="logic.Format"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="teste.Teste"%>
<%@page import="dao.ConsumoDao"%>
<%@page import="relatorios.RelatorioNavegacao"%>
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
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script
        <!--Materialize Icones -->  
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/print.css"  media="print" />
        <!--Materialize CSS -->
        <link rel="stylesheet" type="text/css" href="css/materialize.css">
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <!--FIM Cabeçalho Para Materialize-->
        <script src="js/jquery.js"></script>
        
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
<%

        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> "+conta);
        
                Connection con = ConexaoMySQL.getConexaoMySQL();

                Statement stmt = con.createStatement();
%>                


    <style>
        .nada{
            
        }
    </style>
    
    <script>
function abreLink(url){
	//window.open('index.jsp');
          window.open(url,"janela1","width=700,height=500,scrollbars=NO");
}
</script>
<script type="text/javascript">
    
    $(document).ready(function(){
    $('.datepicker').datepicker();
  });
 
    var visibilidade = true; //Variável que vai manipular o botão Exibir/ocultar

    function exibir() {
        document.getElementById("divCorpo").style.display = "block";
    }
 
    function ocultar() {
        document.getElementById("divCorpo").style.display = "none";
    }
    //Botões de exibir/ Ocultar
        function exibirDeslocamento() {
        document.getElementById("idDeslocamento").style.display = "block";
        document.getElementById("btnMais").style.display = "none";
         document.getElementById("btnMenos").style.display = "block";
    }  
    
 function ocultarDeslocamento() {
        document.getElementById("idDeslocamento").style.display = "none";
        document.getElementById("btnMenos").style.display = "none";
       document.getElementById("btnMais").style.display = "block";
    }
  
  //Botões Exibir / Ocultar Consumo
  function exibirConsumo2() {
        document.getElementById("divConsumo2").style.display = "block";
        document.getElementById("btnMaisConsumo2").style.display = "none";
         document.getElementById("btnMenosConsumo2").style.display = "block";
    }  
    
 function ocultarConsumo2() {
        document.getElementById("divConsumo2").style.display = "none";
        document.getElementById("btnMenosConsumo2").style.display = "none";
       document.getElementById("btnMaisConsumo2").style.display = "block";
    }
  function exibirConsumo() {
        document.getElementById("divConsumo").style.display = "block";
        document.getElementById("btnMaisConsumo").style.display = "none";
         document.getElementById("btnMenosConsumo").style.display = "block";
    }  
    
 function ocultarConsumo() {
        document.getElementById("divConsumo").style.display = "none";
        document.getElementById("btnMenosConsumo").style.display = "none";
       document.getElementById("btnMaisConsumo").style.display = "block";
    }
    //Botões Exibir / Ocultar RPM
  function exibirRpm() {
        document.getElementById("divRpm").style.display = "block";
        document.getElementById("btnMaisRpm").style.display = "none";
         document.getElementById("btnMenosRpm").style.display = "block";
    }  
    
 function ocultarRpm() {
        document.getElementById("divRpm").style.display = "none";
        document.getElementById("btnMenosRpm").style.display = "none";
       document.getElementById("btnMaisRpm").style.display = "block";
    }
  $(document).ready(function(){   
              ocultarDeslocamento();
              ocultarConsumo();
              ocultarConsumo2();
              ocultarRpm();
        });
        
        
        
function chama(link){

window.location.href = link ;


}

  
            function printpage()
            {
                window.print()
            }
            function ocultarFiltro() {

                
                document.getElementById("btnPesquisa").style.display = "none";
                document.getElementById("divCampo").style.display = "none";
                document.getElementById("navBar").style.display = "none";
                
               var div = document.querySelector('#areaRelatorio');
               trocaClasse(div, 'container', 'nada');
               exibirConsumo();
               document.getElementById("btnMenosConsumo").style.display = "none";
               exibirConsumo2();
                document.getElementById("btnMenosConsumo2").style.display = "none";
                exibirRpm();
                document.getElementById("btnMenosRpm").style.display = "none";
                document.getElementById("btnPrint").style.display = "none";
                exibirDeslocamento();
                printpage();
                document.getElementById("btnMenos").style.display = "none";
                document.getElementById("btnPesquisa").style.display = "block";
                document.getElementById("btnPrint").style.display = "block";
                ocultarRpm();
                ocultarConsumo();
                ocultarConsumo2();
                
                document.getElementById("divCampo").style.display = "block";
                document.getElementById("navBar").style.display = "block";
                trocaClasse(div,'nada','container');
            }
            function mostrarFiltro() {
                document.getElementById("filtro").style.display = "block";

            }





    
function trocaClasse(elemento, antiga, nova) {
    elemento.classList.remove(antiga);
    elemento.classList.add(nova);
}

</script>
        <style type="text/css">
        
        .linha{
            border-color:#aaa;
            box-sizing:border-box;
            width:100%;  
        }
        table.table-style-one {
            font-family: verdana,arial,sans-serif;
            font-size:14px;
            color:#333333;
            border-width: 1px;
            border-color: #3A3A3A;
            border-collapse: collapse;
        }
        table.table-style-one th {
            border-width: 1px;
            padding: 14px;
            border-style: solid;
            border-color: #3A3A3A;
            background-color: #B3B3B3;
        }
        table.table-style-one td {
            border-width: 1px;
            padding: 14px;
            border-style: solid;
            border-color: #3A3A3A;
            background-color: #ffffff;
        }
    </style>
    </head>
    <!--
    <body class="background #eeeeee grey lighten-3">
    -->
    <body>
        

<!-- START LEFT SIDEBAR NAV-->
        
         <!--Menu para Mobile -->
         
          <!-- Parou aqui, preciso colocar o filtro no side nav, inserir os relatorios--> 
           <ul id="menu-mobile" class="side-nav" style="width: 300px">
               
               <li class="center-align"><h5><i class="material-icons right-align small">directions_boat</i></h5></li>
               <li class="center-align"><h5>Filtrar Periodo</h5></li>
               <li>
                   <form method="get" name="filtro">
                   <div class="container">
                   <label for="exampleInputName">Inicio</label>
                   <input name="dataInicio" class="form-control"  type="date" >
                   </div>
                   
                   <div class="container">
                   <label for="exampleInputName">Fim</label>
                   <input name="dataFim" class="form-control"  type="date" >
                      <input type="text" class="datepicker">
                   </div>
                   
                   <div class="container">
                     <label>Escolha o Empurrador</label>
                     <select class="browser-default" name="mct" >
                         <option value="" disabled selected>Empurrador</option>
                         <%
                             Rpm rpm = new Rpm();
                             String[][] veiculo = rpm.painelAtualizado(conta,con,stmt).clone();
                             for (int i = 0; i < 100; i++) {
                                 if (veiculo[1][i] == null) {
                                     i = 100;
                                 } else {
                         %>
                         <option value="<%=veiculo[1][i]%>"><%=veiculo[0][i] + " - " + veiculo[1][i]%> </option>
                         <%}
                    }%>
                     </select>
                   </div>
                      <div class="container">
                     <label>Perfil de Motor</label>
                     <select class="browser-default" name="nomeMotor" id="selectService" >
                    
                     <%
                     ConsumoDao cons = new ConsumoDao();
                   
                     String [][] dados = cons.getTabelaConsumo().clone();
                       

                      for (int i = 0; i < 500; i++) {
         
                     if(cons.getTabelaConsumo()[0][i]==null){
                         i=500;
                         
                     }else{%>
                     <option value="<%=dados[0][i]%>"><%=dados[0][i]%></option>
                    <%}}%>
                </select>
                   </div>
                <div class="container">
                    <a  class="btn col s6 center-align push-s3 z-depth-5  " onclick ='confirma(filtro)'>Buscar<i class="material-icons right">send</i></a>
                </div>
                    </form>
                
                <%
                    
                String mct = request.getParameter("mct");
                String parametro = "";
                String parametro2 = "";
                if (mct == null) {
                        parametro = "none";
                    }else{
                    parametro="block";
                }
                if (mct == null) {
                        parametro2 = "block";
                    }else{
                    parametro2="none";
                }
                
                %>
                
               </li>
           </ul>
        <!-- START LEFT SIDEBAR NAV FIM--> 
        
       
      
         <!--Materialize NavBar -->    

           <nav class="navbar-fixed z-depth-5 #0097a7 cyan darken-3" id="navBar" >
                 <div class="nav-wrapper" >
                     &nbsp;&nbsp;<a href="index.jsp" class="brand-logo right-aligned"><b><i class="material-icons">directions_boat</i><h5>NAVEGA GESTOR</h5></b></a>
                    <ul id="nav-mobile" class="right hide-on-med-and-down">
                         <li class="left-align"><a href="index.jsp" ><b class="center-align  waves-effect">Inicio</b></a></li>
                         <li class="left-align"><a href="relatorio1.jsp"><b class=" waves-effect">Relatorio RPM</b></a></li>
                         <li class="left-align"><a href="relatorio2.jsp"><b class=" waves-effect">Relatorio Consolidado</b></a></li>
                         <li class="left-align"><a href="tables.jsp"><b class="center-align  waves-effect">Tabela de Consumo</b></a></li>
                         <li class="left-align"><a href="motores.jsp"><b class=" waves-effect">Motores</b></a></li>
                         <li class="left-align"><a href="login.jsp"><b class=" waves-effect">Sair</b></a></li>
                     </ul>
                 </div>
         </nav>
   
         
        <!--INICIO do Corpo do App -->
           
        <div id="btnPesquisa" class="row"><br>
           <!-- Botão pesquisar--> 
           <div class="col s6 ">
               <a data-activates="menu-mobile" class="button-collapse right  btn-floating blue pulse z-depth-5 btn-large"><i class="material-icons">search</i></a>    
           </div>
         
          
          <!-- Fim Botão pesquisar--> 
        </div>

        <!--Preloder-->
        <div class="row" style="display: <%=parametro2%>">
            <div class="container"><br><br><br><br>
                <span class="flow-text center-align">
                    <h5>Clique no botão acima para começar.</h5>
                </span>
                <div class="progress">
                    <div class="indeterminate"></div>
                </div>
            </div>
        </div>
        <!--Fim Preloder-->
        <div class=" container " id="divCampo"><br>
        
        </div>
        
        <div id="areaRelatorio" class=" container "><br>
            <div id="areaRelatorio" class="row ">
                     
                <div class="col s12">
               
                  <button id="cmd" class="btn medium right 455a64 blue-grey darken-2" ><i class="material-icons">print</i>
                     </button> 
                          
                            <div class="center"  id="divCorpo" style="display: <%=parametro%>">
                                
                                <span class="flow-text">
                                  
                        
                                    <h4><b>Graficos de RPM</b></h4>
                                    <%
                                        
                                        Format format = new Format();
                                        String inicio = request.getParameter("dataInicio");
                                        System.out.println(">>>>>>>>>> "+inicio);
                                        String begin = inicio;
                                        
                                        String fim = request.getParameter("dataFim");
                                         String finish = fim;
                                        if (inicio == null || inicio == "") {
                                            inicio = format.hoje();
                                        }

                                        inicio = format.DiaFormat(inicio);
                                        if (fim == null || fim == "") {
                                            fim = format.hoje();
                                        }
                                        System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<< "+inicio);
                                        
                                       
                                               
                                        fim = format.DiaFormat(fim);
                                        String empurrador = request.getParameter("mct");
                                         
                                    %>
                                    
                                    <h5><%=inicio + " a " + fim%></h5>
                                    <h5><%=empurrador%></h5>
                                </span>

                              
                                <div id="columnchart_values" style="width: 1000px; height:400px;"></div>
                              
                               
                                <div  id="curve_chart_r1"  style="width: 1150px; height: 500px"></div>  
                                <div  id="curve_chart_r2"  style="width: 1150px; height: 500px"></div>


                                <span class="flow-text center">
                                    <h4 class=" btn " id="btnMenosConsumo" onclick="ocultarConsumo()"><b>Relatorio de Consumo</b></h4>
                                    <h4 class=" btn " id="btnMaisConsumo" onclick="exibirConsumo()"><b>Relatorio de Consumo</b></h4>
                                </span>
                                
                                <div class="card mb-3" id="divConsumo" style="display: none">
                                  <span class="flow-text center-align">
                                 <h5>Consumo Motor  01</h5>
                                  </span>
                                    <div class="table-responsive">
                                        <table class="striped "id="dataTable3" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th>RPM</th>
                                                    <th>Minutos</th>
                                                    <th>QTD Registros</th>
                                                    <th>Litros por Hora</th>
                                                </tr>
                                            </thead>

                                            <%
                                                
                                                String[][] painel1;
                                                painel1 = rpm.getPrincipalRpm(begin, finish, request.getParameter("mct"),con,stmt).clone();
                                             
                                                String consumo = "";
                                                String latLon = "";
                                                String entrada = null;
                                                double total = 0.0;
                                                double consumoDouble;
                                                System.out.println("Valida1 >>>>>>>>>>>>>>>>>> "+painel1[4][0]);
                                                for (int i = 0; i < 2000; i++) {
                                                    if (painel1[0][i] == null || painel1[0][i] == "0") {
                                                        i = 2000;
                                                    } else {
                                                         System.out.println("audit >>>>>>>>>>>>>>>>>> "+painel1[1][i]);
                                            %> 
                                            <tr>

                                                <td style="display: none" id="rpmConsumo">
                                                    <%= painel1[0][i]%>
                                                </td>
                                            <input style="display: none" name="rpmConsumo" value=" <%= painel1[0][i]%>">
                                            <td id="testeId">
                                                <%
                                                latLon = painel1[3][i]+painel1[4][i];
                                                %>
                                                <a class=" btn-floating  z-depth-5 btn-small " id="rpmBtn" onclick="alert(<%=latLon%>);abreLink('login.jsp')">
                                            <i  class="material-icons">location_on</i></a> &nbsp;&nbsp;<%= painel1[0][i]%> 
                                                        </td>
                                            <td><%= painel1[1][i]%></td>
                                            <td><%= painel1[2][i]%></td>
                                            <%
                                                Teste te = new Teste();
                                                //ConsumoDao cons = new ConsumoDao();
                                                entrada = painel1[0][i];
                                                String[] vetEntrada = entrada.split("");
                                                if (vetEntrada.length == 2) {
                                                    entrada = "0";
                                                }
                                                if (vetEntrada.length == 3) {
                                                    entrada = vetEntrada[0] + "00";
                                                }
                                                if (vetEntrada.length == 4) {
                                                    entrada = vetEntrada[0] + vetEntrada[1] + "00";
                                                }

                                                System.err.println("Valor Arredondado é: " + entrada);

                                                consumo = te.consumo(cons.getLitrosPorRpm(request.getParameter("nomeMotor"), entrada), painel1[1][i]);

                                                consumoDouble = Double.valueOf(consumo);
                                                total = total + consumoDouble;

                                            %>
                                            <td><%=consumo + " Litros"%></td>
                                            </tr>

                                            <%
                                                    }
                                                }
                                                ;%> 
                                            <td><h5><b>TOTAL</b></h5></td>
                                            <td><h5><b><%=total%></b></h5></td>
                                                <script type="text/javascript">
                                                google.charts.load("current", {packages:['corechart']});
                                                google.charts.setOnLoadCallback(drawChart);
                                                function drawChart() {
                                                  var data = google.visualization.arrayToDataTable([
                                                    ["RPM", "Minutos", { role: "style" } ],
                                                    <%
                                                        String cor = "#0B243B";
                                                        double[] min = new double[200];
                                                        for (int i = 0; i < 200; i++) {
                                                            if (painel1[1][i] == null) {
                                                                i = 200;
                                                            } else {
                                                                min[i] = Double.parseDouble(painel1[1][i]);
                                                                if (min[i] >= 500) {
                                                                    cor = "#8A0808";
                                                                }
                                                                if (min[i] <= 100) {
                                                                    cor = "#DBA901";
                                                                }
                                                                if (min[i] <= 60) {
                                                                    cor = "#0B243B";
                                                                }
                                                    %>
                                            ["<%=painel1[0][i]%>",<%=min[i]%>, "<%=cor%>"],
                                                    <%}
                                                        }
                                                    %>
      ]);

      var view = new google.visualization.DataView(data);
      view.setColumns([0, 1,
                       { calc: "stringify",
                         sourceColumn: 1,
                         type: "string",
                         role: "annotation" },
                       2]);

      var options = {
        title: "Faixas de RPM frequentes",
        width: 1150,
        height: 400,
        bar: {groupWidth: "95%"},
        legend: { position: "none" },
      };
      var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
      chart.draw(view, options);
  }
  </script>

</tbody>
        </table><br>
        </div>
    </div>
                                

            
  
            <span class="flow-text center">
                <h4 class=" btn " id="btnMenosConsumo2" onclick="ocultarConsumo2()"><b>Relatorio de Consumo 2</b></h4>
                <h4 class=" btn " id="btnMaisConsumo2" onclick="exibirConsumo2()"><b>Relatorio de Consumo 2</b></h4>
            </span>
                
            <div class="card mb-3" id="divConsumo2" style="display: none;">
                  <span class="flow-text center-align">
                                 <h5>Consumo Motor  02</h5>
                                  </span>
                <div class="table-responsive">
                    <table class="striped "id="dataTable3" width="100%"  cellspacing="0">
                        <thead>
                            <tr>
                                <th>RPM</th>
                                <th>Minutos</th>
                                <th>QTD Registros</th>
                                <th>Litros por Hora</th>
                            </tr>
                        </thead>

                                                    <%
                                                        String[][] painel2;
                                                        painel2 = rpm.getPrincipalRpm2(begin,finish, request.getParameter("mct")).clone();
                                                       System.out.println("Valida2 >>>>>>>> "+painel2[0][0]);
                                                        String consumo2 = "";
                                                        String rpmArrendon2 = "";
                                                        String entrada2 = null;
                                                        double total2 = 0.0;
                                                        double consumoDouble2;
                                                        for (int i = 0; i < 2000; i++) {
                                                            if (painel2[0][i] == null || painel2[0][i] == "0") {
                                                                i = 2000;
                                                            } else {
                                                    %> 
                                                    <tr>

                                                        <td style="display: none" id="rpmConsumo">
                                                            <%= painel2[0][i]%>
                                                        </td>
                                                    <input style="display: none" name="rpmConsumo" value=" <%= painel2[0][i]%>">
                                                    <td id="testeId" >
                                                        <a class=" btn-floating  z-depth-5 btn-small " id="rpmBtn" onclick="exibirDeslocamento()"><i class="material-icons">location_on</i></a> 
                      &nbsp;&nbsp;<%= painel2[0][i]%>
                                                    </td>
                                                    <td><%= painel2[1][i]%></td>
                                                    <td><%= painel2[2][i]%></td>
                                                    <%
                                                        Teste te = new Teste();
                                                        //ConsumoDao cons = new ConsumoDao();
                                                        entrada2 = painel2[0][i];
                                                        String[] vetEntrada2 = entrada2.split("");
                                                        if (vetEntrada2.length == 2) {
                                                            entrada = "0";
                                                        }
                                                        if (vetEntrada2.length == 3) {
                                                            entrada2 = vetEntrada2[0] + "00";
                                                        }
                                                        if (vetEntrada2.length == 4) {
                                                            entrada2 = vetEntrada2[0] + vetEntrada2[1] + "00";
                                                        }

                                                        System.err.println("Valor Arredondado é: " + entrada2);

                                                        consumo2 = te.consumo(cons.getLitrosPorRpm(request.getParameter("nomeMotor"), entrada), painel1[1][i]);

                                                        consumoDouble2 = Double.valueOf(consumo2);
                                                        total2 = total2 + consumoDouble2;

                                                    %>
                                                    <td><%=consumo2 + " Litros"%></td>
                            </tr>

                            <%
                                    }
                                }
                                ;%> 
                            <td><h5><b>TOTAL</b></h5></td>
                            <td><h5><b><%=total2%></b></h5></td>


                            </tbody>
                            </table><br>
                            </div>
                            </div>
   

                    <span class="flow-text center">
                        <h4 class=" btn " id="btnMais" onclick="exibirDeslocamento()"><b>Relatorio de Deslocamento</b></h4>
                        <h4 class=" btn " id="btnMenos" onclick="ocultarDeslocamento()"><b>Relatorio de Deslocamento</b></h4>
                    </span>
                    <div class="card mb-3" id="idDeslocamento" style="display: none">
            <div class="table-responsive">
            <table class="table table-bordered" id="dataTable1" width="100%" cellspacing="0">
              <thead>
                <tr>
                    <th>PERIODO</th>
                    <th>DESLOCAMENTO</th>
                </tr>
              </thead>
                              
                                <%                 String dist = rpm.deslocamento(begin, finish, request.getParameter("mct"));

                                    if (dist == null) {
                                        dist = "0";
                                    }
                                    double deslocamet;
                                    
                                    
                                    String periodo = begin + " a " + finish;
                                    if (begin == null) {
                                        periodo = " ";
                                    }

                                    double d;
                                %>
                                <tbody>

                                    <tr>
                                        <%
                                            d = Double.valueOf(dist);
                                            DecimalFormat decimal = new DecimalFormat("0.##");
                                            dist = decimal.format(d);
                                        %>
                                        <td><%=inicio + " a " + fim%></td>
                                        <td><%=dist + " KM"%></td>
                                    </tr>
                                </tbody>
        </table>
        </div>
        </div>
      
                                 <span class="flow-text ">
                <h4 class=" btn " id="btnMaisRpm" onclick="exibirRpm()"><b>Detalhamento de RPM</b></h4>
                <h4 class=" btn " id="btnMenosRpm" onclick="ocultarRpm()"><b>Detalhamento de RPM</b></h4>
            </span>
            <div class="card mb-3 " id="divRpm">
           
        <div class="card-header">
          <i class="fa fa-table" ></i> Detalhamento de RM</div>
        <div>

            <table id="dataTable" width="100%" >
              <thead>
                <tr>
                    <th>MCT</th>
                    <th>Data</th>
                    <th>Referencia</th>
                    <th>RPM-1</th>
                    <th>RPM-2</th>
                </tr>
              </thead>
           
               <%
                    
                 String [][] painel;
                 painel=rpm.getRpm(begin,finish,request.getParameter("mct")).clone();
                 rpm.setNumRowRpm(begin,finish,request.getParameter("mct"));
                    String data ="";
                  for(int i = 0;i<rpm.getNumRowRpm(); i++){
                       data = format.DataFormat(painel[2][i]);
                  %> 
                  <tr>
                      <td><%= painel[1][i]%></td>
                      <td><%= data%></td>
                      <%
                      if(painel[3][i] == null){
                         painel[3][i] = "Não foram encontradas referencias proximas";
                      }
                      %>
                      <td><%= painel[3][i]%></td>
                      <td><%= painel[0][i]%></td>
                      <td><%= painel[4][i]%></td>
               
                </tr>
                
                <%
                }
                %>
              </tbody>
            </table>
          </div>   
              <div class="card-footer small text-muted">Victor@Santana </div>
                        </div>
                    </div>
              
           
        </div>
        
 
</div>
      
     
            <div class="row">
                <div class="container col s12 offset-s1">
           
 
                <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
                <script type="text/javascript">
                  google.charts.load('current', {'packages':['corechart']});
                  google.charts.setOnLoadCallback(drawChart);

                  function drawChart() {
                    var data = google.visualization.arrayToDataTable([
                      ['HORA', 'RPM'],
          
                    <%
                        String dataRpm1 = "";
                  for (int i = 0; i < 500; i++) {
                      if(painel[0][i] == null){
                          i=500;
                      }else{
                          dataRpm1=format.DataFormat(painel[2][i]);
                    %>
                        ['<%= dataRpm1%>',  <%= painel[0][i]%>],
                    <%}
}
                    %>
                
                    ]);

                    var options = {
                      title: 'DETALHE RPM 01',
                      curveType: 'function',
                      legend: { position: 'bottom' }
                    };

                    var chart = new google.visualization.LineChart(document.getElementById('curve_chart_r1'));

                    chart.draw(data, options);
                  }
                </script> 
          <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
                <script type="text/javascript">
                  google.charts.load('current', {'packages':['corechart']});
                  google.charts.setOnLoadCallback(drawChart);

                  function drawChart() {
                  
                    var data = google.visualization.arrayToDataTable([
                      ['HORA', 'RPM'],
          
                    <%
                        String dataRpm2 = "";
                  for (int i = 0; i < 500; i++) {
                      if(painel[0][i] == null){
                          i=500;
                      }else{
                          dataRpm2=format.DataFormat(painel[2][i]);
                    %>
                                                    
                        ['<%= dataRpm2%>',  <%= painel[4][i]%>],
                    <%}
}
                    %>
                
                    ]);

                    var options = {
                      title: 'DETALHE RPM 02',
                      curveType: 'function',
                      legend: { position: 'bottom' }
                    };

                    var chart = new google.visualization.LineChart(document.getElementById('curve_chart_r2'));

                    chart.draw(data, options);
                  }
                </script> 
                
              
        </div>
                   
            </div>
            </div>
            <script src='https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.2.61/jspdf.min.js'></script>
        <script  src="./script.js"></script>
            
        <!--Materialize JS -->
        <script src="js/materialize.js">
document.addEventListener('DOMContentLoaded', function() {
var elems = document.querySelectorAll('select');
var instances = M.FormSelect.init(elems, options);
});

// Or with jQuery
$(document).ready(function(){
$('.scrollspy').scrollSpy();
$('select').formSelect();
});
            </script>
         <!--Materialize INICIALIZA o menu para Mobile -->
      
         <script>
            $(".button-collapse").sideNav();
            
var table3 = document.getElementById("dataTable3"),rIndex;
                       
for(var i = 1; i < table3.rows.length; i++)
{
table3.rows[i].onclick = function()
{
rIndex = this.rowIndex;

                    
var rpm = document.getElementById("rpmConsumo").value = this.cells[0].innerHTML;

console.log(rpm);
//alert(rpm);
                    
};
}
            
        </script>
         <script type="text/javascript">
                                                  
                                                    
             function confirma (form){
             
              form.submit();
              exibir();
              return false;   
             }
             
          </script>
          
         
       <%
   con.close();
   stmt.close();
   %>
    </body>
</html>