/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import fabricaConexao.ConexaoMySQL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import logic.Format;
import src.Macros;

/**
 * Classe feita para consultar a Macro
 * @author Luiz Lacerda
 */
public class MacroDao {
    
    /**
     * Metodo consulta as macros que estão cadastradas
     * @param conta String - conta do cliente
     * @param con Connection
     * @param stmt Statement
     * @return retorna um vetor bidimensional de Strings com os dados das macros encontradas.
     */
    public String[][] listarMacroCadastradas(String conta,Connection con, Statement stmt){
        String[][] macroCadastradas = new String[10][50];
        
        try{
            
            String sql = ("SELECT * FROM `def_macro` WHERE usuario = '"+conta+"'");
            ResultSet rs = stmt.executeQuery(sql);
            int i=0;
            while(rs.next()){
                macroCadastradas[0][i] = rs.getString("macro");
                macroCadastradas[1][i] = rs.getString("versao");
                macroCadastradas[2][i] = rs.getString("nome");
                macroCadastradas[3][i] = rs.getString("text");
                i++;
            }
            
        }catch(Exception e){
            System.out.println("ERROR NO METODO LISTARMACROCADASTRADAS");
            System.out.println(e);
        }
        
        return macroCadastradas;
    }
    
    /**
     * Metodo procura uma macro apartir do seu id
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @param id String - id da macro pesquisada
     * @return retorna um vetor bidimensional de Strings com os dados da macro encontrada.
     */
    public String[][] getMacroById(String conta,Connection con, Statement stmt, String id){
        System.out.println("METODO GETMACROBYID");
        String[][] macroSelecionada = new String[100][2];
        
        try{
            
            String sql = ("SELECT IIRTN_MacroNumber, IIRTN_Text, IIRTN_MacroVersion "
                    + "FROM `"+conta+"_messagereturn_iirtn` WHERE IIRTN_ID = '"+id+"'");
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                int total = rs.getString("IIRTN_Text").split("_").length;
                macroSelecionada[0][0] = rs.getString("IIRTN_MacroNumber");                 //NUMERO DA MACRO
                macroSelecionada[1][0] = rs.getString("IIRTN_Text");                        //TEXTO
                System.out.println("texto: "+macroSelecionada[1][0]);
                macroSelecionada[2][0] = ""+rs.getString("IIRTN_MacroVersion");                 //Version
                System.out.println("total: "+macroSelecionada[2][0]);
                System.out.println("array length: "+macroSelecionada.length);
                if(total>0){
                    for (int i = 3; i < total+2; i++) {
                        macroSelecionada[i][0] = rs.getString("IIRTN_Text").split("_")[i-2];
                        System.out.println(i+" : "+macroSelecionada[i][0]);
                    }
                }else{
                    System.out.println("if getmacrobyid");
                    macroSelecionada[3][0] = rs.getString("IIRTN_Text");
                    System.out.println("0 : "+macroSelecionada[3][0]);
                }
                
            }
            
        }catch(Exception e){
            System.out.println("ERRO NO METODO GETMACRO!");
            System.out.println(e);
        }
        System.out.println("FIM METODO GETMACROBYID");
        return macroSelecionada;
    }
    /**
     * Metodo cadastra uma nova macro no banco de dados
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @param numeroMacro String - numero da macro
     * @param nome String - nome da macro
     * @param labels String - numero de itens na macro
     * @param tipos String - os tipos de cada um dos itens na labels.
     * @param versao String - versão da macro.
     */
    public void cadastrarMacro(String conta,Connection con, Statement stmt, String numeroMacro, String nome, String labels, String tipos, String versao, String ordem ){
        System.out.println("------------------------------");
        System.out.println("numeroMacro: "+numeroMacro);
        System.out.println("nome: "+nome);
        System.out.println("Labels: "+labels);
        System.out.println("versao: "+versao);
        System.out.println("ordem: "+ordem);
        try{
            
            String sql = ("INSERT INTO `def_macro`(`macro`, `nome`, `usuario`, `text`, `tipo`, `versao`, `ordem` ) VALUES ('"+numeroMacro+"','"+nome+"','"+conta+"','"+labels+"','"+tipos+"','"+versao+"','"+ordem+"')");
            stmt.executeUpdate(sql);
            System.out.println("MACRO "+numeroMacro+" SALVA COM SUCESSO!!!!!");
        }catch(Exception e){
            System.out.println("ERRO NO METODO CADASTRARMACRO");
            System.out.println(e);
        }
    }
    /**
     * Edita uma macro no banco de dados
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @param numeroMacro String - numero da macro
     * @param nome String - novo nome da macro
     * @param labels String - novos labels
     * @param tipos String - novos tipos
     * @param versao String - novo numero de versão
     */
    public void editarMacro(String conta,Connection con, Statement stmt, String numeroMacro, String nome, String labels, String tipos, String versao, String ordem ){
        System.out.println("------------------------------");
        System.out.println("numeroMacro: "+numeroMacro);
        System.out.println("nome: "+nome);
        System.out.println("Labels: "+labels);
        System.out.println("versao: "+versao);
        System.out.println("ordem: "+ordem);
        try{
            
            String sql = ("UPDATE `def_macro` SET `nome` = '"+nome+"', `text` = '"+labels+"', `tipo` = '"+tipos+"' , `ordem` = '"+ordem+"' WHERE `def_macro`.`macro` = "+numeroMacro+";");
            stmt.executeUpdate(sql);
            System.out.println("MACRO "+numeroMacro+" EDITADA COM SUCESSO!!!!!");
        }catch(Exception e){
            System.out.println("ERRO NO METODO EDITARMACRO");
            System.out.println(e);
        }
    }
    /**
     * Metodo lista todas as macros pertencentes ao usuario
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt1 Statement
     * @param stmt2 Statement
     * @param stmt3 Statement
     * @return retorna um vetor bidimensional de Strings com os dados das macros encontradas.
     */
    public String[][] listarMacros(String conta,Connection con, Statement stmt1, Statement stmt2, Statement stmt3){
        String[][] macros = new String[6][100];
        try{
                        
            String sql = ("SELECT DISTINCT IIRTN_MacroNumber as macros, IIRTN_MacroVersion as version FROM `"+conta+"_messagereturn_iirtn` ORDER BY IIRTN_MacroNumber ASC");
            ResultSet rs = stmt2.executeQuery(sql);
            
            int i =0;
            while(rs.next()){
//                System.out.println("total: "+rs.getString("macros"));
                try{
                    String sql2 = ("SELECT * FROM `"+conta+"_messagereturn_iirtn` WHERE IIRTN_MacroNumber = '"+rs.getString("macros")+"' and IIRTN_MacroVersion = '"+rs.getString("version")+"' and IIRTN_Text <> '' ORDER BY IIRTN_MacroNumber DESC LIMIT 1");
                    ResultSet rs2 = stmt1.executeQuery(sql2);
                    
                    while(rs2.next()){
                        macros[0][i] = rs2.getString("IIRTN_ID");
                        macros[1][i] = rs2.getString("IIRTN_MacroNumber");
                        macros[2][i] = rs2.getString("IIRTN_MacroVersion");
                        macros[3][i] = rs2.getString("IIRTN_MessageTime");
                        macros[4][i] = rs2.getString("IIRTN_MctAddress");
                        macros[5][i] = rs2.getString("IIRTN_Text");
                        i++;
                    }
                }catch(Exception e){
                    System.out.println("ERROR NO METODO LISTARMACROS WHILE 2");
                    System.out.println(e);
                }
            }
            
            
        }catch(Exception e){
            System.out.println("ERRO NO METODO LISTARMACROS");
            System.out.println(e);
        }
        
        
        return macros;
    }
    /**
     * @deprecated metodo especifico para a macro 3, não é mais usado, foi criado um metodo generico que ingloba todas as macros
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt1 Statement
     * @param stmt2 Statement
     * @param embarcacaoManobra String - mct da embaração
     * @param dataManobra String - Data de inicio e fim da manobra.
     * @return retorna um vetor bidimensional de Strings com os dados dos macros encontradas.
     */
    public String[][] pesquisaMacro(String conta,Connection con, Statement stmt1, Statement stmt2, String embarcacaoManobra, String dataManobra){
        
        Format format = new Format();
        String[][] macros = new String[13][5000];
        String data="";
        String dataInicio;
        String dataFim;
        String embarcacao;

        
        
        if(embarcacaoManobra == null || embarcacaoManobra == ""){
            embarcacao = "";
        }else{            
            embarcacao = " and b.mct = '"+embarcacaoManobra+"' ";
            System.out.println("barco: "+embarcacaoManobra);
        }
        if(dataManobra == null || dataManobra == ""){}
        else{
            try{
                dataManobra.replace("/", "-");
                System.out.println("dataManobra: "+dataManobra);
                dataInicio = dataManobra.split(" - ")[0].replace("/", "-");
                dataFim =  dataManobra.split(" - ")[1].replace("/", "-");
                System.out.println("dataInicio: "+dataInicio);
                System.out.println("dataFim: "+dataFim);
                dataInicio = format.DataFormat(dataInicio).replace("/", "-");
                System.out.println("dataInicioFormatada: "+dataInicio);
                dataFim = format.DataFormat(dataFim).replace("/", "-");
                System.out.println("dataFimFormatada: "+dataFim);
                data = " and (me.IIRTN_MessageTime BETWEEN '"+dataInicio+":00' and '"+dataFim+":00') ";
            }catch(Exception e){
                System.out.println("ERROR AO FORMATAR A DATA DE MANOBRA: "+e+"  ---------------------------");
            }
        }
        try {
            String sql2 = ("SELECT me.IIRTN_MessageTime, me.IIRTN_MctAddress, me.IIRTN_Text, b.nome, mo.nome_motor\n" +
                        "FROM exporta."+conta+"_messagereturn_iirtn me \n" +
                        "left join barco b on me.IIRTN_MctAddress = b.mct\n" +
                        "left join motor_tab mo on b.motor = mo.idmotor_tab\n" +
                        "where IIRTN_MacroNumber = \"3\" "+
                        " "+embarcacao+" "+data+
                        "order by me.IIRTN_MessageTime;");
            ResultSet rs2 = stmt2.executeQuery(sql2);
            int i=0;
            while(rs2.next()){
                System.out.println("ENTROU NO LOOP");
                System.out.println(rs2.getString("me.IIRTN_Text"));
                String[] macroArray = rs2.getString("me.IIRTN_Text").split("_",12);
                System.out.println("inicia MacroArray");
//                System.out.println("macroArray.length: "+macroArray.length);
                for(int y=0;y<macroArray.length;y++){
                    System.out.println(y+" : "+macroArray[y]);
                }
                System.out.println("final MacroArray");
                Format format2 = new Format();
                String time = rs2.getString("me.IIRTN_MessageTime");

/*0 DATA            */  macros[0][i] = format2.DataFormat(rs2.getString("me.IIRTN_MessageTime"));
/*1 EMBARCACAO      */  macros[1][i] = rs2.getString("b.nome");
/*2 MANOBRA         */  macros[2][i] = macroArray[7];
/*3 MOTOR           */  macros[3][i] = rs2.getString("mo.nome_motor");
/* DATAHORAINICIO  */   macros[4][i] = format2.DataFormat(time.split(" ")[0])+" "+macroArray[4].substring(0,2)+":"+macroArray[4].substring(2,4);
/* DATAHORAFIM     */   macros[5][i] = format2.DataFormat(time.split(" ")[0])+" "+macroArray[6].substring(0,2)+":"+macroArray[6].substring(2,4);
/* TEMPO           */   macros[6][i] = format2.tempo(macroArray[4], macroArray[6]);
/* CONSUMO         */   macros[7][i] = macroArray[8];
/* SALDO           */   macros[8][i] = macroArray[1];
/* PORTO           */   macros[9][i] = macroArray[10];
/* CMT             */   macros[10][i] = macroArray[11];
/* CHEMAQ          */   macros[11][i] = macroArray[11]; 
/* CHEMAQ          */   macros[12][i] = rs2.getString("me.IIRTN_MctAddress");
                        System.out.println("FINAL DO IF");
                        i++;
            }
            System.out.println("METODO PESQUISAMACRO REALIZADO COM SUCESSO.......... ");
        } catch (Exception e) {

            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.err.println("ERRO NO METODO PESQUISAMACRO 111111........... ");
        }

        return macros;
        
    }
    /**
     * @deprecated metodo especifico para a macro 3, não é mais usado, foi criado um metodo generico que ingloba todas as macros
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt1 Statement
     * @param stmt2 Statement
     * @return retorna um vetor bidimensional de Strings com os dados dos macros encontradas.
     */
    public String[][] pesquisaMacro(String conta,Connection con, Statement stmt1, Statement stmt2){
        
        String[][] macros = new String[13][5000];
        
        try {
            
            
            String sql1 = ("SELECT DISTINCT(IIRTN_Text) FROM "+conta+"_messagereturn_iirtn where IIRTN_MacroNumber=3");
            ResultSet rs1 = stmt1.executeQuery(sql1);
            int i = 0;
            while(rs1.next()){
                String sql2 = ("SELECT first me.IIRTN_MessageTime, me.IIRTN_MctAddress, me.IIRTN_Text, b.nome, mo.nome_motor\n" +
                            "FROM exporta."+conta+"_messagereturn_iirtn me \n" +
                            "left join barco b on me.IIRTN_MctAddress = b.mct\n" +
                            "left join motor_tab mo on b.motor = mo.idmotor_tab\n" +
                            "where IIRTN_MacroNumber = \"3\" and me.IIRTN_MessageTime = '"+rs1.getString("IIRTN_Text")+"';");
                ResultSet rs2 = stmt2.executeQuery(sql2);
                if(rs2.next()){
                    System.out.println("ENTROU NO LOOP");
                    String[] macroArray = rs2.getString("me.IIRTN_Text").split("_",12);
                    System.out.println("inicia MacroArray");
                    System.out.println("macroArray.length: "+macroArray.length);
                    for(int y=0;y<macroArray.length;y++){
                        System.out.println(y+" : "+macroArray[y]);
                    }
                    System.out.println("final MacroArray");
                    Format format = new Format();
                    String time = rs2.getString("me.IIRTN_MessageTime");

    /*0 DATA            */  macros[0][i] = format.DataFormat(rs2.getString("me.IIRTN_MessageTime"));
    /*1 EMBARCACAO      */  macros[1][i] = rs2.getString("b.nome");
    /*2 MANOBRA         */  macros[2][i] = macroArray[7];
    /*3 MOTOR           */  macros[3][i] = rs2.getString("mo.nome_motor");
    /* DATAHORAINICIO  */   macros[4][i] = format.DataFormat(time.split(" ")[0])+" "+macroArray[4].substring(0,2)+":"+macroArray[4].substring(2,4);
    /* DATAHORAFIM     */   macros[5][i] = format.DataFormat(time.split(" ")[0])+" "+macroArray[6].substring(0,2)+":"+macroArray[6].substring(2,4);
    /* TEMPO           */   macros[6][i] = format.tempo(macroArray[4], macroArray[6]);
    /* CONSUMO         */   macros[7][i] = macroArray[8];
    /* SALDO           */   macros[8][i] = macroArray[1];
    /* PORTO           */   macros[9][i] = macroArray[10];
    /* CMT             */   macros[10][i] = macroArray[11];
    /* CHEMAQ          */   macros[11][i] = macroArray[11]; 
    /* CHEMAQ          */   macros[12][i] = rs2.getString("me.IIRTN_MctAddress");
                            System.out.println("FINAL DO IF");
                            i++;
                    
                }
            }
            
            System.out.println("METODO PESQUISAMACRO REALIZADO COM SUCESSO ........... ");
        } catch (Exception e) {

            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.err.println("ERRO NO METODO PESQUISAMACRO 2222........... ");
        }

        return macros;
        
    }
    
    /**
     * Metodo pesquisa a definição de uma macro apartir de seu numero.
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @param NumeroMacro String - numero da macro que sera procurada
     * @return retorna um vetor bidimensional de String com os dados da definição de macro encontrada, text, tipo e ordem.
     */
    public String[][] getMacroDef(String conta,Connection con, Statement stmt, String NumeroMacro, String versao){
        String[][] macroDef = new String[100][10];
        System.out.println("METODO GETMACRODEF");
        try{
            String sql = ("SELECT * FROM `def_macro` WHERE macro='"+NumeroMacro+"' AND versao='"+versao+"'");
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                String x = rs.getString("text");
                String y = rs.getString("tipo");
                String z = rs.getString("ordem");
                int total = x.split("_").length;
                if(total > 0){
                    for (int j = 0; j < total-1; j++) {
                        macroDef[j][0]= x.split("_")[j+1];
                        macroDef[j][1]= y.split("_")[j+1];
                        if(!z.split("_").getClass().isArray()){
                            System.out.println("z = null");
                            macroDef[j][2]= "";
                        }else{
                            System.out.println("z é array");
                            System.out.println("Z= "+z);
                            macroDef[j][2]= z.split("_")[j+1];
                        }
                        System.out.println(j+" : Texto: "+macroDef[j][0]+" - Tipo: "+macroDef[j][1]+" - Ordem:"+macroDef[j][2]);
                    }
                }else{
                    macroDef[0][0]= x;
                    macroDef[0][1]= y;
                    macroDef[0][2]= z;
                    System.out.println("0 : "+macroDef[0][0]+" - "+macroDef[0][1]);
                }
            }
            
        }catch(Exception e){
            System.out.println("ERRO NO METODO GETMACRODEF");
            System.out.println(e);
        }
        System.out.println("FIM METODO GETMACRODEF");
        return macroDef;
    }
    /**
     * Metodo pesquisa uma macro pelo seu numero e retorna o seu nome
     * @param conta String - Conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @param NumeroMacro String - numero da macro.
     * @return retorna uma String com o nome da macro pesquisada.
     */
    public String getMacroName(String conta,Connection con, Statement stmt, String NumeroMacro){
        System.out.println("ENTROU NO METODO GETMACRONAME");
        String macro = "";
        try{
            String sql = ("SELECT nome FROM `def_macro` WHERE macro="+NumeroMacro+" AND usuario ="+conta+";");
            ResultSet rs = stmt.executeQuery(sql);
            if(rs.next()){
                macro = rs.getString("nome");
                System.out.println("nome: "+macro);
            }        
        }catch(Exception e){
            System.out.println("ERRO NO METODO GETMACRONOME");
            System.out.println(e);
        }
        System.out.println("FIM METODO GETMACRONAME");
        return macro;
    }
    /**
     * Metodo verifica se uma macro possui texto nulo
     * @param conta String - conta do cliente
     * @param con Connection
     * @param stmt Statement
     * @param NumeroMacro String - numero da macro a ser pesquisada
     * @return retorna um boolean, true se não for encontrada nenhuma macro com o texto nulo, false se forem encontradas macros com texto nulo.
     */
    public boolean MacroIsTextNull(String conta,Connection con, Statement stmt, String NumeroMacro){
        boolean macro = false;
        try{
            String sql = ("SELECT * FROM `"+conta+"_messagereturn_iirtn` WHERE IIRTN_MacroNumber='"+NumeroMacro+"' and IIRTN_Text <> \"\"");
            ResultSet rs = stmt.executeQuery(sql);
            if(rs.next() == false){
                macro = true;
                System.out.println("A Macro não possui texto");
            }else{
                macro = false;
                System.out.println("A Macro "+NumeroMacro+" possui texto");
            }
            
        }catch(Exception e){
            System.out.println("ERRO NO METODO GETMACRONOME");
            System.out.println(e);
        }
        return macro;
    }
    /**
     * Metodo pesquisa uma macro por numero e retorna o seu texto.
     * @param conta String - conta
     * @param con Connection
     * @param stmt Statement
     * @param NumeroMacro String - numero da macro.
     * @return retorna um vetor bidimensional de String com os itens da macro.
     */
    public ArrayList<Macros> getMacroText(String conta,Connection con, Statement stmt, Statement stmt1, Statement stmt2, String NumeroMacro, String versaoMacro){
        System.out.println("METODO GETMACROTEXT");
        ArrayList<Macros> macros = new ArrayList<Macros>();
        
        
        try{
            String sql1 = ("SELECT distinct IIRTN_Text as txt FROM `"+conta+"_messagereturn_iirtn` where IIRTN_MacroNumber="+NumeroMacro+" and IIRTN_MacroVersion="+versaoMacro+" and IIRTN_Text <> '' ;");
            ResultSet rs2 = stmt1.executeQuery(sql1);
            
            while(rs2.next()){
                ArrayList<String> macrosTexts = new ArrayList<String>();    
                String txt = rs2.getString("txt");
                String sql = ("SELECT IIRTN_MctAddress,(SELECT IIPOS_MctName FROM `"+conta+"_positionhistory_iipos` WHERE IIPOS_MctAddress = IIRTN_MctAddress LIMIT 1) AS mctNome, IIRTN_Text FROM `"+conta+"_messagereturn_iirtn` where IIRTN_MacroNumber="+NumeroMacro+" and IIRTN_Text = '"+txt+"' and IIRTN_Text <> '' ORDER BY IIRTN_MessageTime ASC limit 1;");
                
                ResultSet rs = stmt.executeQuery(sql);
                
                String sql2 = ("SELECT * FROM `def_macro` WHERE usuario = '"+conta+"' AND macro = '"+NumeroMacro+"' AND versao = '"+versaoMacro+"';");
                ResultSet rsDef = stmt2.executeQuery(sql2);
                while(rs.next()){
                    rsDef.next();
                    System.out.println("definicao: "+rsDef.getString("tipo"));
                    Macros macro = new Macros();
                    String[] x = rs.getString("IIRTN_Text").split("_");
                    String[] y = rsDef.getString("tipo").split("_");
                    String[] z = rsDef.getString("text").split("_");
                    String comentario = "";
                    String manutencao = "";
                    for (int i = 1; i < x.length; i++) {
                        if(y[i].equals("4")){
                            comentario = comentario+" "+x[i];
                        }else if(y[i].equals("5")){
                            manutencao = manutencao+z[i]+"("+x[i]+")\n";
                        }else{
                            macrosTexts.add(x[i]);
                        }
                    }
                    System.out.println("COMENTARIO!!:   "+comentario);
                    macro.setMct(rs.getString("IIRTN_MctAddress")+"/"+rs.getString("mctNome"));
                    macro.setTexto(macrosTexts);
                    macro.setComentario(comentario);
                    macro.setManutencao(manutencao);
                    macros.add(macro);
                }
                
                
            }          
            
        }catch(Exception e){
            System.out.println("ERRO NO METODO GETMACROTEXT");
            System.out.println(e);
        }
        System.out.println("------------------------- MACROS ----------------------");
        //System.out.println("MACROS: "+macros;
        return macros;
    }
    /**
     * metodo pesquisa macro por numero
     * @param conta String - Conta do usuario
     * @param con Connection
     * @param stmt1 Statement
     * @param NumeroMacro string - numero da macro a ser procurada
     * @return retorna um vetor bidimensional de Strings com os dados da Macro encontrada.
     */
    public String[][] getMacroPorNumero(String conta,Connection con, Statement stmt1, String NumeroMacro){
        String[][] macrosListados = new String[3][1000];
        
        try{
            
            String sql = ("SELECT * FROM `"+conta+"_messagereturn_iirtn` WHERE IIRTN_MacroNumber = '"+NumeroMacro+"'");
            ResultSet rs = stmt1.executeQuery(sql);
            int i=0;
            while(rs.next()){
                macrosListados[0][i] = rs.getString("IIRTN_MessageTime");
                macrosListados[1][i] = rs.getString("IIRTN_MctAddress");
                macrosListados[2][i] = rs.getString("IIRTN_Text");
            }
        }catch(Exception e){
            System.out.println("ERRO NO METODO GETMACROPORNUMERO");
            System.out.println(e);
        }
        
        return macrosListados;
    }
    /**
     * Metodo verifica se uma macro tem uma definição
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt1 Statement
     * @param NumeroMacro String - numero da macro verificada
     * @return Retorna um boolean, true se existir definição, false se não existir.
     */
    public boolean defExiste(String conta,Connection con, Statement stmt1, String NumeroMacro, String versaoMacro){
        boolean existe = false;
        System.out.println("ENTROU NO METODO DEFEXISTE");
        
        try{
            String sql = ("SELECT * FROM `def_macro` WHERE macro="+NumeroMacro+" AND versao ="+versaoMacro+" AND usuario ="+conta+";");
            ResultSet rs = stmt1.executeQuery(sql);
            if(rs.next()){
                System.out.println("definição da macro n: "+NumeroMacro+" v: "+versaoMacro+" Existe!");
                existe = true;
            }else{
                System.out.println("macro n: "+NumeroMacro+" v: "+versaoMacro+" não definida!");
            }
        }catch(Exception e){
            System.out.println("ERRO NO METODO DEFEXISTE");
            System.out.println(e);
        }
        return existe;
    }
    
    /**
     * Metodo utilizado para apagar textos duplicados nas macros.
     */
    public void apagaDuplicados(String conta){
        String[][] macros = new String[2][10000];
            
        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
            Statement stmt2 = con.createStatement();
            Statement stmt3 = con.createStatement();
            String sql1 = ("SELECT DISTINCT IIRTN_Text FROM `"+conta+"_messagereturn_iirtn`");
            ResultSet rs = stmt.executeQuery(sql1);
            int t=0;
            int i=0;
            while(rs.next()){   
                System.out.println("ENTROU NO PRIMEIRO WHILE");
                System.out.println("t: "+t);
                System.out.println("IIRTN_TEXT: "+rs.getString("IIRTN_Text"));
                String text = rs.getString("IIRTN_Text");
                if(text.contains("\\")){
                    System.out.println("----------------ENTROU NO IF DO \\---------------");
                    text.replace("\\", " ");
                }
                sql1 = ("SELECT * FROM `"+conta+"_messagereturn_iirtn` WHERE IIRTN_Text = '"+rs.getString("IIRTN_Text")+"' ORDER BY `"+conta+"_messagereturn_iirtn`.`IIRTN_PositionTime` ASC LIMIT 1");
                ResultSet rs2 = stmt2.executeQuery(sql1);
                if(rs2.next()){
                    System.out.println("ENTROU NO SEGUNDO WHILE");
                    macros[0][i] = rs2.getString("IIRTN_ID");
                    macros[1][i] = rs2.getString("IIRTN_Text");
                    System.out.println("I: "+i+" IIRTN_ID: "+macros[0][i]+" Texto: "+macros[1][i]);
                    i++;                  
                }else{
                    System.out.println("nullo");
                }
                t++;
            }
            for (int j = 0; j < 100; j++) {
                if(macros[0][j] == null){
                    j = 200;
                }else{
                    String sql3 = ("UPDATE `"+conta+"_messagereturn_iirtn` SET `IIRTN_Text`= '' WHERE IIRTN_Text = '"+ macros[1][j]+"' and idauto <> '"+ macros[0][j]+"'");
                    stmt3.executeUpdate(sql3);
                }
            }
            
            System.out.println("METODO APAGADUPLICADOS FINALIZADO COM SUCESSO");
            System.out.println("TEXTOS DUPLICADOS NA TABELA "+conta+"_MESSAGERTURN_IIRTN FORAM MODIFICADOS");
            
        } catch (SQLException ex) {
            System.out.println("ERRO NO METODO APAGADUPLICADOS");
            System.out.println(ex);
            Logger.getLogger(MacroDao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
