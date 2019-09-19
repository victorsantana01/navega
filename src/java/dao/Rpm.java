/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import fabricaConexao.ConexaoMySQL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.swing.JOptionPane;

/**
 *
 * @author Victor Santana
 */
public class Rpm {
    private String rpm;
    private int numRowRpm;
     private String[] veiculo;
     private int IdMct;
     


     //------------------------------------------------------------------------//
    public String [][] getRpm(String conta, Connection con, Statement stmt, String begin, String finish, String mct) {
         //VisitaDao v =new VisitaDao();v.setNumRow();
        
            
        String[][] vetRelatorio = new String[7][2500];
        //SCRIPT IGN
        String SqlQueryIgn = ("SELECT * FROM exporta."+conta+"messagereturn_iirtn WHERE  IIRTN_MessageTime "
                + "BETWEEN ('"+begin+" 00:00:00"+"') "
                + "AND ('"+finish+" 23:59:00"+"') and IIRTN_RPM > '0' "
                + "and IIRTN_MctAddress='"+mct+"';");
        //É iniciada a variavel "Relatorio" que depois receberá os valores do objeto "rs"
        //Conexão
       
        try {
            ResultSet rs = stmt.executeQuery(SqlQueryIgn);
            con.setAutoCommit(false);
            System.out.println("Opened database successfully");
            stmt = (Statement) con.createStatement();
            int n =0;
            int i = 0;
            String velocidade = "";
            while (rs.next()) {
              
                vetRelatorio[0][i]= rs.getString("IIRTN_RPM");//RPM
                if (vetRelatorio[0][i].equals("65535")) {
                    vetRelatorio[0][i] ="0";
                }
                
                vetRelatorio[1][i]= rs.getString("IIRTN_MctAddress");//MCT
                vetRelatorio[2][i]= rs.getString("IIRTN_MessageTime");//Hora RPM
                
                vetRelatorio[3][i]= rs.getString("IIRTN_Landmark");//Referencia
                String vetVel [] = vetRelatorio[3][i].split(",");
                if (vetVel.length == 3) {
                     velocidade = vetVel[2];
                }else{
                    velocidade = vetVel[3];
                }
               
                velocidade = velocidade.replace(" ", "");
                velocidade = velocidade.replace("Km/h", "");
                
                vetRelatorio[4][i]= rs.getString("IIRTN_Velocity");//RPM2
                
                if(vetRelatorio[0][i] == null){
                    vetRelatorio[0][i]="0";
                }
                
                if(vetRelatorio[4][i] == null){
                    vetRelatorio[4][i]="0";
                }
                
                 if (vetRelatorio[4][i].equals("65535")) {
                    vetRelatorio[4][i] ="0";
                }
                vetRelatorio[6][i] = velocidade;
                i++;
                //System.out.println("Velocidade:"+velocidade);
                
            }
            rs.last();
            n = rs.getRow();
            vetRelatorio[5][0] = String.valueOf(n);
            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
              System.out.println("ERRO NO METODO getRpm ........... ");
            System.out.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }

        return vetRelatorio;
    }
     //------------------------------------------------------------------------//
    public String [][] getLatLongRpm(String conta, Connection con, Statement stmt, String begin, String finish, String mct, String rpm) {
         //VisitaDao v =new VisitaDao();v.setNumRow();
        
            
        String[][] vetRelatorio = new String[7][2500];
        //SCRIPT IGN
        String SqlQueryIgn = ("SELECT * FROM exporta."+conta+"messagereturn_iirtn WHERE  IIRTN_MessageTime "
                + "BETWEEN ('"+begin+" 00:00:00"+"') "
                + "AND ('"+finish+" 23:59:00"+"') and IIRTN_RPM = '"+rpm+"' "
                + "and IIRTN_MctAddress='"+mct+"';");
        //É iniciada a variavel "Relatorio" que depois receberá os valores do objeto "rs"
        //Conexão
     
        try {
            ResultSet rs = stmt.executeQuery(SqlQueryIgn);
            con.setAutoCommit(false);
            System.out.println("Opened database successfully");
            stmt = (Statement) con.createStatement();
           
            int i = 0;
            while (rs.next()) {
              
                vetRelatorio[0][i]= rs.getString("IIRTN_RPM");//RPM
                vetRelatorio[1][i]= rs.getString("IIRTN_MctAddress");//MCT
                vetRelatorio[2][i]= rs.getString("IIRTN_MessageTime");//Hora RPM
                vetRelatorio[3][i]= rs.getString("IIRTN_Landmark");//Referencia
                vetRelatorio[4][i]= rs.getString("IIRTN_Velocity");//RPM2
                if(vetRelatorio[0][i] == null){
                    vetRelatorio[0][i]="0";
                }
                if(vetRelatorio[4][i] == null){
                    vetRelatorio[4][i]="0";
                }
                vetRelatorio[5][i]= rs.getString("IIRTN_Latitude");//Lat
                vetRelatorio[6][i]= rs.getString("IIRTN_Longitude");//Long
                i++;
                
            }
                          System.out.println("METODO getRpm ESTÁ OK........... ");

            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
              System.out.println("ERRO NO METODO getRpm ........... ");
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }

        return vetRelatorio;
    }

    public void setRpm(String rpm) {
        this.rpm = rpm;
    }

    public int getNumRowRpm() {
        return numRowRpm;
    }

    public void setNumRowRpm(String conta, Connection con, Statement stmt, String begin, String finish, String mct ) {
         //VisitaDao v =new VisitaDao();v.setNumRow();
        int i=0;
            
       
        //SCRIPT IGN
        String SqlQueryIgn = ("SELECT * FROM exporta.messagereturn_iirtn WHERE  IIRTN_MessageTime "
                + "BETWEEN ('"+begin+" 00:00:00"+"') "
                + "AND ('"+finish+" 23:59:00"+"') and IIRTN_RPM > '0' "
                + "and IIRTN_MctAddress='"+mct+"';");
        //É iniciada a variavel "Relatorio" que depois receberá os valores do objeto "rs"
        //Conexão

        try {
            ResultSet rs = stmt.executeQuery(SqlQueryIgn);
            con.setAutoCommit(false);
            System.out.println("Opened database successfully");
            stmt = (Statement) con.createStatement();
           
           
            rs.last();
            i = rs.getRow();
            
              //System.out.println("ERRO NO METODO SETNUMROWRPM ........... ");

            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
                          System.out.println("ERRO NO METODO SETNUMrOWRPM ........... ");

            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }

//	       System.out.println("Operation done successfully");
            this.numRowRpm=i;
       
    }
    
    //------------------------------------------------------------------------//     
    public void setVeiculo(String conta, Connection con, Statement stmt) {
         Rpm veiMct = new Rpm();
         veiMct.setIdMct(conta, con, stmt);
        int lengthVetor = veiMct.getIdMct();
        String[] position = new String[lengthVetor];
       
        
        
        //Associar_contrato asscontrat = new Associar_contrato();

        String Relatorio = null;

        //SCRIPT IGN
        String SqlQueryIgn = ("SELECT DISTINCT(IIPOS_MctAddress) FROM exporta.positionhistory_iipos;");


        try {

            ResultSet rs = stmt.executeQuery(SqlQueryIgn);
            int i = 0;
            while (rs.next()) {
           
                Relatorio = rs.getString("IIPOS_MctAddress");
                if (!Relatorio.equals(null)) {
                    position[i] = Relatorio;
                   
                }
                 i++;
                //listVeiculo.add(position[i]);
                // asscontrat.choiceVeiculo.addItem(position[i]);
                // System.out.println(position[i]);
            }

            rs.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }

//	       System.out.println("Operation done successfully");
        this.veiculo = position.clone();

    }

    public String[] getVeiculo() {
        return veiculo;
    }
    
    public void setIdMct(String conta, Connection con, Statement stmt) {
        int i=0;
        int Relatorio = 0;
        //Associar_contrato asscontrat = new Associar_contrato();

        //SCRIPT
        String SqlQueryIgn = ("select distinct iipos_mctaddress as mcts from positionhistory_iipos");

try {
      
    
    ResultSet rs = stmt.executeQuery(SqlQueryIgn);
    
    rs.last();
    i = rs.getRow();
    
    rs.close();
} catch (Exception e) {
    System.err.println(e.getClass().getName() + ": " + e.getMessage());
    System.exit(0);
}

//	       System.out.println("Operation done successfully");
this.IdMct=i;
System.err.println("com o rs.getRow();"+ i);
    }

    public int getIdMct() {
        System.out.println("ultimo ID No get "+this.IdMct);
        return IdMct;
    }
    //------------------------------------------------------------------------//
    
    
     public String getMctNome(String conta, Connection con, Statement stmt, String mct) {
        String queryRelatorio;
         
  
        String vetRelatorio = null;

        try {
              
                  queryRelatorio = ("select max(iipos_mctname) as MCT from positionhistory_iipos where iipos_mctaddress ='"+mct+"';");
           
               ResultSet rs = stmt.executeQuery(queryRelatorio);

            int i =0;
          
            while (rs.next()) {
                
                
                
                vetRelatorio = rs.getString("MCT");
                
                i++;
                  
            }
            
        
        } catch (Exception e) {
            
            
        }
     
        return vetRelatorio;
    } 
    
     public String[][] listarEquipamentos(String conta, Connection con, Statement stmt) {
        String queryRelatorio;
         
  
        String[][] vetRelatorio = new String[4][200];

        try {
            
               queryRelatorio = ("SELECT * FROM exporta.positionhistory_iipos;");
           
               ResultSet rs = stmt.executeQuery(queryRelatorio);

            int i =0;
          
            while (rs.next()) {
                
                
                vetRelatorio[0][i] = rs.getString("IIPOS_MctAddress");
                vetRelatorio[1][i] = rs.getString("IIPOS_MctName");
                
                i++;
                  
            }
            
            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            
            
        }
     
        return vetRelatorio;
    }
    
       public String  deslocamento(String begin, String finish, String mct) {
         //VisitaDao v =new VisitaDao();v.setNumRow();
        
            
        String resultado = null;
        //SCRIPT IGN
        String SqlQueryIgn = ("SELECT CONVERT((SELECT \n" +
"(acos(sin(radians((max(IIPOS_Latitude)))) * sin(radians((min(IIPOS_Latitude)))) +\n" +
"\n" +
"cos(radians((max(IIPOS_Latitude)))) * cos(radians((min(IIPOS_Latitude)))) *\n" +
"\n" +
"cos(radians((max(IIPOS_Longitude))) - radians((min(IIPOS_Longitude))))) * 6378) as DISTANCIA \n" +
"FROM positionhistory_iipos WHERE IIPOS_TIMEPOSITION \n" +
"BETWEEN \""+begin+"\" AND \""+finish+"\" AND IIPOS_MctAddress=\""+mct+"\"), CHAR) AS DISTANCIA;");
       
    
        try {
             Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(SqlQueryIgn);
            con.setAutoCommit(false);
            System.out.println("Opened database successfully");
            stmt = (Statement) con.createStatement();
           
           
            while (rs.next()) {
              
                resultado= rs.getString("DISTANCIA");//RPM
                if (resultado == null) {
                    resultado="0";
                }
                //System.out.println("Teste de Distancia - - - - - "+resultado);
                 
                
            }
            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }

        return resultado;
    }
    
        public String [][] getPrincipalRpm(String begin, String finish, String mct,Connection con,Statement stmt) {
         //VisitaDao v =new VisitaDao();v.setNumRow();
        
            
        String[][] vetRelatorio = new String[7][2000];
        //SCRIPT IGN
        String SqlQueryIgn = (" SELECT DISTINCT IIRTN_RPM AS RPM,\n" +
"COUNT('iIRTN_RPM')*15 AS TEMPO_MIN, COUNT('IIRTN_RPM') AS N_REG,  IIRTN_Latitude AS LAT,  IIRTN_Longitude AS LON\n" +
"from messagereturn_iirtn\n" +
"where IIRTN_MctAddress='"+mct+"'and IIRTN_MessageTime between '"+begin+" 00:00:00' and '"+finish+" 23:59:59' and IIRTN_RPM > '0'\n" +
"group by IIRTN_RPM ORDER BY IIRTN_RPM DESC;");
        
        //É iniciada a variavel "Relatorio" que depois receberá os valores do objeto "rs"
        //Conexão
      
        try {
            
            ResultSet rs = stmt.executeQuery(SqlQueryIgn);
            con.setAutoCommit(false);
            System.out.println("Opened database successfully");
            stmt = (Statement) con.createStatement();
           
            int i = 0;
            int n = 0;
            while (rs.next()) {
              
                vetRelatorio[0][i]= rs.getString("RPM");
                if(vetRelatorio[0][i] == null){
                    vetRelatorio[0][i] = "0";
                }
                vetRelatorio[1][i]= rs.getString("TEMPO_MIN");
                if(vetRelatorio[1][i] == null){
                    vetRelatorio[1][i] = "0";
                }
                vetRelatorio[2][i]= rs.getString("N_REG");
                vetRelatorio[3][i]= rs.getString("LAT");
                vetRelatorio[4][i]= rs.getString("LON");
                System.out.println(" coleta de rpm principal 1 !!"+ vetRelatorio[3][i]);
                        
                        
                  i++;
                
            }
            rs.last();
            n = rs.getRow();
            vetRelatorio[4][0] = String.valueOf(n);
            System.out.println(" QTD-------------------------- !!"+ vetRelatorio[4][0]);
            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Falha na coleta de rpm principal!!");
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }

        return vetRelatorio;
    }
        public String [][] getPrincipalRpm2(String conta, Connection con, Statement stmt, String begin, String finish, String mct) {
         //VisitaDao v =new VisitaDao();v.setNumRow();
        
            
        String[][] vetRelatorio = new String[7][2000];
        //SCRIPT IGN
          String SqlQueryIgn = (" \n" +
" SELECT DISTINCT IIRTN_Velocity AS RPM,\n" +
"COUNT('IIRTN_Velocity')*15 AS TEMPO_MIN,\n" +
"COUNT('IIRTN_Velocity') AS N_REG,  IIRTN_Latitude AS LAT,  IIRTN_Longitude AS LON\n" +
"from messagereturn_iirtn\n" +
"where IIRTN_MctAddress='"+mct+"' and \n" +
"IIRTN_MessageTime between '"+begin+" 00:00:00"+"' and '"+finish+" 23:59:59"+"' and IIRTN_Velocity > '0'  \n" +
"group by IIRTN_Velocity ORDER BY IIRTN_Velocity DESC;");
        
        //É iniciada a variavel "Relatorio" que depois receberá os valores do objeto "rs"
        //Conexão
   
        try {
            ResultSet rs = stmt.executeQuery(SqlQueryIgn);
            con.setAutoCommit(false);
            System.out.println("Opened database successfully");
            stmt = (Statement) con.createStatement();
           
            int i = 0;
            while (rs.next()) {
              
                vetRelatorio[0][i]= rs.getString("RPM");
                if(vetRelatorio[0][i] == null){
                    vetRelatorio[0][i] = "0";
                }
                vetRelatorio[1][i]= rs.getString("TEMPO_MIN");
                if(vetRelatorio[1][i] == null){
                    vetRelatorio[1][i] = "0";
                }
                vetRelatorio[2][i]= rs.getString("N_REG");
                vetRelatorio[3][i]= rs.getString("LAT");
                vetRelatorio[4][i]= rs.getString("LON");
                System.out.println(" coleta de rpm principal 2 !!"+ vetRelatorio[3][i]);
                  i++;
                
            }
            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Falha na coleta de rpm principal!!");
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }

        return vetRelatorio;
    }
        
        
  

       public String mctName(String conta, Connection con, Statement stmt, String mct) {
        String queryRelatorio;
         
  
        String vetRelatorio =null;
        try {

            
                  queryRelatorio = ("SELECT max(iipos_mctname) as MCT FROM exporta.positionhistory_iipos where IIPOS_MctAddress = \""+mct+"\" order by iipos_mctname");

               ResultSet rs = stmt.executeQuery(queryRelatorio);

          
            while (rs.next()) {
                
                
                vetRelatorio = rs.getString("MCT");
                
                
                  
            }
            
            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            
            
        }
     
        return vetRelatorio;
    }
    
       public int numMctName(String conta, Connection con, Statement stmt) {
        String queryRelatorio;
         int i= 0;
  
        String vetRelatorio =null;
        try {

            
                   queryRelatorio = ("SELECT * FROM exporta.positionhistory_iipos;");
           
               ResultSet rs = stmt.executeQuery(queryRelatorio);

          rs.last();
     
                
                i = rs.getRow();
                
                
                  
           
            
            rs.close();
        } catch (Exception e) {
            
            
        }
     
        return i;
    }
    
       
    public String[][] painelAtualizado(String conta,Connection con, Statement stmt, Statement stmt1, Statement stmt2) {
        
        String[][] vetRelatorio = new String[12][120];
        int l = 0;
        //Conexão
        try {
            String sqlPainel=("select distinct iipos_mctaddress AS MCT, count(*) AS total,\n" +
            "iipos_mctname as NOME, max(IIPOS_TimePosition)as HORA, \n" +
            "MAX(date(iipos_timeposition)) AS DATA, MAX(IIPOS_LATITUDE) AS LAT, \n" +
            "MAX(IIPOS_LONGITUDE) AS LON  from '"+conta+"'_positionhistory_iipos WHERE IIPOS_AccountNumber = '"+conta+"' group by iipos_mctaddress desc;");
             
   
                      
     
//-----------------------------------------------------------------------------------------------------//  

             
         String r1="0";
         String r2="0";
            ResultSet rs = stmt.executeQuery(sqlPainel);
        Rpm rp = new Rpm();
            int i =0;
            while (rs.next()) {
                l=rs.getRow();
                
                ;
                vetRelatorio[1][i] = rs.getString("MCT");
                vetRelatorio[2][i] = rs.getString("HORA");
               vetRelatorio[0][i] = rp.getMctNome(conta, con, stmt, vetRelatorio[1][i]);
                vetRelatorio[8][i] = rs.getString("LAT");
                vetRelatorio[9][i] = rs.getString("LON");
                vetRelatorio[5][i] = rp.rpmAtual1(conta,con,stmt1, vetRelatorio[1][i]);
                vetRelatorio[6][i] = rp.rpmAtual2( vetRelatorio[1][i],con,stmt1);
                if(vetRelatorio[5][i]==null){
                    vetRelatorio[5][i]="0";
                }
               if(vetRelatorio[6][i]==null){
                    vetRelatorio[6][i]="0";
                }
                i++;
               
      
              
                
            }
                          System.out.println("TUDO OK NO METODO PAINEL ........... ");

            rs.close();
        } catch (Exception e) {

            System.err.println(e.getClass().getName() + ": " + e.getMessage());
              System.err.println("Erro no painel!!!");
        }
   
    
       ;
        
        return vetRelatorio;
    }
        
    public String rpmAtual1(String conta, Connection con, Statement stmt, String mct) {
        
        String vetRelatorio = "";
        int l = 0;
        
        try {
              
           
            //Query sql que vai pro mysql
           
             String sqlPainel=("SELECT IIRTN_RPM, IIRTN_Velocity, IIRTN_MctAddress, IIRTN_MessageTime FROM exporta."+conta+"messagereturn_iirtn where IIRTN_MctAddress = \""+mct+"\" order by IIRTN_ID desc limit 1");

            ResultSet rs = stmt.executeQuery(sqlPainel);
        
            while (rs.next()) {
                vetRelatorio = rs.getString("IIRTN_RPM");
                if(vetRelatorio == null){
                    vetRelatorio="0";
                }
                if (vetRelatorio.equals("65535")) {
                    vetRelatorio ="0";
                }
            System.err.println("RPM ATUAL: "+vetRelatorio);
            }
          
        } catch (Exception e) {
      
             System.err.println("-NÃO FOI POSSIVEL PEGAR O RPM ATUAL"+l);
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            
        }
        return vetRelatorio;
    }
        
    public String rpmAtual2(String mct, Connection con, Statement stmt){
        
        String vetRelatorio = "";
        int l = 0;
        //Conexão
        try {
          
           
            //Query sql que vai pro mysql
           
             String sqlPainel=("SELECT IIRTN_RPM, IIRTN_Velocity, IIRTN_MctAddress, IIRTN_MessageTime FROM exporta.messagereturn_iirtn where IIRTN_MctAddress = \""+mct+"\" order by IIRTN_ID desc limit 1");

            ResultSet rs = stmt.executeQuery(sqlPainel);
        
            while (rs.next()) {
             
                vetRelatorio = rs.getString("IIRTN_Velocity");
                if (vetRelatorio == null) {
                    vetRelatorio="0";
                }
                 if (vetRelatorio.equals("65535")) {
                    vetRelatorio ="0";
                }
            System.err.println("RPM 2 ATUAL: "+vetRelatorio);
            }
           
           
        } catch (Exception e) {
      
             System.err.println("-NÃO FOI POSSIVEL PEGAR O RPM2 ATUAL"+l);
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            
        }
   
    
     
        
        return vetRelatorio;
    }
        
}
