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
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <!--FIM Cabeçalho Para Materialize-->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuUm5AoarbQslI0GK5Q-751SwDNaNJQyM" type="text/javascript"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <script src='js/dragula.js'></script>
        <script src='js/classes.js'></script>
        <link rel="stylesheet" type="text/css" href="css/dragula.css">
        <style>
            .drak{ min-height: 50px; padding-bottom: 10px;}
            .equip{ border:solid 1px; background-color: #0277bd; margin: 5px; border-radius: 10px; text-align: center; color:white;}
            .contBody{margin:5px !important;border-radius: 10px; position: relative !important; background-color: #DFDFDF}
            .cont{margin:5px !important; padding-bottom: 20px !important; position: relative !important; width: 100% !important;}
            .grupo{ }
            .titulo{word-break: break-all; padding-left: 0 !important;}
            .close2{background-color:#0277bd !important; position: absolute !important; right:0 !important; border-radius: 0 10px 0 0 !important; 
                   float:right;padding:0 10px !important; padding: 0px 20px 0px 15px !important;}
            /* .close {position: absolute;right: 32px;top: 32px;width: 32px;height: 32px;opacity: 0.3;} */
            .close:hover {opacity: 1;}
            .close:before, .close:after {position:absolute;left:15px;content: ' ';height:33px;width:1px;background-color:#333;}
            .close:before {transform: rotate(45deg);}
            .close:after {transform: rotate(-45deg);}
        </style>
    </head>
    
    <body>
        
        <script>
            $(document).ready(function(){
                $('.dropdown-trigger').dropdown();
                $('select').formSelect();
                $('.collapsible').collapsible();
                $(".dropdown-trigger").dropdown('toggle');
            });
            function salvarEquipamentos(){
                var containers = $('.dragula-container');
                var leng = $('.dragula-container').length;
                for(var i=0; i<leng; i++){
                    console.log('container: '+containers[i].innerText);
                    var item = $('.dragula-container > .equip');
                    var itemleng = item.length;
                    for(var n=0; n<itemleng; n++){
                        console.log('item: ');
                        console.log('id: '+item[n].id+' nome: '+item[n].innerText);
                    }
                }                
            }
            function addGrupo(){
                var novoGrupo = document.getElementById("novoGrupo").value.toString().toUpperCase();
                if(novoGrupo != ""){
                    console.log(novoGrupo);
                    novoGrupo = '<div class="col s3 contBody" >'+
                        '<button class="close2 col s1 offset-s11 waves-effect waves-light btn" onclick="close()">X</button>'+
                        '<h6 class="titulo col s11">'+novoGrupo+'</h6>'+
                        '<div class="container cont">'+
                        '<div class="dragula-container drak s12" id="'+novoGrupo+'"></div>'+
                        '</div>'+
                    '</div>';
                    $('#grupos').append(novoGrupo);
                    document.getElementById("novoGrupo").value = '';
                }
            }
            
            function close(){
                console.log("kralho!");
                console.log(id);
                console.log($(id));
            }
            
            function addGrupoEnter(event){
                if(event.keyCode === 13){
                    addGrupo();
                }
            }
        </script>
        <%
        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> " + conta);
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        Statement stmt1 = con.createStatement();
        Statement stmt2 = con.createStatement();
    %>
        
        <!-- INCLUDE DA NAVBAR -->
        <jsp:include page="navbar.jsp"></jsp:include>

        
        <!--FIM DO CORPO DA PAGINA-->
        <%
            Rpm rpm = new Rpm();
            String[][] veiculos = rpm.nomeEmbarcacao(conta, con, stmt,"").clone();  
            
        
        %>      
        
        <div class="container row">
            <div class="col s12">
                <div class="col s4 cotainer">
                    <p>nome do grupo:<input id="novoGrupo" maxlength="24" type="text" onkeypress="addGrupoEnter(event)" autofocus>
                    <button class="waves-effect waves-light btn" onclick="addGrupo()">salvar grupo</button>
                </div>
            </div>
            <div id="grupos" class="col s12">
                <div id="col01" class="col container s3 contBody" >
                    <h6>EQUIPAMENTOS</h6>
                    <div id="draktest" class="dragula-container drak">
                    <%
                        System.out.println("lenght: "+veiculos.length);
                        for(int i=0; i<100;i++){
                            if(veiculos[1][i] == null){
                               i = 100; 
                            }else{
                                %><div id="<%=veiculos[1][i]%>" class="col s12 equip" ><p><%=veiculos[0][i] %></p></div><%
                            }
                        }
                    %>
                    </div>
                </div>
                             
            </div>
                <div class="col s12">
                    <button style="width:100%;" onclick="salvarEquipamentos()">Salvar</button>
                </div>
        </div>
        
        <!--Materialize JS -->
        <script src="js/materialize.js"></script>
        <script>
            $(document).ready(function(){            
                var drake = dragula({
                    isContainer: function (el) {
                        return el.classList.contains('dragula-container');
                    }
                });
            });
            
        </script>
        <script>
            $(document).ready(function(){
                $('.collapsible').collapsible();
            });
            
        </script>
    </body>
</html>
