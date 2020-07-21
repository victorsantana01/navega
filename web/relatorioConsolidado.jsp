<%@page import="dao.ViagemDao"%>
<%@page import="java.sql.Statement"%>
<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page import="java.sql.Connection"%>
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
      body { height: 80%; margin: 0; padding: 0 }
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
        
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

<%

        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> "+conta);
        Connection con = ConexaoMySQL.getConexaoMySQL();
         Statement stmt = con.createStatement();
         Statement stmt2 = con.createStatement();
         Statement stmt3 = con.createStatement();
%>                
    <script type="text/javascript">
        function printpage(){
            document.getElementById("btnPrint").classList.toggle("oculto");
            printClick();
            document.getElementById("btnPrint").classList.toggle("oculto");
        }
    </script>
    <style type="text/css">
        .oculto{
            display: none;
        }
        .printSize{
            width:500px;
            height:30px;
        }
        .viewSize{
            width: 1000px; 
            height: 300px;
        }
    </style>
    
    </head>
    <body class="background white">
    
        <script>
            $(document).ready(function(){
                $('.dropdown-trigger').dropdown();
                $('select').formSelect();
                $('.collapsible').collapsible();
            });
        </script>

        <!-- INCLUDE DA NAVBAR -->
        <jsp:include page="navbar.jsp"></jsp:include>
   
         
        <!--INICIO do Corpo do App -->


              <!-- ============================================================ -->   
              <%
              //PESQUISA VIAGENS APARTIR DO ID ESCOLHIDO NO SELECT
               
               String idViagem = request.getParameter("idViagem");
               ViagemDao via = new ViagemDao();
               String[][] dadosViagem = via.pesquisarViagens(conta, con, stmt, idViagem).clone();
               String dadosInicioViagem = dadosViagem[4][0];
               String dadosFimViagem = dadosViagem[6][0];
               System.out.println("DADOSINICIOVIAGEM ------- "+dadosViagem[4][0]);
               System.out.println("DADOSFIMVIAGEM ------- "+dadosViagem[6][0]);
               String dadosMctViagem = dadosViagem[7][0];
               String dadosMotorViagem = dadosViagem[9][0];
               String dadosMotorViagem2 = dadosViagem[13][0];
               String dadosBarco = dadosViagem[11][0];
               String dadosComandante = dadosViagem[12][0];
               
               
               %>        

        
        
        <div id="areaRelatorio" class=" container "><br>
            <div id="areaRelatorio2" class="card row ">
                <div class="col s12">
                            <div class=""  id="divCorpo" style="display: block">
                                    <%
                                        
                                        Format format = new Format();
                                        String inicio = dadosInicioViagem;
                                        System.out.println("CAMPO INICIO - FORMULARIO - :"+inicio);
                                        String begin = inicio;
                                        
                                        String fim = dadosFimViagem;
                                        System.out.println("CAMPO FIM - FORMULARIO - :"+fim);
                                        String finish = fim;
                                        
                                       // Se for null ou vazio usa a data atual para consulta.
                                        if (inicio == null || inicio == "") {
                                            inicio = format.hoje();
                                        }
                                        inicio = format.DiaFormat(inicio);
                                        System.out.println("CAMPO INICIO - PÓS FORMAT - :"+inicio);
                                        
                                        if (fim == null || fim == "") {
                                            fim = format.hoje();
                                        }
                                        fim = format.DiaFormat(fim);
                                        System.out.println("CAMPO FIM - PÓS FORMAT - :"+fim);
                                        
                                        String empurrador = dadosMctViagem;
                                         
                                    %>
                                    

                                <div class="" id="columnchart_values " style="width: 1000px; height:400px;display: none"></div>
                               

                                            <%
                                                Rpm rpm = new Rpm();
                                                String[][] painel1;
                                                //painel1 = rpm.getPrincipalRpm(dadosInicioViagem, dadosFimViagem, request.getParameter("mct"),con,stmt).clone();
                                                painel1 = rpm.getPrincipalRpm(dadosInicioViagem, dadosFimViagem, dadosMctViagem,conta,con,stmt).clone();
                                             
                                                String consumo = "";
                                                String latLon = "";
                                                String entrada = null;
                                                double total = 0.0;
                                                double consumoDouble;
                                                int  minuto = 0;
                                                int vetPosition = 0;
                                                int maiorMinuto =0;
                                                
                                                System.out.println("Valida1 >>>>>>>>>>>>>>>>>> "+painel1[4][0]);
                                                for (int i = 0; i < 2000; i++) {
                                                    if (painel1[0][i] == null || painel1[0][i] == "0") {
                                                        i = 2000;
                                                    } else {
                                                     
                                                         
                                            %> 


                                                
                                            <!--<input style="display: none" name="rpmConsumo" value=" <%= painel1[0][i]%>">-->
                                            
                                            
                                            <%
                                                Teste te = new Teste();
                                                ConsumoDao cons = new ConsumoDao();
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
                                                      minuto = Integer.parseInt(painel1[1][i]);
                                                       if (minuto >maiorMinuto) {
                                                           maiorMinuto = minuto;
                                                            vetPosition = i;   
                                                           }                                                
                                                consumo = te.consumo(cons.getLitrosPorRpm(conta, dadosMotorViagem, entrada), painel1[1][i]);

                                                consumoDouble = Double.valueOf(consumo);
                                                total = total + consumoDouble;

                                           
                                                    }
                                                }
                                                
                                                %> 
                                            
                                            
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

                                                    <% // Logica de Deslocamento
                                                        String dist = rpm.deslocamento(conta, dadosInicioViagem, dadosFimViagem, dadosMctViagem);
                                                        if (dist == null) {
                                                            dist = "0";
                                                        }
                                                        
                                                        double d;
                                                    %>

                                                    <%
                                                        d = Double.valueOf(dist);
                                                        DecimalFormat decimal = new DecimalFormat("0.##");
                                                        dist = decimal.format(d);
                                                    %>
                                                    <div class="container">

                                                        <div class="row col s8">
                                                                      
                                                            <h4>NAVEGA GESTOR</h4>                
                                                            <h5>RELATORIO CONSOLIDADO</h5> 
                                                           
                                                        </div>
                                                        
                                                    </div>
                                                     <span id="divbtn" class="flow-text center-align">
                                                         <button id="btnPrint" class=" btn medium right 455a64 blue-grey darken-2" name="action" onclick="printpage()"><i class="material-icons">print</i>
                                                            </button>
                                                    </span>
    
                                                    <%
                                                         String kmString = "";
                                                        String[][] painel2;
                                                        painel2 = rpm.getPrincipalRpm2(conta,dadosInicioViagem,dadosFimViagem,dadosMctViagem).clone();
                                                       System.out.println("Valida2 >>>>>>>> "+painel2[0][0]);
                                                        String consumo2 = "";
                                                       
                                                        String entrada2 = null;
                                                        double total2 = 0.0;
                                                        double consumoDouble2;
                                                             int minuto2 = 0;
                                                             int vetPosition2 = 0;
                                                             int maiorMinuto2 = 0;
                                                        for (int i = 0; i < 2000; i++) {
                                                            if (painel2[0][i] == null || painel2[0][i] == "0") {
                                                                i = 2000;
                                                            } else {
                                                    %> 

                                                    <input style="display: none" name="rpmConsumo" value=" <%= painel2[0][i]%>">

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
                                                                 minuto2 = Integer.parseInt(painel2[1][i]);
                                                       if (minuto2 >maiorMinuto2) {
                                                           maiorMinuto2 = minuto2;
                                                            vetPosition2 = i;   
                                                           }
                                                                System.err.println("Valor Arredondado é: " + entrada2);
                                                                ConsumoDao cons = new ConsumoDao();
                                                                consumo2 = te.consumo(cons.getLitrosPorRpm(conta, dadosMotorViagem2, entrada), painel1[1][i]);

                                                                consumoDouble2 = Double.valueOf(consumo2);
                                                                total2 = total2 + consumoDouble2;
                                                            }
                                                         
                                                        }
                                                        String[][] painel;
                                                        painel = rpm.getRpm(conta, dadosInicioViagem, dadosFimViagem, dadosMctViagem).clone();
                                                        int cont = Integer.parseUnsignedInt(painel[5][0]);
                                                        String mediaRpm = "";
                                                        String mediaRpm2 = "";
                                                        String maiorRpm1="";    
                                                        String maiorRpm2="";    
                                                        String menorRpm1="";    
                                                        String menorRpm2="";    
                                                        if (cont > 0) {
                                                            int r1 = 0;
                                                            int r2 = 0;
                                                            int maior1 = 0;
                                                            int maior2 = 0;
                                                            int menor1 = 100000;
                                                            int menor2 = 100000;
                                                            int soma = 0;
                                                            int media = 0;
                                                            int soma2 = 0;
                                                            int media2 = 0;
                                                            double kmMaior= 0.0;
                                                            double km= 0.0;
                                                           
                                                            System.out.println("Hà registro!!");
                                                            for (int i = 0; i < cont; i++) {
                                                               
                                                                r1 = Integer.parseInt(painel[0][i]);
                                                                r2 = Integer.parseInt(painel[4][i]);
                                                                
                                                                km = Double.valueOf(painel[6][i]);

                                                                System.out.println(km);
                                                                
                                                                soma = soma + r1;
                                                                soma2 = soma2 + r2;
                                                                
                                                                if (km > kmMaior) {
                                                                    kmMaior = km;
                                                                }
                                                                if (r1 > maior1) {
                                                                    maior1 = r1;
                                                                }
                                                                if (r2 > maior2) {
                                                                    maior2 = r2;
                                                                }
                                                                if (r1 < menor1) {
                                                                    menor1 = r1;
                                                                }
                                                                if (r2 < menor2) {
                                                                    menor2 = r2;
                                                                }
                                                            }
                                                             media = soma/cont;   
                                                             media2 = soma2/cont; 
                                                             kmString = String.valueOf(kmMaior);
                                                             System.out.println("Maior KM é ---> "+kmString);
                                                             mediaRpm = String.valueOf(media);
                                                             mediaRpm2 = String.valueOf(media2);
                                                             maiorRpm1 = String.valueOf(maior1);
                                                             maiorRpm2 = String.valueOf(maior2);
                                                             menorRpm1 = String.valueOf(menor1);
                                                             menorRpm2 = String.valueOf(menor2);
                                                             kmString = String.valueOf(kmMaior);
                                                        } else {
                                                            System.out.println("Sem registro!!");
                                                        }
                                                    %>

                                      <div class="container black-text">
                                      <div class="row col s12 ">
                                          <div class="row col s12 background blue">              
                                            </div>
                                          <%
                                          System.out.println(kmString);
                                          %>
                                          <h5><b>Informações Gerais</b></h5>
                                        <b class="center">Equipamento: </b><%=empurrador%><br> 
                                        <b class="center">Empurrador: </b><%=dadosBarco%><br> 
                                        <b class="center">Comandante: </b><%=dadosComandante%><br> 
                                        <b class="center">Deslocamento Total: </b><%=dist%> KM.<br> 
                                        <b class="center">Periodo do filtro: </b><%=inicio + " a " + fim%><br>
                                         <b class=" right-align">Qtd Registros: </b><%=cont%><br>
                                        <b class="center pull-s2">Velocidade Max: </b><%=kmString%>Km/h<br>
                                        
                                      </div>
                                      </div>
                                        <div class="container black-text">
                                            <div class="row col s5 ">
                                                <h5><b>Motor 01</b></h5>
                                                <b class="right-aligned">Consumo Total: </b><%=(int)Math.round(total)%> Lts.<br>    
                                                <b class=" ">Maior RPM: </b><%=maiorRpm1%><br>
                                                <b class=" pull-s2">Menor RPM: </b><%=menorRpm1%><br>
                                                <b class=" pull-s2">Media de RPM: </b><%=mediaRpm%><br>
                                                <b class=" pull-s2">RPM Predomitante: </b><%=painel1[0][vetPosition]%> <b>Num.Reg:</b><%=painel1[2][vetPosition]%><br>
                                                <b class=" pull-s2">Tempo de RPM predomintante: </b><%=painel1[1][vetPosition]%><br>
                                            </div>

                                            <div class="row col s5 push-s2">
                                                <h5><b class="">Motor 02</b></h5>
                                                <b class="">Consumo Total: </b><%=(int)Math.round(total2)%> Lts.<br>    
                                                <b class="center pull-s2">Maior RPM: </b><%=maiorRpm2%><br>
                                                <b class="center pull-s2">Menor RPM: </b><%=menorRpm2%><br>
                                                <b class="center pull-s2">Media de RPM: </b><%=mediaRpm2%><br>
                                                <b class=" pull-s2">RPM Predomitante: </b><%=painel2[0][vetPosition2]%> <b>Num.Reg:</b><%=painel2[2][vetPosition2]%><br>
                                                <b class="center pull-s2">Tempo RPM predomintante: </b><%=painel2[1][vetPosition2]%><br>
                                            </div>
                                            <div class="row col s12 background blue">

                                            </div>

                                            <div class="row col s12 right viewSize" id="curve_chart_r1"  ></div>  
                                            <div class="row col s12 right viewSize" id="curve_chart_r2"  ></div>         

                                            <br><br><br> 
                                        </div>
                                            </div>
                </div>
            </div>
        </div>
                                    
                                                
                                                    
                                                        
                                                            
                                                                <script type="text/javascript">
                                                                  google.charts.load('current', {'packages':['corechart']});
                                                                  google.charts.setOnLoadCallback(drawChart);

                                                                  function drawChart() {
                                                                    var data = google.visualization.arrayToDataTable([
                                                                      ['HORA', 'RPM'],
          
                                                                    <%
                                                                        String dataRpm1 = "";
                                                                        for (int i = 0; i < 500; i++) {
                                                                            if (painel[0][i] == null) {
                                                                                i = 500;
                                                                            } else {
                                                                                dataRpm1 = format.DataFormat(painel[2][i]);
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

                                                            <script type="text/javascript">
                                                                  google.charts.load('current', {'packages':['corechart']});
                                                                  google.charts.setOnLoadCallback(drawChart);
                                                                  function drawChart() {
                                                                    var data = google.visualization.arrayToDataTable([
                                                                      ['HORA', 'RPM'],
                                                                    <%
                                                                        String dataRpm2 = "";
                                                                        for (int i = 0; i < 500; i++) {
                                                                            if (painel[0][i] == null) {
                                                                                i = 500;
                                                                            } else {
                                                                                dataRpm2 = format.DataFormat(painel[2][i]);
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
                                                            
              
                                                           
                                                           
           
       

        <!--Materialize JS -->
        <script src="js/materialize.js">
                document.addEventListener('DOMContentLoaded', function() {
                var elems = document.querySelectorAll('select');
                var instances = M.FormSelect.init(elems, options);
                });

        </script>
        <script>
            function printClick() {  
                var w = window.open('', 'printform', 'width=300,height=400');
                document.getElementById("divbtn")
                var html = $("#areaRelatorio2").html();
                document.getElementById("btnPrint").classList.toggle("oculto");                 
                $(w.document.body).html(html);
                w.print();
            }
        </script>
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
