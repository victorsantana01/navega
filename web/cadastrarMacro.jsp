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
        <!-- Bootstrap core CSS-->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom fonts for this template-->
        <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <!-- Custom styles for this template-->
        <link href="css/sb-admin.css" rel="stylesheet">
    </head>

    <body class="bg-dark">
        <%
        /* Inicio de Sessão */
        String conta = session.getAttribute("conta").toString();
        System.out.println("Numero da conta é >>>>> "+conta);
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        %>
        <div class="container">
            <div class="card card-login mx-auto mt-5">
                <div class="card-header">Consumo</div>
                <div class="card-body">
                    <div class="text-center mt-4 mb-5">
                        <h4>Feito!</h4>
                        <p>Definição de Macro salva com sucesso!</p>
                    </div>

                    <%
                        System.out.println("Numero Macro: "+request.getParameter("numeroMacro"));
                        System.out.println("Nome Macro: "+request.getParameter("nome"));
                        System.out.println("Versao: "+request.getParameter("versao"));
                        int i=0;
                        int j=0;
                        String labels = "";
                        String tipos = "";
                        String ordem = "";
                        while(request.getParameter("label"+i) != null){
//                            System.out.println("label"+i+" :"+request.getParameter("label"+i));
                            labels = labels+"_"+request.getParameter("label"+i);
                            ordem = ordem+"_"+request.getParameter("label"+i+"_ordem");
                            i++;
                        }
                        while(request.getParameter("tipo"+j) != null){
                            System.out.println("tipo"+j+" :"+request.getParameter("tipo"+j));
                            tipos = tipos+"_"+request.getParameter("tipo"+j);
                            j++;
                        }
                        System.out.println("tipos: "+tipos);
                        String nome = request.getParameter("nome");
                        String numeroMacro = request.getParameter("numeroMacro");
                        String versao = request.getParameter("versao");
                        
                        MacroDao macro = new MacroDao();
                        boolean xx = macro.defExiste(conta, con, stmt, numeroMacro, versao);
                        if(xx == false){
                            System.out.println("nova definição");
                            macro.cadastrarMacro(conta, con, stmt, numeroMacro, nome, labels, tipos, versao, ordem);
                            String redirectURL = "/NavegaGestor/listarMacros.jsp";
                            response.sendRedirect(redirectURL);
                        }else{
                            System.out.println("editar definição");
                            macro.editarMacro(conta, con, stmt, numeroMacro, nome, labels, tipos, versao, ordem);
                            String redirectURL = "/NavegaGestor/listarMacros.jsp";
                            response.sendRedirect(redirectURL);
                        }                     
                        
                        
                    %>
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
