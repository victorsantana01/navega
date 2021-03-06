<%@page import="logic.Format"%>
<%@page import="dao.ViagemDao"%>
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
            body { height: 100%; margin: 0; padding: 0 }
            .wrap { max-width: 110em; min-height: 90em; height:100%; width:100%; margin: 0 auto; padding-top: 2.5%;}
            #map-canvas { height: 100%; }
        </style>
        <!--Materialize Icones -->  
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Materialize CSS -->
        <link rel="stylesheet" type="text/css" href="css/materialize.css">
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <!--FIM Cabeçalho Para Materialize-->
        <link rel="stylesheet" type="text/css" href="css/materialize.css">
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        
        
        <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        

    </head>
    
    <body>
        <%
            /* Inicio de Sessão */
            String conta = session.getAttribute("conta").toString();
            System.out.println("Numero da conta é >>>>> "+conta);
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
        %>
        <script type="text/javascript">
            $(function() {
                $('.datepicker').datepicker({
                    i18n: {
                        months: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
                        monthsShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
                        weekdays: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sabádo'],
                        weekdaysShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
                        weekdaysAbbrev: ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'],
                        today: 'Hoje',
                        clear: 'Limpar',
                        cancel: 'Sair',
                        done: 'Confirmar',
                        labelMonthNext: 'Próximo mês',
                        labelMonthPrev: 'Mês anterior',
                        labelMonthSelect: 'Selecione um mês',
                        labelYearSelect: 'Selecione um ano',
                        selectMonths: true,
                        selectYears: 15,
                    },
                    format: 'dd/mm/yyyy',
                    container: 'body',
                    showClearBtn: true,
                });
                function ajustaData(xx){
                    var b = xx.split("/")[2]+"/"+xx.split("/")[1]+"/"+xx.split("/")[0];
                    b = new Date(b);
                    return b;
                }
                function ajustaData2(xx){
                    var b = xx.split("/")[1]+"/"+xx.split("/")[0]+"/"+xx.split("/")[2];
                    b = new Date(b);
                    return b;
                }
                $('.datepicker').change(function(){
                    let viagens = $('.collapsible-header');
                    for (var i = 0; i < viagens.length; i++) {
                        //console.log(viagens[i].attributes[1].value);
                        let vdata = new Date(ajustaData2(viagens[i].attributes[1].value));
                        let inicio = new Date(ajustaData2($(".datepicker")[0].value)); 
                        let fim = new Date(ajustaData2($(".datepicker")[1].value));
                        if(inicio == "Invalid Date" && fim == "Invalid Date"){
                            viagens[i].style.display = "block";
                        }else if(inicio != "Invalid Date" && fim != "Invalid Date"){
                            if(inicio <= vdata && vdata <= fim){
                                viagens[i].style.display = "block";
                            }else{
                                viagens[i].style.display = "none";
                            }                            
                        }else{
                            if(inicio == "Invalid Date"){
                                if(inicio == "Invalid Date" && vdata <= fim){
                                    viagens[i].style.display = "block";
                                }else{
                                    viagens[i].style.display = "none";
                                }                                
                            }
                            if(fim == "Invalid Date"){
                                if(inicio <= vdata && fim == "Invalid Date"){
                                    viagens[i].style.display = "block";
                                }else{
                                    viagens[i].style.display = "none";
                                }
                            }
                        }
                    }
                });
            });
        </script>
        
        <!-- INCLUDE DA NAVBAR -->
        <jsp:include page="navbar.jsp"></jsp:include>

        <!-- INICIO Botão de Add -->
        <div class="container" style="padding-top:20px">
            <div class="row"><!--INCIO DO CORPO DA PAGINA-->
            <% ViagemDao viagem = new ViagemDao(); 
            Format format = new Format();
            %>
            <div class="card large col s4" style="overflow-y: auto">
                <div class="card-title center" Style="color:gold"><i class="material-icons">schedule</i><strong> Viagens Agendadas</strong></div>
                <ul class="collapsible">
                    <%
                        String[][] viagensAgendadas = viagem.pesquisarViagensPorStatus(conta, con, stmt,"0");
                        for(int i=0;i < 100; i++){
                            if(viagensAgendadas[0][i] == null){
                                i = 200;
                            }else{
                                String viagemDataOrigemFormatada = format.DataFormat(viagensAgendadas[4][i].split(" ")[0]);
                                String viagemDataDestinoFormatada = format.DataFormat(viagensAgendadas[6][i].split(" ")[0]);
                                String viagemDataCriacaoFormatada = format.DataFormat(viagensAgendadas[11][i].split(" ")[0]);
                                %>
                    <li>
                        <div class="collapsible-header"><i class="material-icons">filter_drama</i><span><%=viagensAgendadas[1][i].toUpperCase()%></span><span class="badge"><%=viagemDataCriacaoFormatada%></span></div>
                                <div class="collapsible-body">
                                    <b>Nome da Viagem: </b><%=viagensAgendadas[1][i]%><br>
                                    <b>Empurrador: </b><%=viagensAgendadas[7][i]%><br>
                                    <b>MCT: </b><%=viagensAgendadas[10][i]%><br>
                                    <b>Comandante: </b><%=viagensAgendadas[8][i]%><br>
                                    <b>Origem:</b> <%=viagensAgendadas[3][i]%><b>  Data: </b><%=viagemDataOrigemFormatada%> <br>
                                    <b>Destino:</b> <%=viagensAgendadas[5][i]%><b>  Data: </b><%=viagemDataDestinoFormatada%> <br>
                                    
                                    <div class="row" style="margin:0px !important">
                                        <div class="col s12">
                                            <h5 class="center col s12"><b>Relatorio</b></h5><br>
                                            <a class="btn waves-effect waves-light center col s6" href="relatorioConsolidado.jsp?idViagem=<%=viagensAgendadas[0][i]%>">Consolidado</a><br>
                                            <a class="btn waves-effect waves-light center col s6" href="relatorioDetalhado.jsp?idViagem=<%=viagensAgendadas[0][i]%>">Detalhado</a>
                                        </div>
                                    </div>
                                            
                                </div>
                                <%
                            }
                        }
                        
                    %>
                    
                    
                </li>
                </ul>
            </div>
            <div class="card large col s4" style="overflow-y: auto">
                <div class="card-title center" style="color:blue"><i class="material-icons">directions_boat</i><strong> Viagens Em andamento</strong></div>
                <ul class="collapsible">
                <%
                        String[][] viagensEmAndamento = viagem.pesquisarViagensPorStatus(conta, con, stmt, "1");
                        for(int i=0;i < 100; i++){
                            if(viagensEmAndamento[0][i] == null){
                                i = 200;
                            }else{
                                String viagemDataOrigemFormatada = format.DataFormat(viagensEmAndamento[4][i].split(" ")[0]);
                                String viagemDataDestinoFormatada = format.DataFormat(viagensEmAndamento[6][i].split(" ")[0]);
                                String viagemDataCriacaoFormatada = format.DataFormat(viagensEmAndamento[11][i].split(" ")[0]);
                                %>
                    <li>
                    
                        <div class="collapsible-header"><i class="material-icons">directions_boat</i><span><%=viagensEmAndamento[1][i].toUpperCase()%></span><span class="badge"><%=viagemDataCriacaoFormatada%></span></div>
                                <div class="collapsible-body">
                                    <b>Nome da Viagem: </b><%=viagensEmAndamento[1][i]%><br>
                                    <b>Empurrador: </b><%=viagensEmAndamento[7][i]%><br>
                                    <b>MCT: </b><%=viagensEmAndamento[10][i]%><br>
                                    <b>Comandante: </b><%=viagensEmAndamento[8][i]%><br>
                                    <b>Origem:</b> <%=viagensEmAndamento[3][i]%><b>  Data: </b><%=viagemDataOrigemFormatada%> <br>
                                    <b>Destino:</b> <%=viagensEmAndamento[5][i]%><b>  Data: </b><%=viagemDataDestinoFormatada%> <br>
                                    <div class="row" style="margin:0px !important">
                                        <div class="col s12">
                                            <h5 class="center col s12"><b>Relatorio</b></h5>
                                            <a class="btn waves-effect waves-light center col s6" href="relatorioConsolidado.jsp?idViagem=<%=viagensEmAndamento[0][i]%>">Consolidado</a>
                                            <a class="btn waves-effect waves-light center col s6" href="relatorioDetalhado.jsp?idViagem=<%=viagensEmAndamento[0][i]%>">Detalhado</a>
                                        </div>
                                    </div>
                                      
                                </div>
                                <%
                            }
                        }
                        
                    %>
                    
                    
                </li>
            </ul>
            </div>  
            <div class="card large col s4" style="overflow-y: auto">
                <div class="card-title center"  style="color:#00FF00">
                    <i class="material-icons">check</i><strong> Viagens Finalizadas</strong>
                </div>
                <div class="input-field col s12">
                    <div class="input-field col s6">
                        <input name="datepicker" type="text" class="datepicker">
                        <label for="datepicker" class="active">Inicio</label>
                    </div>
                    <div class="input-field col s6">
                        <input name="datepicker" type="text" class="datepicker">
                        <label for="datepicker" class="active">Final</label>
                    </div>
                </div>
                <ul class="collapsible">
                    <%
                        String[][] viagensFinalizadas = viagem.pesquisarViagensPorStatus(conta, con, stmt, "2");
                        for(int i=0;i < 100; i++){
                            if(viagensFinalizadas[0][i] == null){
                                i = 200;
                            }else{
                                String viagemDataOrigemFormatada = format.DataFormat(viagensFinalizadas[4][i].split(" ")[0]);
                                String viagemDataDestinoFormatada = format.DataFormat(viagensFinalizadas[6][i].split(" ")[0]);
                                String viagemDataCriacaoFormatada = format.DataFormat(viagensFinalizadas[11][i].split(" ")[0]);
                                %>
                    <li>
                    <li>
                    
                        <div class="collapsible-header" inicio="<%=viagemDataOrigemFormatada%>" fim="<%=viagemDataDestinoFormatada%>">
                            <i class="material-icons">filter_drama</i><span><%=viagensFinalizadas[1][i].toUpperCase()%></span><span class="badge"><%=viagemDataOrigemFormatada%></span></div>
                                <div class="collapsible-body">
                                    <b>Nome da Viagem: </b><%=viagensFinalizadas[1][i]%><br>
                                    <b>Empurrador: </b><%=viagensFinalizadas[7][i]%><br>
                                    <b>MCT: </b><%=viagensFinalizadas[10][i]%><br>
                                    <b>Comandante: </b><%=viagensFinalizadas[8][i]%><br>
                                    <b>Origem:</b> <%=viagensFinalizadas[3][i]%><b>  Data: </b><%=viagemDataOrigemFormatada%> <br>
                                    <b>Destino:</b> <%=viagensFinalizadas[5][i]%><b>  Data: </b><%=viagemDataDestinoFormatada%> <br>
                                    <div class="row" style="margin:0px !important">
                                        <div class="col s12">
                                            <h5 class="center col s12"><b>Relatorio</b></h5>
                                            <a class="btn waves-effect waves-light center col s6" href="relatorioConsolidado.jsp?idViagem=<%=viagensFinalizadas[0][i]%>">Consolidado</a>
                                            <a class="btn waves-effect waves-light center col s6" href="relatorioDetalhado.jsp?idViagem=<%=viagensFinalizadas[0][i]%>">Detalhado</a>
                                        </div>
                                    </div>
                                </div>
                                <%
                            }
                        }
                        
                    %>
                    
                    
                </li>
            </ul>
            </div>              
        </div>
      </div>
    </body>
</html>
