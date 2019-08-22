<%-- 
    Document   : login
    Created on : 18/11/2018, 19:18:50
    Author     : VictorSantana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>index</title>
           <!--Cabeçalho Para Materialize-->
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--Materialize Icones -->  
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Materialize CSS -->
        <link rel="stylesheet" type="text/css" href="css/materialize.css">
      
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
       
        <!--FIM Cabeçalho Para Materialize-->
        <script>
            
             var classApi = new classApi;
             var conectBd = classApi.conectBd(1);
        </script>
    </head>
       <body class="background #eeeeee grey lighten-3">
        <div class="navbar-fixed z-depth-5">

         <nav class="#00838f cyan darken-3">
             
                 <div class="nav-wrapper" >
                     &nbsp;&nbsp;<a href="#!" class="brand-logo right-aligned"><b><i class="material-icons">directions_boat</i><h5>NAVEGA GESTOR</h5></b></a>
                     <ul id="nav-mobile" class="right hide-on-med-and-down">
                         <li class="left-align"><a href="home.html" ><b class="center-align  waves-effect">Sobre</b></a></li>
                         <li class="left-align"><a href="http://www.autotrac.com.br"><b class="center-align  waves-effect">Autotrac</b></a></li>
                      
                     </ul>
                 </div>
          
         </nav>
       </div>
        <!-- INICIO Botão de Add -->
        <div class="fixed-action-btn  click-to-toggle " style="bottom: 35px; right: 45px;">
            <a class="btn-floating z-depth-5 #4db6ac teal lighten-0 btn-large waves-effect z-depth-4">
                <i class="material-icons">add</i></a>

                <ul>
                    <li><a href="lista.html" class="btn-floating z-depth-5 #4db6ac teal lighten-3 btn-large waves-effect z-depth-4">
                            <i class="material-icons">directions_run</i>clolse</a>
                    </li>

                    
                </ul>
        </div>
        <!-- FIM Botão de Add -->
         <!--INICIO do Corpo do App -->
         <div class=" container "><br>
             

             <div class="row" id="formDiv">
                 <div class="container ">
                     <form name="login" class="col s6 offset-s3" method="post" action="login2.jsp">
                     <b><h5 class="offset-s3">NAVEGA GESTOR</h5></b>
                     <div class="row">
                         <div class="input-field col s12">
                             <input id="user" type="text" name="user" class="validate">
                             <label for="email">Usuario</label>
                         </div>
                     </div>

                     <div class="row center-on-small-only">
                         <div class="input-field col s12 center-on-small-only">
                             <input id="senha" name="senha" type="password" class="validate center-on-small-only z-depth-4">
                             <label for="password" class="center-on-small-only">Password</label>
                         </div>
                     </div>
                     
                     <div class="row">
                         <a  class="btn col s6 center-align push-s3 z-depth-5  " onclick ='confirma(login)'>Entrar<i class="material-icons right">send</i></a>
                     </div>

                 </form>
             </div>
                 </div>
         </div>
    
          <!--FIM do Corpo do App -->
          <script type="text/javascript">
             function confirma (form){
              form.submit();
              return false;   
             }
          </script>
        <!--Materialize Jquery -->    
        <script src="js/jquery.js"></script>
        <!--Materialize JS -->
        <script src="js/materialize.js"></script>
         <!--Materialize INICIALIZA o menu para Mobile -->
        <script>
            $(".button-collapse").sideNav();
        </script>
    </body>
</html>