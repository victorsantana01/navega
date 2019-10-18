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

/**
 *
 * @author Victor Santana
 */
public class ConsumoDao {
    
  
    public String [][] tabela(String conta) {
       
         String[][] elemento = new String[29][100];
       
        
 
        String Relatorio = null;

   
        String SqlQueryIgn = ("SELECT * FROM exporta.motor_tab where conta='"+conta+"';");


        try {
           Connection con = ConexaoMySQL.getConexaoMySQL();
           Statement stm = con.createStatement();

            ResultSet rs = stm.executeQuery(SqlQueryIgn);
            int i = 0;
            
            while (rs.next()) {
           
               
                elemento[0][i] = rs.getString("nome_motor");
                elemento[1][i] = rs.getString("500");
                elemento[2][i] = rs.getString("600");
                elemento[3][i] = rs.getString("700");
                elemento[4][i] = rs.getString("800");
                elemento[5][i] = rs.getString("900");
                elemento[6][i] = rs.getString("1000");
                elemento[7][i] = rs.getString("1100");
                elemento[8][i] = rs.getString("1200");
                elemento[9][i] = rs.getString("1300");
                elemento[10][i] = rs.getString("1400");
                elemento[11][i] = rs.getString("1500");
                elemento[12][i] = rs.getString("1600");
                elemento[13][i] = rs.getString("1700");
                elemento[14][i] = rs.getString("1800");
                elemento[15][i] = rs.getString("1900");
                elemento[16][i] = rs.getString("2000");
                elemento[17][i] = rs.getString("2100");
                elemento[18][i] = rs.getString("2200");
                elemento[19][i] = rs.getString("2300");
                elemento[20][i] = rs.getString("2400");
                elemento[21][i] = rs.getString("2500");
                elemento[22][i] = rs.getString("2600");
                elemento[23][i] = rs.getString("2700");
                elemento[24][i] = rs.getString("2800");
                elemento[25][i] = rs.getString("2900");
                elemento[26][i] = rs.getString("3000");
                elemento[27][i] = rs.getString("descricao");
                elemento[28][i] = rs.getString("idmotor_tab");
              
                 i++;
           
            }

            rs.close();
            stm.close();
            con.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }


return elemento;
    }

    
   public String[][] getTabelaConsumo(String conta) {
        String[][] elemento = new String[31][50];
 
        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();

            //Query sql que vai pro mysql
            String sqlPainel;

            /*sqlPainel=("SELECT idmotor_tab,nome_motor, `500`, `600`, `700`, `800`, `900`, `1000`, `1100`, `1200`, `1300`, `1400`, `1500`, `1600`, `1700`, `1800`,\n" +
" `1900`, `2000`,`2100`, `2200`, `2300`, `2400`, `2500`, `2600`, `2700`, `2800`, `2900`,\n" +
" `3000`, descricao FROM exporta.motor_tab;");*/
            sqlPainel = "SELECT * FROM exporta.motor_tab where conta='"+conta+"';";
                    
            ResultSet rs = stmt.executeQuery(sqlPainel);
   
            int i =0;
            while (rs.next()) {
                
                elemento[0][i] = rs.getString("nome_motor");
                elemento[1][i] = rs.getString("500");
                elemento[2][i] = rs.getString("600");
                elemento[3][i] = rs.getString("700");
                elemento[4][i] = rs.getString("800");
                elemento[5][i] = rs.getString("900");
                elemento[6][i] = rs.getString("1000");
                elemento[7][i] = rs.getString("1100");
                elemento[8][i] = rs.getString("1200");
                elemento[9][i] = rs.getString("1300");
                elemento[10][i]= rs.getString("1400");
                elemento[11][i]= rs.getString("1500");
                elemento[12][i]= rs.getString("1600");
                elemento[13][i]= rs.getString("1700");
                elemento[14][i]= rs.getString("1800");
                elemento[15][i]= rs.getString("1900");
                elemento[16][i]= rs.getString("2000");
                elemento[17][i]= rs.getString("2100");
                elemento[18][i]= rs.getString("2200");
                elemento[19][i]= rs.getString("2300");
                elemento[20][i]= rs.getString("2400");
                elemento[21][i]= rs.getString("2500");
                elemento[22][i]= rs.getString("2600");
                elemento[23][i]= rs.getString("2700");
                elemento[24][i]= rs.getString("2800");
                elemento[25][i]= rs.getString("2900");
                elemento[26][i]= rs.getString("3000");
                elemento[27][i]= rs.getString("descricao");
                elemento[28][i]= rs.getString("400");
                elemento[29][i]= rs.getString("idmotor_tab");
                         
               
                
                i++;
                  
            }
           System.out.println("Get tabela de consumo OK!");
            rs.close();
            stmt.close();
            con.close();
            
        } catch (Exception e) {
              System.out.println("ERRO Get tabela de consumo !\n"+e);
            
        }

        return elemento;
    }
   public String[] getConsumoById(String conta,Connection con, Statement stmt, String idMotor) {
        String[] elemento = new String[31];
 
        try {
            
            String sql = "SELECT * FROM `motor_tab` where conta='"+conta+"' and idmotor_tab='"+idMotor+"'";
                    
            ResultSet rs = stmt.executeQuery(sql);
            System.out.println("dentro do metodo getconsultabyid");
            if(rs.next()) {
                System.out.println("NOME DO MOTOR: "+elemento[0]);
                
                elemento[0] = rs.getString("nome_motor");
                elemento[1] = rs.getString("500");
                elemento[2] = rs.getString("600");
                elemento[3] = rs.getString("700");
                elemento[4] = rs.getString("800");
                elemento[5] = rs.getString("900");
                elemento[6] = rs.getString("1000");
                elemento[7] = rs.getString("1100");
                elemento[8] = rs.getString("1200");
                elemento[9] = rs.getString("1300");
                elemento[10]= rs.getString("1400");
                elemento[11]= rs.getString("1500");
                elemento[12]= rs.getString("1600");
                elemento[13]= rs.getString("1700");
                elemento[14]= rs.getString("1800");
                elemento[15]= rs.getString("1900");
                elemento[16]= rs.getString("2000");
                elemento[17]= rs.getString("2100");
                elemento[18]= rs.getString("2200");
                elemento[19]= rs.getString("2300");
                elemento[20]= rs.getString("2400");
                elemento[21]= rs.getString("2500");
                elemento[22]= rs.getString("2600");
                elemento[23]= rs.getString("2700");
                elemento[24]= rs.getString("2800");
                elemento[25]= rs.getString("2900");
                elemento[26]= rs.getString("3000");
                elemento[27]= rs.getString("descricao");
                elemento[28]= rs.getString("400");
                elemento[29]= rs.getString("idmotor_tab");
            }else{
                System.out.println("não existe motor");
            }
           System.out.println("Get tabela de consumo OK!");
            
        } catch (Exception e) {
              System.out.println("ERRO Get tabela de consumo !\n"+e);
            
        }

        return elemento;
    }
   
   
   public String getLitrosPorRpm(String conta, String nomeMotor, String rpm ) {
        String elemento = null ;
        int intRpm = Integer.parseInt(rpm);
        if (intRpm < 400) {
           intRpm = 0;
           rpm = String.valueOf(intRpm);
       }
 
        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();

            //Query sql que vai pro mysql
            String sqlPainel;

            sqlPainel=("SELECT  `0`,`400`,`500`, `600`, `700`, `800`, `900`, `1000`, `1100`, `1200`, `1300`, `1400`, `1500`, `1600`, `1700`, `1800`,\n" +
" `1900`, `2000`,`2100`, `2200`, `2300`, `2400`, `2500`, `2600`, `2700`, `2800`, `2900`,\n" +
" `3000`, descricao FROM exporta.motor_tab where nome_motor ='"+nomeMotor+"' and conta='"+conta+"';");
            ResultSet rs = stmt.executeQuery(sqlPainel);
   
            int i =0;
            while (rs.next()) {
                
               
                if (rs.getString(""+rpm+"") != null ) {
                    elemento = rs.getString(""+rpm+"");
                    
                }else{
                    elemento = "0";
                }
               
                System.out.println("Litrossssssssss: "+elemento);
                
                i++;
                  
            }
          
            rs.close();
            stmt.close();
            con.close();
            
        } catch (Exception e) {
            System.out.println("Falha na coleta de litros...");
            System.out.println("Erro: "+e);
            
        }

        return elemento;
    }
    
     public void incluirFaixa(String conta,
             String nomeMotor,
             String rpm400,
             String rpm500,
             String rpm600,
             String rpm700,
             String rpm800,
             String rpm900,
             String rpm1000,
             String rpm1100,
             String rpm1200,
             String rpm1300,
             String rpm1400,
             String rpm1500,
             String rpm1600,
             String rpm1700,
             String rpm1800,
             String rpm1900,
             String rpm2000,
             String rpm2100,
             String rpm2200,
             String rpm2300,
             String rpm2400,
             String rpm2500,
             String rpm2600,
             String rpm2700,
             String rpm2800,
             String rpm2900,
             String rpm3000,
             String descricao) {

        try {
      
        
          Connection con = ConexaoMySQL.getConexaoMySQL();
          Statement stmt = con.createStatement();

            // Prepare a statement to insert a record  
            
            String sql = ("INSERT INTO `exporta`.`motor_tab` (`nome_motor`, `400`, `500`, `600`, `700`, `800`,"
                    + " `900`, `1000`, `1100`, `1200`, `1300`, `1400`, `1500`, `1600`, `1700`, `1800`,"
                    + " `1900`, `2000`, `2100`, `2200`, `2300`, `2400`, `2500`, `2600`, `2700`, `2800`,"
                    + " `2900`, `3000`, `descricao`, `conta`)"
                    + " VALUES ('"+nomeMotor+"', '"+rpm400+"', '"+rpm500+"', '"+rpm600+"', '"+rpm700+"',"
                    + " '"+rpm800+"', '"+rpm900+"', '"+rpm1000+"', '"+rpm1100+"', '"+rpm1200+"', '"+rpm1300+"'"
                    + ", '"+rpm1400+"', '"+rpm1500+"', '"+rpm1600+"', '"+rpm1700+"', '"+rpm1800+"', '"+rpm1900+"'"
                    + ", '"+rpm2000+"', '"+rpm2100+"', '"+rpm2200+"', '"+rpm2300+"', '"+rpm2400+"', '"+rpm2500+"',"
                    + " '"+rpm2600+"', '"+rpm2700+"', '"+rpm2800+"', '"+rpm2900+"', '"+rpm3000+"', '"+descricao+"', '"+conta+"');");     
            stmt.executeUpdate(sql);
        System.out.println("Tabela salva com sucesso!!!!!");
        } catch (SQLException e) {
             System.out.println("ERRO AO TENTAR SALVAR TABELA!!!!!\n"+e);
        }
    }
     public void editarFaixa(String conta,Connection con, Statement stmt, String idMotor, String nomeMotor, String rpm400, String rpm500, String rpm600, String rpm700,
             String rpm800, String rpm900, String rpm1000, String rpm1100, String rpm1200, String rpm1300, String rpm1400, String rpm1500,
             String rpm1600, String rpm1700, String rpm1800, String rpm1900, String rpm2000, String rpm2100, String rpm2200, String rpm2300,
             String rpm2400, String rpm2500, String rpm2600, String rpm2700, String rpm2800, String rpm2900, String rpm3000, String descricao) {

        try {

            // Prepare a statement to insert a record  
            
            String sql = ("UPDATE `motor_tab` SET `nome_motor` = '"+nomeMotor+"', `500` = '"+rpm500+"', `600` = '"+rpm600+"', `700` = '"+rpm700+"',"
                    + " `800` = '"+rpm800+"', `900` = '"+rpm900+"', `1000` = '"+rpm1000+"', `1100` = '"+rpm1100+"', `1200` = '"+rpm1200+"',"
                    + " `1300` = '"+rpm1300+"', `1400` = '"+rpm1400+"', `1500` = '"+rpm1500+"', `1600` = '"+rpm1600+"', `1700` = '"+rpm1700+"',"
                    + " `1800` = '"+rpm1800+"', `1900` = '"+rpm1900+"', `2000` = '"+rpm2000+"', `2100` = '"+rpm2100+"', `2200` = '"+rpm2200+"',"
                    + " `2300` = '"+rpm2300+"', `2400` = '"+rpm2400+"', `2500` = '"+rpm2500+"', `2600` = '"+rpm2600+"', `2700` = '"+rpm2700+"',"
                    + " `2800` = '"+rpm2800+"', `2900` = '"+rpm2900+"', `3000` = '"+rpm3000+"', `400` = '"+rpm400+"' WHERE `motor_tab`.`idmotor_tab` = '"+idMotor+"' and conta='"+conta+"';");
                    
            stmt.executeUpdate(sql);
        System.out.println("Tabela editada com sucesso!!!!!");
        } catch (SQLException e) {
             System.out.println("ERRO AO TENTAR EDITAFAIXA!!!!!\n"+e);
        }
    }
     public void faixa(String conta, String nomeMotor,String faixa, String litros, String descricao) {

        try {
      
        
          Connection con = ConexaoMySQL.getConexaoMySQL();
          Statement stmt = con.createStatement();

            // Prepare a statement to insert a record  
            String sql = ("INSERT INTO `exporta`.`tab_consumo` (`nome_motor`, `faixa_rpm`, `litros_hora`, `descricao`,`conta`)"
                    + " VALUES ('"+nomeMotor+"', '"+faixa+"', '"+litros+"', '"+descricao+"', `"+conta+"`);");
                   
            stmt.executeUpdate(sql);
            System.out.println("Tabela salva com sucesso!!!!!");
        } catch (SQLException e) {

        }

    }
    public String consumo(String litros, String minutos) {

        String consumo = "";

        int h = 60;
        int consumoInt;
        int litrosInt = Integer.valueOf(litros);
        int minutosInt = Integer.valueOf(minutos);

        consumoInt = litrosInt * minutosInt / h;

        consumo = Integer.toString(consumoInt);
        System.err.println("Consumo é: " + consumo + " litro(s)");
        return consumo;
    }
    
   public String arredondamento(String entrada){
       if (entrada.equals("65535")) {
        entrada = "0";   
       }
      String resultado = null;
      String []vetEntrada = entrada.split("");
      if(vetEntrada.length==3){
          entrada = vetEntrada[0]+"00";
      }
         if(vetEntrada.length==4){
          entrada = vetEntrada[0]+vetEntrada[1]+"00";
      }
      
      System.err.println("Valor Arredondado é: " + entrada);
      
      return resultado; 
   }
   public void excluirFaixa(String conta,Connection con, Statement stmt, String idMotor){
       try{
           String sql = ("DELETE FROM `motor_tab` WHERE idmotor_tab = "+idMotor+" and conta = "+conta+";");
           stmt.executeUpdate(sql);
           System.out.println("EXCLUSÃO REALIZADA COM SUCESSO");
       }catch(Exception e){
           System.out.println("ERRO NO METODO EXCLUIRFAIXA");
           System.out.println(e);
       }
   }
}
