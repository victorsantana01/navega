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
import logic.Format;

/**
 *
 * @author ricardson
 */
public class MacroDao {
    
    
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
    
    public String[][] getMacroById(String conta,Connection con, Statement stmt, String id){
        String[][] macroSelecionada = new String[100][2];
        
        try{
            
            String sql = ("SELECT IIRTN_MacroNumber, IIRTN_Text, IIRTN_MacroVersion "
                    + "FROM `"+conta+"_messagereturn_iirtn` WHERE idAuto = '"+id+"'");
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                int total = rs.getString("IIRTN_Text").split("_").length;
                macroSelecionada[0][0] = rs.getString("IIRTN_MacroNumber");                 //NUMERO DA MACRO
                macroSelecionada[1][0] = rs.getString("IIRTN_Text");                        //TEXTO
                System.out.println("texto: "+macroSelecionada[1][0]);
                macroSelecionada[2][0] = ""+rs.getString("IIRTN_MacroVersion");                 //Version
                System.out.println("total: "+macroSelecionada[2][0]);
                System.out.println("array length: "+macroSelecionada.length);
                for (int i = 3; i < total+2; i++) {
                    macroSelecionada[i][0] = rs.getString("IIRTN_Text").split("_")[i-2];
                    System.out.println(i+" : "+macroSelecionada[i][0]);
                }
            }
            
        }catch(Exception e){
            System.out.println("ERRO NO METODO GETMACRO!");
            System.out.println(e);
        }
            
        return macroSelecionada;
    }
    
    public void cadastrarMacro(String conta,Connection con, Statement stmt, String numeroMacro, String nome, String labels, String versao ){
        System.out.println("------------------------------");
        System.out.println("numeroMacro: "+numeroMacro);
        System.out.println("nome: "+nome);
        System.out.println("Labels: "+labels);
        System.out.println("versao: "+versao);
        try{
            
            String sql = ("INSERT INTO `def_macro`(`macro`, `nome`, `usuario`, `text`,`versao` ) VALUES ('"+numeroMacro+"','"+nome+"','"+conta+"','"+labels+"','"+versao+"')");
            stmt.executeUpdate(sql);
            System.out.println("MACRO "+numeroMacro+" SALVA COM SUCESSO!!!!!");
        }catch(Exception e){
            System.out.println("ERRO NO METODO CADASTRARMACRO");
            System.out.println(e);
        }
    }
    public void editarMacro(String conta,Connection con, Statement stmt, String numeroMacro, String nome, String labels, String versao ){
        System.out.println("------------------------------");
        System.out.println("numeroMacro: "+numeroMacro);
        System.out.println("nome: "+nome);
        System.out.println("Labels: "+labels);
        System.out.println("versao: "+versao);
        try{
            
            String sql = ("UPDATE `def_macro` SET `nome` = '"+nome+"', `text` = '"+labels+"' WHERE `def_macro`.`macro` = "+numeroMacro+";");
            stmt.executeUpdate(sql);
            System.out.println("MACRO "+numeroMacro+" EDITADA COM SUCESSO!!!!!");
        }catch(Exception e){
            System.out.println("ERRO NO METODO EDITARMACRO");
            System.out.println(e);
        }
    }
    
    public String[][] listarMacros(String conta,Connection con, Statement stmt1, Statement stmt2, Statement stmt3){
        String[][] macros = new String[6][100];
        try{
                        
            String sql = ("SELECT DISTINCT IIRTN_MacroNumber as macros FROM `"+conta+"_messagereturn_iirtn`");
            String sql3 = ("SELECT DISTINCT macro FROM def_macro");
            ResultSet rs = stmt2.executeQuery(sql);
            ResultSet rs3 = stmt3.executeQuery(sql3);
            String numeroDeMacros = "";
            while(rs3.next()){
                numeroDeMacros = numeroDeMacros+" AND IIRTN_MacroNumber <> "+rs3.getString("macro");
            }
            
            int i =0;
            while(rs.next()){
//                System.out.println("total: "+rs.getString("macros"));
                try{
                    String sql2 = ("SELECT * FROM `"+conta+"_messagereturn_iirtn` WHERE IIRTN_MacroNumber = '"+rs.getString("macros")+" "+numeroDeMacros+"' ORDER BY IIRTN_MacroNumber DESC LIMIT 1");
                    ResultSet rs2 = stmt1.executeQuery(sql2);
                    
                    while(rs2.next()){
                        macros[0][i] = rs2.getString("idAuto");
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
            
            
            String sql1 = ("SELECT DISTINCT(IIRTN_Text) FROM "+conta+"_messagereturn_iirtn where IIRTN_MacroNumber=3");
            ResultSet rs1 = stmt1.executeQuery(sql1);
            int i = 0;
            while(rs1.next()){
                System.out.println("entrou no while do result set 1");
                String text = rs1.getString("IIRTN_Text");
                System.out.println("text: "+text);
                String sql2 = ("SELECT me.IIRTN_MessageTime, me.IIRTN_MctAddress, me.IIRTN_Text, b.nome, mo.nome_motor\n" +
                            "FROM exporta."+conta+"_messagereturn_iirtn me \n" +
                            "left join barco b on me.IIRTN_MctAddress = b.mct\n" +
                            "left join motor_tab mo on b.motor = mo.idmotor_tab\n" +
                            "where IIRTN_MacroNumber = \"3\" and me.IIRTN_Text = '"+text+"'"+
                            " "+embarcacao+" "+data+
                            "order by me.IIRTN_MessageTime limit 1;");
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
                }else{
                    System.out.println("query vazia.");
                }
                
            }
            
            System.out.println("METODO PESQUISAMACRO REALIZADO COM SUCESSO 111111........... ");
        } catch (Exception e) {

            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.err.println("ERRO NO METODO PESQUISAMACRO 111111........... ");
        }

        return macros;
        
    }
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
    
    public String[][] getMacroDef(String conta,Connection con, Statement stmt, String NumeroMacro){
        String[][] macroDef = new String[100][1];
        System.out.println("METODO GETMACRODEF");
        try{
            String sql = ("SELECT * FROM `def_macro` WHERE macro='"+NumeroMacro+"'");
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                String x = rs.getString("text");
                for (int j = 0; j < x.split("_").length-1; j++) {
                    macroDef[j][0]= x.split("_")[j+1];
                    System.out.println(j+" : "+macroDef[j][0]);
                }
            }
            
        }catch(Exception e){
            System.out.println("ERRO NO METODO GETMACRODEF");
            System.out.println(e);
        }
        
        return macroDef;
    }
    public String getMacroName(String conta,Connection con, Statement stmt, String NumeroMacro){
        String macro = "";
        try{
            String sql = ("SELECT nome FROM `def_macro` WHERE macro="+NumeroMacro+" AND usuario ="+conta+";");
            ResultSet rs = stmt.executeQuery(sql);
            rs.next();
            macro = rs.getString("nome");
            System.out.println("nome: "+macro);
        }catch(Exception e){
            System.out.println("ERRO NO METODO GETMACRONOME");
            System.out.println(e);
        }
        return macro;
    }
    public String[][] getMacroText(String conta,Connection con, Statement stmt, String NumeroMacro){
        String[][] macrosTexts = new String[100][10000];
        
        try{
            String sql = ("SELECT IIRTN_Text FROM `"+conta+"_messagereturn_iirtn` where IIRTN_MacroNumber="+NumeroMacro+";");
            ResultSet rs = stmt.executeQuery(sql);
            int j = 0;
            while(rs.next()){
                String[] x = rs.getString("IIRTN_Text").split("_");
                
                for (int i = 0; i < x.length-1; i++) {
                    macrosTexts[i][j]= x[i+1];
                    System.out.println(i+":"+j+" = "+macrosTexts[i][j]);
                }
                j++;
                System.out.println(j+"º");
            }
            
        }catch(Exception e){
            System.out.println("ERRO NO METODO GETMACROTEXT");
            System.out.println(e);
        }
        
        return macrosTexts;
    }
    
    public String[][] getMacroPorNumero(String conta,Connection con, Statement stmt1, String NumeroMacro){
        String[][] macrosListados = new String[3][1000];
        
        try{
            
            String sql = ("SELECT * FROM `268477387_messagereturn_iirtn` WHERE IIRTN_MacroNumber = '"+NumeroMacro+"'");
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
    
}
