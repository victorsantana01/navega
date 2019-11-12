<%@page import="dao.ViagemDao"%>
<%@page import="dao.MacroDao"%>
<%@page import="dao.BarcoDao"%>
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
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        
        <!--Materialize CSS -->
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        
        <!-- DateRangePicker files INICIO -->
        <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
        <!-- DateRangePicker files FIM -->
        
        <!-- -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        
    </head>
    <body>
        <%
        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> "+conta);
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        Statement stmt1 = con.createStatement();
        Statement stmt2 = con.createStatement();
        %>
        <script>
            $(document).ready(function(){
                $('.dropdown-trigger').dropdown();
                $('select').formSelect();
                $('.collapsible').collapsible();
                $(".dropdown-trigger").dropdown('toggle');
                $('input[name="datetimes22"]').daterangepicker({
                    timePicker: true,
                    startDate: moment().startOf('hour'),
                    endDate: moment().startOf('hour').add(24, 'hour'),
                    "timePicker24Hour": true,
                    locale: {
                        format: 'DD/MM/YYYY hh:mm'
                    }
                });
            });
        </script>
        <!-- INCLUDE DA NAVBAR -->
        <jsp:include page="navbar.jsp"></jsp:include>  
        
        <div class="card">
            <div class="input-field col s6">
                <input type="text" name="datetimes22" />
                <label for="datetimes22" class="active">Datas e Horarios</label> 
            </div> 
            <div>
                <a class="btn" style="display: flex; justify-content: center" id="btn01" onclick="usaTabel()">click</a>
            </div>
            <div id="div01" class="container"></div>
        </div>
        

        
        <script>
            $(document).ready(function() {
                $('#example').DataTable( {
                    dom: 'Bfrtip',
                    pageLength: 15,
                    buttons: [
                        'copy', 'csv', 'excel', {
                extend: 'pdfHtml5',
                orientation: 'landscape',
                pageSize: 'LEGAL'
            }, 'print', 'pageLength'
                    ]
                } );
            } );
        </script>
        <script>
            function usaTabel(){
                    <%
                        MacroDao m = new MacroDao();
                        String[][] macros = m.listarMacros(conta, con, stmt, stmt1, stmt2);
                        String row = "";
                        String headRow = "<thead class='background #0277bd light-blue darken-1'>"
                                + "<tr><th>NUMERO</th><th>VERSÃO</th><th>DATA</th><th>MCT</th><th>TEXTO</th>"
                                + "<th>AÇÃO</th></tr></thead>";
                    for (int i = 0; i < 200; i++) {
                            if(macros[0][i] == null){
                                i=200;
                            }else{
                                row =row+"<tr><th>"+macros[1][i]+"</th><th>"+macros[2][i]+"</th><th>"+macros[3][i]+"</th><th>"+macros[4][i]+"</th><th>"+macros[5][i]+"</th></tr>";
                            }
                        }
                    String tabelas = "<table>"+headRow+""+row+"</table>";
                    
                    %>
                    $("#div01").html("<%=tabelas%>");
                    console.log("usuario: "+conta+" entrou");
            }
        </script>
        
        
        <!--Materialize JS -->
        <script src="js/materialize.js"></script>


    </body>
</html>
