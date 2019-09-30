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
    
}
