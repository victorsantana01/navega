<%@page import="logic.Format"%>
<%@page import="dao.Rpm"%>  
<%@page import="dao.ConsumoDao"%>
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
        <script src="js/jquery.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
    </head>
    <%
   

  if( session.getAttribute("user") != null){
   System.out.println("Está logado o usuario: "+ session.getAttribute("user"));

  }else{
response.sendRedirect( "login.jsp" );
  }%>
    <body class="background #eeeeee grey lighten-3"> 
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
        <!-- FIM Botão de Add -->
         <!--Materialize NavBar -->    
       <div class="navbar-fixed z-depth-5">

         <nav class="#00838f cyan darken-3">
             
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
       </div>
        <!--INICIO do Corpo do App -->
          
      
       
        <br>
            <div class="row ">
                <div class="col s12">
                    <div class="card blue-grey darken-1 offset-s5">
                        <div class="card-content white-text ">
                            <span class="card-title">Motores Configurados</span>
                            <div class="row">
                               
                                    <div class="row ">
                                        <!---->
                                        <table class="highlight responsive-table">
                                            <thead>
                                                <tr>
                                                    <th>Motor</th>
                                                    <th>400</th>
                                                    <th>500</th>
                                                    <th>600</th>
                                                    <th>700</th>
                                                    <th>800</th>
                                                    <th>900</th>
                                                    <th>1000</th>
                                                    <th>1100</th>
                                                    <th>1200</th>
                                                    <th>1300</th>
                                                    <th>1400</th>
                                                    <th>1500</th>
                                                    <th>1600</th>
                                                    <th>1700</th>
                                                    <th>1800</th>
                                                    <th>1900</th>
                                                    <th>2000</th>
                                                    <th>2100</th>
                                                    <th>2200</th>
                                                    <th>2300</th>
                                                    <th>2400</th>
                                                    <th>2500</th>
                                                    <th>2600</th>
                                                    <th>2700</th>
                                                    <th>2800</th>
                                                    <th>2900</th>
                                                    <th>3000</th>

                                                </tr>
                                            </thead>


                                            <%
                                                ConsumoDao cons = new ConsumoDao();
                                                String[][] dados = cons.getTabelaConsumo().clone();

                                                for (int i = 0; i < 50; i++) {

                                                    if (cons.getTabelaConsumo()[0][i] == null) {
                                                        i = 50;

                                                    } else {


                                            %>
                                            <tr>
                                                <th><%=dados[0][i]%></th>
                                                <th><%=dados[28][i]%></th>
                                                <th><%=dados[1][i]%></th>
                                                <th><%=dados[2][i]%></th>
                                                <th><%=dados[3][i]%></th>
                                                <th><%=dados[4][i]%></th>
                                                <th><%=dados[5][i]%></th>
                                                <th><%=dados[6][i]%></th>
                                                <th><%=dados[7][i]%></th>
                                                <th><%=dados[8][i]%></th>
                                                <th><%=dados[9][i]%></th>
                                                <th><%=dados[10][i]%></th>
                                                <th><%=dados[11][i]%></th>
                                                <th><%=dados[12][i]%></th>
                                                <th><%=dados[13][i]%></th>
                                                <th><%=dados[14][i]%></th>
                                                <th><%=dados[15][i]%></th>
                                                <th><%=dados[16][i]%></th>
                                                <th><%=dados[17][i]%></th>
                                                <th><%=dados[18][i]%></th>
                                                <th><%=dados[19][i]%></th>
                                                <th><%=dados[20][i]%></th>
                                                <th><%=dados[21][i]%></th>
                                                <th><%=dados[22][i]%></th>
                                                <th><%=dados[23][i]%></th>
                                                <th><%=dados[24][i]%></th>
                                                <th><%=dados[25][i]%></th>
                                                <th><%=dados[26][i]%></th>

                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>


                                        </table>

                                    </div>


                              
                            </div>

                        </div>


                    </div>

                </div>
            </div>
       
    </div>
   
    <script type="text/javascript">
             function confirma (form){
              form.submit();
              return false;   
             }
          </script>
   
          <!--FIM do Corpo do App -->
        
        <!--Materialize JS -->
        <script src="js/materialize.js"></script>
         <!--Materialize INICIALIZA o menu para Mobile -->
       
        
       
    </body>
</html>