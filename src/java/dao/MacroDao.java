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
    
    public String[][] pesquisaMacro(){
        
        String[][] macros = new String[11][100];
        
        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
//            String sql = ("SELECT * FROM exporta.messagereturn_iirtn where IIRTN_AccountNumber = '268525817' and IIRTN_MacroNumber = '3' ");
            String sql = ("SELECT me.IIRTN_MessageTime, me.IIRTN_Text, b.nome, mo.nome_motor\n" +
                            "FROM exporta.messagereturn_iirtn me \n" +
                            "left join viagem v on me.IIRTN_MctAddress = v.nomeEmbarcacao \n" +
                            "left join barco b on v.nomeEmbarcacao = b.codBarco\n" +
                            "left join motor_tab mo on b.motor = mo.idmotor_tab\n" +
                            "where IIRTN_AccountNumber = '268525817' and IIRTN_MacroNumber = '3' ");

            ResultSet rs = stmt.executeQuery(sql);

            int i = 0;
            while (rs.next()) {


                String[] macroArray = rs.getString("me.IIRTN_Text").split("_",12);
                System.out.println("inicia MacroArray");
                System.out.println("macroArray.length: "+macroArray.length);
                for(int y=0;y<macroArray.length;y++){
                    System.out.println(y+" : "+macroArray[y]);
                }
                System.out.println("final MacroArray");
                Format format = new Format();
                String time = rs.getString("me.IIRTN_MessageTime");
/*0 DATA            */  macros[0][i] = format.DataFormat(rs.getString("me.IIRTN_MessageTime").split(" ")[0]);
/*1 EMBARCACAO      */  macros[1][i] = macroArray[2]; 
/*2 MANOBRA         */  macros[2][i] = macroArray[7];
/*3 MOTOR           */  macros[3][i] = rs.getString("mo.nome_motor");
/* DATAHORAINICIO  */   macros[4][i] = format.DataFormat(time.split(" ")[0])+" "+macroArray[4].substring(0,2)+":"+macroArray[4].substring(2,4);
/* DATAHORAFIM     */   macros[5][i] = format.DataFormat(time.split(" ")[0])+" "+macroArray[6].substring(0,2)+":"+macroArray[6].substring(2,4);
/* TEMPO           */   macros[6][i] = format.tempo(macroArray[4], macroArray[6]);
/* CONSUMO         */   macros[7][i] = macroArray[8];
/* SALDO           */   macros[8][i] = macroArray[1];
/* PORTO           */   macros[9][i] = macroArray[10];
/* CMT             */   macros[10][i] = macroArray[11];
/* CHEMAQ          */   macros[11][i] = macroArray[11]; 
                        i++;
            }
            System.out.println("METODO PESQUISAMACRO REALIZADO COM SUCESSO ........... ");
            rs.close();
        } catch (Exception e) {

            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.err.println("ERRO NO METODO PESQUISAMACRO ........... ");
        }

        return macros;
        
    }
    
}
