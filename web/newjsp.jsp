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
        <link rel="stylesheet" type="text/css" href="css/materialize.css">
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
        <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js?snipver=1"></' + 'script>')</script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <!--FIM Cabeçalho Para Materialize-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        
        <script src='js/dragula.js'></script>
        <script src='js/classes.js'></script>
        <link rel="stylesheet" type="text/css" href="css/dragula.css">
        <style>
            .drak{ height: 100%; width: 100%}
            .equip{ height: 90px; border:solid 1px; background-color: lightslategrey; margin: 5px; border-radius: 10px; text-align: center;}
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
        <%
        /* Inicio de Sessão */
        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> "+conta);
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        %>
        <script>
            $(document).ready(function(){
                //$('.dropdown-trigger').dropdown();
                $('select').formSelect();
                $('.collapsible').collapsible();
                //$(".dropdown-trigger").dropdown('toggle');
                
            });
            function onUp(){
                console.log("change");
                let child =$('#draktest').children();
                for(var i=0;i<child.length; i++){
                    
                    let name = child[i].children[1].children[0].name;
                    let ordem = child[i].children[0].children[1].attributes[1].value;
                    child[i].children[0].children[0].remove();
                    n = i+1;
                    child[i].children[0].innerHTML = "<h4 name='"+i+"'>"+n+"</h4><input type='hidden' ordem='"+ordem+"' name='"+name+"_ordem' value='"+i+"'>";
                }
                child =$('#draktest').children();
                let ordem = "";
                for(var i=0;i<child.length; i++){
                    ordem = ordem+"_"+child[i].children[0].children[1].attributes[1].value;
                }
                console.log("ORDEM:  "+ordem);
                $('#ordem')[0].value = ordem;
                
            }
        </script>
        
        <!-- INCLUDE DA NAVBAR -->
        <jsp:include page="navbar.jsp"></jsp:include>

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
        <div class="container"><!--INCIO DO CORPO DA PAGINA-->
            
            <div class="container">
                <%
                    String id = request.getParameter("id");
                    MacroDao macrodao = new MacroDao();
                    String[][] macroSelecionada = macrodao.getMacroById(conta, con, stmt, id);
                    String[][] macroEdit = macrodao.getMacroDef(conta, con, stmt, macroSelecionada[0][0],macroSelecionada[2][0]);
                    String ordemOriginal = "";
                    for (int i = 0; i < 100; i++) {
                            if(macroEdit[i][2] == null){
                                i = 100;
                            }else{
                                ordemOriginal = ordemOriginal+"_"+macroEdit[i][2];
                            }
                        }
                    String macroNome = macrodao.getMacroName(conta, con, stmt, macroSelecionada[0][0]);
                    System.out.println("macro");
                    for (int i = 0; i < 10; i++) {
                        if(macroSelecionada[i][0] != null){
                            System.out.println(i+" "+macroSelecionada[i][0]);                            
                        }
                    }
                %>
                <div class="card row">
                    <div class="card-content black-text ">
                        <span class="card-title center"><b>DEFINICAÇÃO DE MACRO</b></span><br>
                        
                        <div class=" col s12">
                            <form id="macro" name="macro" action="cadastrarMacro.jsp" method="get">
                                <div class="col s12">
                                    <div class="input-field col s6 right-align" style="padding-left: 0px !important">
                                        <input type="text" id="numeroMacro" name="numeroMacro" value="<%=macroSelecionada[0][0]%>" readonly />
                                        <label for="numeroMacro" style="left:0px !important">Nº Macro</label>
                                    </div>
                                    <div class="input-field col s6 right-align" style="padding-left: 0px !important">
                                        <input type="text" id="versao" name="versao" value="<%=macroSelecionada[2][0]%>" readonly />
                                        <label for="versao" style="left:0px !important">Versao</label>
                                    </div>
                                </div>
                                <div class="col s12">
                                    <div class="input-field col s6 right-align" style="padding-left: 0px !important">
                                        <% if(macroEdit[0][0] != null){ %>
                                        <input type="text" id="nome" name="nome" value="<%= macroNome %>" required />
                                        <% }else{ %>
                                        <input type="text" id="nome" name="nome" required />
                                       <% }%>
                                        <label for="nome" style="left:0px !important">Nome da Macro</label>
                                        <input type="hidden" name="ordem" id="ordem" value="<%= ordemOriginal %>" />
                                    </div>
                                </div>
                                <span class="card-title center"><strong>Nomeie e ordene os campos</strong</span><br>
                                <div id="draktest" class="dragula-container drak s12">
                                <%
                                    int x=0;
                                    
                                    for (int i = 3; i < 100; i++) {
                                        if(macroSelecionada[i][0] == null){
                                            
                                        }else{
                                            if(macroEdit[x][0] != null){
                                                int ordem;
                                                if(macroEdit[x][2] != ""){
                                                    ordem = Integer.parseInt(macroEdit[x][2])+1;
                                                    System.out.println("----------------- POSSUI ORDEM!! ----------------");
                                                    System.out.println("x: "+x+" - "+macroEdit[x][2]);
                                                }else{
                                                    ordem = x+1;
                                                    System.out.println("----------------- NÃO POSSUI ORDEM ---------------");
                                                }
                                                %>
                                                
                                                    <div id="Ordem-<%=ordem%>" onmouseup="onUp()" class="equip s12">
                                                        <div class="col s2">
                                                            <h4><%=ordem%></h4>
                                                        </div>
                                                        <div class="input-field col s6">
                                                            <input type="text" id="label<%=x%>" name="label<%=x%>" required value="<%=macroEdit[x][0]%>" />
                                                            <label for="label<%=x%>"><%=macroSelecionada[i][0]%></label>
                                                        </div>
                                                        <div class="col s4">
                                                            <select class="browser-default black-text input-field" id="tipo<%=x%>" name="tipo<%=x%>" required > 
                                                                <option class="black-text" value="" disabled>TIPO DE DADO</option>
                                                                <% if(macroEdit[x][1].equals("1")){ %>
                                                                <option class="black-text" value="1" selected>Texto</option>
                                                                <% }else{ %>
                                                                <option class="black-text" value="1">Texto</option>
                                                                <% } %>
                                                                <% if(macroEdit[x][1].equals("2")){ %>
                                                                <option class="black-text" value="2" selected>Data</option>
                                                                <% }else{ %>
                                                                <option class="black-text" value="2">Data</option>
                                                                <% } %>
                                                                <% if(macroEdit[x][1].equals("3")){ %>
                                                                <option class="black-text" value="3" selected>Horas</option>
                                                                <% }else{ %>
                                                                <option class="black-text" value="3">Horas</option>
                                                                <% } %>
                                                                <% if(macroEdit[x][1].equals("4")){ %>
                                                                <option class="black-text" value="4" selected>Observacao</option>
                                                                <% }else{ %>
                                                                <option class="black-text" value="4">Observacao</option>
                                                                <% } %>
                                                                <% if(macroEdit[x][1].equals("5")){ %>
                                                                <option class="black-text" value="5" selected>Manutenção</option>
                                                                <% }else{ %>
                                                                <option class="black-text" value="5">Manutenção</option>
                                                                <% } %>
                                                            </select>
                                                        </div>
                                                    </div>                                                
                                        
                                        
                                        <%
                                            }else{
                                                int ordem = x;
                                        %>
                                        <div id="Ordem-<%=ordem%>" onmouseup="onUp()" class="equip s12">
                                            <div class="col s2">
                                                <h4><%= ordem%></h4>
                                                <input type='text' name="label<%=x%>_ordem" value="<%=ordem%>"/>
                                            </div>
                                            <div class="input-field col s6">
                                                <input type="text" id="label<%=x%>" name="label<%=x%>" required />
                                                <label for="label<%=x%>"><%=macroSelecionada[i][0]%></label>
                                            </div>

                                            <div class="col s4">
                                                <select class="browser-default black-text" id="tipo<%=x%>" name="tipo<%=x%>" required > 
                                                    <option class="black-text" value="" disabled>TIPO DE DADO</option>
                                                    <option class="black-text" value="1">Texto</option>
                                                    <option class="black-text" value="2">Data</option>
                                                    <option class="black-text" value="3">Horas</option>
                                                    <option class="black-text" value="4">Observacao</option>
                                                    <option class="black-text" value="5">Manutenção</option>
                                                </select>
                                            </div>
                                        </div>                                        

                                        <%
                                                }
                                            }
                                        x++;
                                        }
                                        %>
                                </div>
                                <br>
                                <div class="card-action col s12">
                                    <button type="submit" class="btn col s4 center-align push-s4 z-depth-5 blue ">Salvar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
            
        </div><!--FIM DO CORPO DA PAGINA-->
        
        <!--Materialize JS -->
        <script src="js/materialize.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $('.collapsible').collapsible();
                var drake = dragula({
                    isContainer: function (el) {
                        return el.classList.contains('dragula-container');
                    }
                });
                
                var toSort =$('#draktest').children();
                toSort = Array.prototype.slice.call(toSort, 0);
        
                toSort.sort(function(a, b) {
                    var aord = +a.id.split('-')[1];
                    var bord = +b.id.split('-')[1];
                    // two elements never have the same ID hence this is sufficient:
                    return (aord > bord) ? 1 : -1;
                });
                var parent = $('#draktest');
                parent.innerHTML = "";

                for(var i = 0, l = toSort.length; i < l; i++) {
                    parent.append(toSort[i]);
                }
            });
            function confirma(form) {
                form.submit();
                return false;
            }
        </script>
    </body>
</html>
