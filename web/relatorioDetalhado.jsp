<%@page import="dao.ViagemDao"%>
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
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
<%
        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> "+conta);
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
%>                

    <script>
    function abreLink(url){
            //window.open('index.jsp');
              window.open(url,"janela1","width=700,height=500,scrollbars=NO");
    }
    </script>
    <script type="text/javascript">

        $(document).ready(function(){
            $('.dropdown-trigger').dropdown();
            $('select').formSelect();
            $('.collapsible').collapsible();
        });

        var visibilidade = true; //Variável que vai manipular o botão Exibir/ocultar

        function exibir() {
            document.getElementById("divCorpo").classList.toggle("oculto");
        }
        //Botões de exibir/ Ocultar
        function exibirDeslocamento() {
            document.getElementById("idDeslocamento").classList.toggle("oculto");
        }  
    
        //Botões Exibir / Ocultar Consumo
        function exibirConsumo2() {
            document.getElementById("divConsumo2").classList.toggle("oculto");
        }
        function exibirConsumo() {
            document.getElementById("divConsumo").classList.toggle("oculto");
        }
        //Botões Exibir / Ocultar RPM
        function exibirRpm() {
            document.getElementById("divRpm").classList.toggle("oculto");
        }

        function chama(link){
            window.location.href = link ;
        }  
        function printpage(){
            window.print()
        }

    </script>
    <script type="text/javascript">
        function printpage(){
            printClick();
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
        .oculto{
            display: none;
        }
    </style>
    </head>
    <!--
    <body class="background #eeeeee grey lighten-3">
    -->
    <body>
                <%
                    
                String idViagem = request.getParameter("idViagem");
                ViagemDao via = new ViagemDao();
                String[][] viagemRelatorio = via.pesquisarViagens(conta, con, stmt, idViagem);
                String viagemMct  = viagemRelatorio[7][0];
                String viagemNome  = viagemRelatorio[1][0].toUpperCase();
                String viagemInicio = viagemRelatorio[4][0];
                String viagemFim  = viagemRelatorio[6][0];
                String viagemNomeMotor = viagemRelatorio[9][0];
                String viagemNomeMotor2 = viagemRelatorio[13][0];
                String viagemNomeBarco = viagemRelatorio[11][0];
                String viagemNomeComandante = viagemRelatorio[12][0].toUpperCase();
                String parametro = "";
                String parametro2 = "";
                if (viagemMct == null) {
                        parametro = "none";
                    }else{
                    parametro="block";
                }
                if (viagemMct == null) {
                        parametro2 = "block";
                    }else{
                    parametro2="none";
                }
                
                %>
    
            
         <!--Materialize NavBar -->    

    <!-- INCLUDE DA NAVBAR -->
        <jsp:include page="navbar.jsp"></jsp:include>
   
            <div class=" container " id="divCampo"><br>

            </div>
        
        <div id="areaRelatorio" class=" container "><br>
            <div id="areaRelatorio2" class="row card">
                <div class="col s12">
                    <button id="btnPrint" class="btn medium right 455a64 blue-grey darken-2" name="action" onclick="printClick()" style="display: <%=parametro%>"><i class="material-icons">print</i>
</button> 
                            <div class="center"  id="divCorpo">
                                <span class="flow-text">
                                    <h4><b>Graficos de RPM</b></h4>
                                    <%
                                        
                                        Format format = new Format();
                                        String inicio = viagemInicio;
                                        System.out.println(">>>>>>>>>> "+inicio);
                                        String begin = inicio;
                                        
                                        String fim = viagemFim;
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
                                        String empurrador = viagemMct;
                                         
                                    %>
                                    
                                    <h5><b><%=viagemNome%></B></h5>
                                    <h5><%=inicio + " a " + fim%></h5>
                                </span>

                                <div class="black-text" style=" margin-left: 10%;">
                                      <div class="row col s12 " style="text-align: left;">
                                          <h5><b>Informações Gerais</b></h5>
                                            <b>Equipamento: </b><%=empurrador%><br>
                                            <b>Empurrador: </b><%=viagemNomeBarco%><br>
                                            <b>Comandante: </b><%=viagemNomeComandante%><br>
                                        </div>
                                    </div>
                                <div id="columnchart_values" style="width: 1000px; height:400px; margin-top: 140px;"></div>
                              
                               
                                <div  id="curve_chart_r1"  style="width: 1150px; height: 500px"></div>  
                                <div  id="curve_chart_r2"  style="width: 1150px; height: 500px"></div>

                                <div class="row">
                                    <span class="flow-text center col s12">
                                        <h4 class=" btn col s12" id="btnMaisConsumo" onclick="exibirConsumo()"><b>Relatorio de Consumo</b></h4>
                                    </span>
                                </div>
                                <div class="card mb-3 oculto" id="divConsumo" >
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
                                                Rpm rpm = new Rpm();
                                                String[][] painel1;
                                                painel1 = rpm.getPrincipalRpm(begin, finish, viagemMct, conta, con, stmt).clone();
                                             
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
                                                ConsumoDao cons = new ConsumoDao();
                                                consumo = te.consumo(cons.getLitrosPorRpm(conta, viagemNomeMotor, entrada), painel1[1][i]);

                                                consumoDouble = Double.valueOf(consumo);
                                                total = total + consumoDouble;
                                                //consumo = Math.round(Double.parseDouble(consumo));

                                            %>
                                            <td><%=Math.round(Double.parseDouble(consumo)) + " Litros"%></td>
                                            </tr>

                                            <%
                                                    }
                                                }
                                                ;%> 
                                            <td><h5><b>TOTAL</b></h5></td>
                                            <td><h5><b><%=Math.round(total)+ " Litros"%></b></h5></td>
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
                                

            
        <div class="row">
            <span class="flow-text center col s12">
                <h4 class=" btn col s12" id="btnMaisConsumo2" onclick="exibirConsumo2()"><b>Relatorio de Consumo 2</b></h4>
            </span>
        </div>
            <div class="card mb-3 oculto" id="divConsumo2">
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
                                                        painel2 = rpm.getPrincipalRpm2(conta,begin,finish,viagemMct).clone();
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
                                                        ConsumoDao cons = new ConsumoDao();
                                                        consumo2 = te.consumo(cons.getLitrosPorRpm(conta, viagemNomeMotor2, entrada), painel1[1][i]);

                                                        consumoDouble2 = Double.valueOf(consumo2);
                                                        total2 = total2 + consumoDouble2;

                                                    %>
                                                    <td><%=Math.round(Double.parseDouble(consumo2)) + " Litros"%></td>
                            </tr>

                            <%
                                    }
                                }
                                ;%> 
                            <td><h5><b>TOTAL</b></h5></td>
                            <td><h5><b><%=Math.round(total2)+ " Litros"%></b></h5></td>


                            </tbody>
                            </table><br>
                            </div>
                            </div>
                    <div class="row">
                        <span class="flow-text center col s12">
                            <h4 class=" btn col s12" id="btnMais" onclick="exibirDeslocamento()"><b>Relatorio de Deslocamento</b></h4>
                        </span>
                    </div>
                    <div class="card mb-3 oculto" id="idDeslocamento">
            <div class="table-responsive">
            <table class="table table-bordered" id="dataTable1" width="100%" cellspacing="0">
              <thead>
                <tr>
                    <th>PERIODO</th>
                    <th>DESLOCAMENTO</th>
                </tr>
              </thead>
                              
                                <%                 String dist = rpm.deslocamento(conta, begin, finish, viagemMct);

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
            <div class="row">
                <span class="flow-text col s12">
                    <h4 class=" btn col s12" id="btnMaisRpm" onclick="exibirRpm()"><b>Detalhamento de RPM</b></h4>
                </span>
            </div>
            <div class="card mb-3 oculto " id="divRpm">
           
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
                 painel=rpm.getRpm(conta, begin,finish,viagemMct).clone();
                 rpm.setNumRowRpm(conta,begin,finish,viagemMct);
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
        <script>
            function printClick() {  
                var w = window.open('', 'printform', 'width=300,height=400');  
                var html = $("#areaRelatorio2").html();
                $(w.document.body).html(html);
                w.print();
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