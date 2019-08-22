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
        <script src="js/jquery.js"></script>
        
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>

    </head>
    <body class="background #eeeeee grey lighten-3">
        <%
        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> "+conta);
        %>
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
        
        <script type="text/javascript">
 var map;
 var centerPos = new google.maps.LatLng( -2.058526, -54.620951);
 var zoomLevel = 6;
      
function initialize() {
   var mapOptions = {
           
     center: centerPos,
     zoom: zoomLevel
};

   map = new google.maps.Map( document.getElementById("map-canvas"), mapOptions );
        
    
var image ={  url:'images/barco4.png',
   scaledSize: new google.maps.Size(120, 120),
   origin: new google.maps.Point(0, 0),
   anchor: new google.maps.Point(32,65),
   labelOrigin:  new google.maps.Point(100,20),
 };
    
        
<%Rpm re = new Rpm();%>
<%
    String[][] painel = re.painelAtualizado(conta).clone();
        for (int i = 0; i < 100; i++) {
            if (painel[1][i] == null) {
                i = 100;
            } else {
%>
marker = new google.maps.Marker({
position: new google.maps.LatLng(<%=painel[8][i]%>, <%=painel[9][i]%>),
<%
Format ultimaHora = new Format();
String hora ="";
hora = ultimaHora.DataFormat(painel[2][i]);
%>
title: 'Empurrador: <%=painel[0][i]%>'+'  \n'+'Mct: <%=painel[1][i]%>\n'+'Hora: <%=hora%>',
map: map,
icon: image,  
animation: google.maps.Animation.DROP 
});

// Editable string with html markup for tooltip content
var contentString = '<div id="content">'+
 '<div id="siteNotice">'+
 '<b><b><%=painel[0][i]%></h5></b>'+
 '</div>'+
 '<div id="mapContent">'+
 '<h6><p>RPM1: <%=painel[5][i]%></h6>'+
 '<h6>RPM2: <%=painel[6][i]%><br><br>Posição:<%=painel[2][i]%></h6></p>\n\
          '+
 '</div>'+
 '</div>';

var infowindow = new google.maps.InfoWindow({
 content: contentString
});
// open tooltip on load
infowindow.open(map);
            <%}
                }%>

 }
  function carregaMap (){
     google.maps.event.addDomListener(window, 'load', initialize);
       setInterval(carregaMap(), 5000);
                <%
                    System.out.println("Recarregam!!!!!!");
                %>
}   
carregaMap();
        </script>

    
    
    
    <div id="idMap" class="row">
        <div class="wrap">
            <div id="map-canvas" style="height: 350px" class=" z-depth-4"></div>
            
           
        
            <br>
            <div class="row background white"> 
                <%Format format = new Format();%>
            <table class="highlight striped responsive-table z-depth-4" id="dataTable">
                <thead class="background #00838f cyan darken-3">
                <b><tr>
                    <th><i class="material-icons">directions_boat</i>&nbsp;&nbsp;Empurrador</th>
                    <th><i class="material-icons">network_cell</i>&nbsp;&nbsp;MCT/UCC</th>
                    <th><i class="material-icons">update</i>&nbsp;&nbsp;Ultima Posição</th>
                    <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;RPM-1</th>
                    <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;RPM-2</th>
                 
                 
                    
                    </tr></b>
              </thead>
             
            
                  <%
                     String position = "";
                      for (int i = 0; i < 100; i++) {
           
                     if(painel[1][i] ==null){
                         i=100;
                         
                     }else{
                       

                  %>
                <tr>
                    <!--painel[2][i] -->
                    <%
                    position = format.DataFormat(painel[2][i]);
                    %>
                    <th><i class="material-icons">directions_boat</i>&nbsp;&nbsp; <%=painel[0][i]%></th>
                   <th><i class="material-icons">network_cell</i>&nbsp;&nbsp;<%=painel[1][i]%></th>
                    <th><i class="material-icons">update</i>&nbsp;&nbsp;<%=position%></th>
                     <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;<%=painel[5][i]%></th>
                      <th><i class="material-icons">multiline_chart</i>&nbsp;&nbsp;<%=painel[6][i]%></th>
                     
                      
                  
                              
                </tr>
                <%
}}
%>
        
    
            </table>
            </div>
        </div>
        
    </div>
    
   
          <!--FIM do Corpo do App -->
        
        <!--Materialize JS -->
        <script src="js/materialize.js"></script>
         <!--Materialize INICIALIZA o menu para Mobile -->
       
        
       
    </body>
</html>