<%@page import="dao.MacroDao"%>
<%@page import="fabricaConexao.ConexaoMySQL"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="dao.BarcoDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>SB Admin - Start Bootstrap Template</title>
        <!--Materialize Icones -->  
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Materialize CSS -->
        <link rel="stylesheet" type="text/css" href="css/materialize.css">
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <!--FIM Cabeçalho Para Materialize-->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        
        <!-- css datatables -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/jq-3.3.1/dt-1.10.18/datatables.min.css"/>
 
        <script type="text/javascript" src="https://cdn.datatables.net/v/dt/jq-3.3.1/dt-1.10.18/datatables.min.js"></script>
        <!-- javascript datatables --><script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>

        <script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/dataTables.buttons.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.flash.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.html5.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.print.min.js"></script>
        <!-- Materializecss -->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </head>

    <body class="bg-dark">
        <div class="container">
            <div class="card card-login mx-auto mt-5">
                <div class="card-header">Consumo</div>
                <div class="card-body">
                    <div class="text-center mt-4 mb-5">
                        <h4>Feito!</h4>
                        <p>Barco salvo com sucesso!</p>
                    </div>

                    <%
                    String conta = session.getAttribute("conta").toString();
                    System.out.println("Numero da conta é >>>>> "+conta);
                    Connection con = ConexaoMySQL.getConexaoMySQL();
                    Statement stmt = con.createStatement();
                    Statement stmt1 = con.createStatement();
                    Statement stmt2 = con.createStatement();
                    String macroEnviada = request.getParameter("macro");
                    

                    System.out.println("MACRO ESCOLHIDA: "+macroEnviada);
                    MacroDao m = new MacroDao();
                    String[][] macros = m.getMacroText(conta, con, stmt,macroEnviada);
                    String headRow = "";
                    String footRow = "";
                    String row = "";
                    macroEnviada = request.getParameter("macro");
                    String[][] lista = m.getMacroDef(conta, con, stmt, macroEnviada);
                    for (int i = 0; i < 10; i++) {
                        if(lista[i][0] == null){
                            i=50;
                        }else{
                            headRow = headRow+" <th class='strong'>"+lista[i][0]+"</th>";
                            footRow = footRow+" <th class='strong'>"+lista[i][0]+"</th>";
                        }
                    }
                    for(int i=0; i< 5000; i++){
                        if(macros[0][i] == null){
                            i=5000;
                        }else{
                            row = row+"<tr>";
                            for (int j = 0; j < 5000; j++) {
                                
                                if(macros[j][i] == null){
                                    j=5000;
                                }else{
                                    String mm = macros[j][i];
                                    if(lista[j][1] != null){
                                        if(lista[j][1].equals("2") ){
                                            mm = mm.substring(0,2)+"/"+mm.substring(2,4);
                                        }
                                        if(lista[j][1].equals("3")){
                                            mm = mm.substring(0,2)+":"+mm.substring(2,4);
                                        }
                                    }
                                    row = row+"<td>"+mm+"</td>";
                                }
                            }
                            row = row+"</tr>";
                        }
                    }
                    String tabelas = "<table id='example' class='display nowrap striped' style='width:100%'>"
                            + "<thead class='background #0277bd light-blue darken-1'>"
                            + ""+headRow+"</thead><tbody>"+row+"</tbody><tfoot>"+footRow+"</tfoot></table>";
                %>
                <script>
                    $(document).ready(function(){
                        $("#div01").html("<%=tabelas%>");
                    }
                </script>

                    <a class="btn btn-primary btn-block" href="tables.jsp">Reset Password</a>
                    <a class="btn btn-primary btn-block" href="tables.jsp">Reset Password</a>

                    <div class="text-center" id="div01" name="div01" >

                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JavaScript-->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- Core plugin JavaScript-->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    </body>

</html>
