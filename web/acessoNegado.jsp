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

             <div class="row ">
                 <div class="col s12 m6 col s12 ">
                     <div class="card blue-grey darken-1 offset-s5">
                         <div class="card-content white-text ">
                             <span class="card-title">ACESSO NEGADO!!</span>
                             <p>Favor entrar em contato com a equipe e desenvolvimento, ou tente novamente.</p>
                             <p>Fones: (91) 991624383 / 33661020.</p>
                         </div>
                         <div class="card-action">
                             <a href="login.jsp">Voltar</a>
                         
                         </div>
                     </div>
                 </div>
             </div>
         </div>
         
          <!--FIM do Corpo do App -->
        
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