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
 * Classe criada para fazer consultas de RPM
 * @author Victor Santana
 */
public class Rpm {
    private String rpm;
    private int numRowRpm;
     private String[] veiculo;
     private int IdMct;
     


    /**
     * metodo faz a pesquisa de rpm de um mct especifico em uma espaço de tempo.
     * @param conta String - conta do usuario
     * @param begin String - data inicial a ser pesquisada
     * @param finish String - data de final a ser pesquisada
     * @param mct String - MCT do a ser pesquisado
     * @return retorna um vetor bidimensional de String com o Rpm encontrado.
     */
    public String [][] getRpm(String conta, String begin, String finish, String mct) {        
            
        String[][] vetRelatorio = new String[7][10000];
        //SCRIPT IGN
        String SqlQueryIgn = ("SELECT * FROM exporta."+conta+"_messagereturn_iirtn WHERE  IIRTN_MessageTime "
                + "BETWEEN ('"+begin+" 00:00:00"+"') "
                + "AND ('"+finish+" 23:59:00"+"') and IIRTN_RPM > '0' "
                + "and IIRTN_MctAddress='"+mct+"';");
        //É iniciada a variavel "Relatorio" que depois receberá os valores do objeto "rs"
        //Conexão
       
        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
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
          //  n = n-1;
            vetRelatorio[5][0] = String.valueOf(n);
            System.out.println("QUATIDADE DE LINHAS ************* "+vetRelatorio[5][0]);
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
    /**
     * metodo de pesquisa de latitude e longitude apartir de um mct e rpm
     * @param conta String - conta do usuario
     * @param begin String - data inicial a ser pesquisada
     * @param finish String - data final a ser pesquisada
     * @param mct String - MCT a ser pesquisado
     * @param rpm String - RPM a ser pesquisado
     * @return retorna um vetor bidimensional de Strings com os dados de messagereturn_iirtn, mais a latitude e longetude.
     */
    public String [][] getLatLongRpm(String conta, String begin, String finish, String mct, String rpm) {
         //VisitaDao v =new VisitaDao();v.setNumRow();
        
            
        String[][] vetRelatorio = new String[7][10000];
        //SCRIPT IGN
        String SqlQueryIgn = ("SELECT * FROM exporta."+conta+"_messagereturn_iirtn WHERE  IIRTN_MessageTime "
                + "BETWEEN ('"+begin+" 00:00:00"+"') "
                + "AND ('"+finish+" 23:59:00"+"') and IIRTN_RPM = '"+rpm+"' "
                + "and IIRTN_MctAddress='"+mct+"';");
        //É iniciada a variavel "Relatorio" que depois receberá os valores do objeto "rs"
        //Conexão
     
        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
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
    /**
     * Metodo altera a variavel NumRowRpm para o numero total de linhas de uma pesquisa de na tabela messagereturn_iirtn de uma determinada data e mct 
     * @param conta String - conta do usuario.
     * @param begin String - data inicial da pesquisa
     * @param finish String - data final da pesquisa
     * @param mct String - mct a ser pesquisado.
     */
    public void setNumRowRpm(String conta, String begin, String finish, String mct ) {
         //VisitaDao v =new VisitaDao();v.setNumRow();
        int i=0;
            
       
        //SCRIPT IGN
        String SqlQueryIgn = ("SELECT * FROM exporta."+conta+"_messagereturn_iirtn WHERE  IIRTN_MessageTime "
                + "BETWEEN ('"+begin+" 00:00:00"+"') "
                + "AND ('"+finish+" 23:59:00"+"') and IIRTN_RPM > '0' "
                + "and IIRTN_MctAddress='"+mct+"';");
        //É iniciada a variavel "Relatorio" que depois receberá os valores do objeto "rs"
        //Conexão

        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
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
    /**
     * Metodo seta o valor da vetor veiculo, para as posições de todos os mcts distintos da tabela positionhisty_iipos
     */
    public void setVeiculo() {
         Rpm veiMct = new Rpm();
         veiMct.setIdMct();
        int lengthVetor = veiMct.getIdMct();
        String[] position = new String[lengthVetor];
       
        
        
        //Associar_contrato asscontrat = new Associar_contrato();

        String Relatorio = null;

        //SCRIPT IGN
        String SqlQueryIgn = ("SELECT DISTINCT(IIPOS_MctAddress) FROM exporta.positionhistory_iipos;");


        try {
           Connection con = ConexaoMySQL.getConexaoMySQL();
           Statement stm = con.createStatement();

            ResultSet rs = stm.executeQuery(SqlQueryIgn);
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
            stm.close();
            con.close();
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
    /**
     * seta o idMct com o numero distinto de mcts na tabela positionhistory_iipos.
     */
    public void setIdMct() {
        int i=0;
        int Relatorio = 0;
        //Associar_contrato asscontrat = new Associar_contrato();

        //SCRIPT
        String SqlQueryIgn = ("select distinct iipos_mctaddress as mcts from positionhistory_iipos");

        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stm = con.createStatement();
            
            ResultSet rs = stm.executeQuery(SqlQueryIgn);

            rs.last();
            i = rs.getRow();

            rs.close();
            stm.close();
            con.close();
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
    
    /**
     * metodo retorna o nome de um mct pesquisado apartir do endereço de mct
     * @param conta String - conta do usuario
     * @param mct String - mct
     * @param con Connection
     * @param stmt Statement
     * @return retorna uma String com o nome do mct.
     */
    public String getMctNome(String conta, String mct, Connection con,Statement stmt ) {
        System.out.println("ENTROU NO METODO GETMCTNOME");
        String queryRelatorio;  
        String vetRelatorio = null;

        try {
              
            queryRelatorio = ("select max(iipos_mctname) as MCT from "+conta+"_positionhistory_iipos where iipos_mctaddress ='"+mct+"';");

            ResultSet rs = stmt.executeQuery(queryRelatorio);
            int i =0;

            while (rs.next()) {
                vetRelatorio = rs.getString("MCT");
                i++;      
            }
                    
        } catch (Exception e) {
            System.out.println("ERRO NO METODO GETMCTNOME");
            System.out.println(e);
            
        }
        System.out.println("SAIU DO METODO GETMCTNOME");
        return vetRelatorio;
    } 
    /**
     * Metodo lista os equipamentos, nomes de MCT e endereço de MCT
     * @param conta String - conta do usuario
     * @return retorna um vetor bidimensional de Strings com os dados do equimamento.
     */
    public String[][] listarEquipamentos(String conta) {
        String queryRelatorio;
         
  
        String[][] vetRelatorio = new String[4][200];

        try {
              Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();

            
                  queryRelatorio = ("SELECT * FROM exporta."+conta+"_positionhistory_iipos;");
           
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
    /**
     * Metodo retorna o deslocamento percorido por um equipamento mct
     * @param conta String - Conta do usuario
     * @param begin String - data inicial da pesquisa 
     * @param finish String - data final da pesquisa
     * @param mct String - mct do equipamento
     * @return retorna o deslocamento percorrido pelo equipamento no periodo de tempo determinado.
     */
    public String deslocamento(String conta, String begin, String finish, String mct) {
        
        String resultado = null;
        //SCRIPT IGN
        String SqlQueryIgn = ("SELECT CONVERT((SELECT \n" +
                                "(acos(sin(radians((max(IIPOS_Latitude)))) * sin(radians((min(IIPOS_Latitude)))) +\n" +
                                "\n" +
                                "cos(radians((max(IIPOS_Latitude)))) * cos(radians((min(IIPOS_Latitude)))) *\n" +
                                "\n" +
                                "cos(radians((max(IIPOS_Longitude))) - radians((min(IIPOS_Longitude))))) * 6378) as DISTANCIA \n" +
                                "FROM "+conta+"_positionhistory_iipos WHERE IIPOS_TIMEPOSITION \n" +
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
    /**
     * Metodo retorna os rpms de um determinado equipamento MCT
     * @param begin String - data inicial da pesquisa 
     * @param finish String - data final da pesquisa 
     * @param mct String - mct do equipamento
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @return retorna um vetor bidimensional de strings com os valores de rpm.
     */
    public String [][] getPrincipalRpm(String begin, String finish, String mct,String conta, Connection con,Statement stmt) {
         //VisitaDao v =new VisitaDao();v.setNumRow();
        System.out.println("------------------------ METODO GETPRINCIPALRPM ----------------------");
            
        String[][] vetRelatorio = new String[7][2000];
        //SCRIPT IGN
        String SqlQueryIgn = (" SELECT DISTINCT IIRTN_RPM AS RPM,\n" +
        "COUNT('iIRTN_RPM')*15 AS TEMPO_MIN, COUNT('IIRTN_RPM') AS N_REG,  IIRTN_Latitude AS LAT,  IIRTN_Longitude AS LON\n" +
        "from "+conta+"_messagereturn_iirtn\n" +
        "where IIRTN_MctAddress='"+mct+"'and IIRTN_MessageTime between '"+begin+"' and '"+finish+"' and IIRTN_RPM > '0'\n" +
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
                System.out.println("ACHOU REGISTROS");
              
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
        System.out.println("------- FIM METODO GETPRINCIPALRPM --------- ");
        return vetRelatorio;
    }
    /**
     * Metodo retorna os rpms de um segundo motor de um determinado equipamento MCT
     * @param conta String - Conta do cliente
     * @param begin String - data inicial da pesquisa 
     * @param finish String - data final da pesquisa 
     * @param mct String - mct do equipamento.
     * @return retorna um vetor bidimensional de strings com os valores de rpm.
     */
    public String [][] getPrincipalRpm2(String conta, String begin, String finish, String mct) {
    //VisitaDao v =new VisitaDao();v.setNumRow();
        
            
        String[][] vetRelatorio = new String[7][2000];
        //SCRIPT IGN
          String SqlQueryIgn = (" \n" +
" SELECT DISTINCT IIRTN_Velocity AS RPM,\n" +
"COUNT('IIRTN_Velocity')*15 AS TEMPO_MIN,\n" +
"COUNT('IIRTN_Velocity') AS N_REG,  IIRTN_Latitude AS LAT,  IIRTN_Longitude AS LON\n" +
"from "+conta+"_messagereturn_iirtn\n" +
"where IIRTN_MctAddress='"+mct+"' and \n" +
"IIRTN_MessageTime between '"+begin+"' and '"+finish+"' and IIRTN_Velocity > '0'  \n" +
"group by IIRTN_Velocity ORDER BY IIRTN_Velocity DESC;");
        
        //É iniciada a variavel "Relatorio" que depois receberá os valores do objeto "rs"
        //Conexão
   
        try {
        Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
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
    
    /**
     * Metodo busca um mct e retorna o seu nome.
     * @param conta String - conta do usuario
     * @param mct Strint - mct do equipamento.
     * @return retorna uma string com o nome do mct.
     */
    public String mctName(String conta, String mct) {
        String queryRelatorio;
         
  
        String vetRelatorio =null;
        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();

            
            queryRelatorio = ("SELECT max(iipos_mctname) as MCT FROM exporta."+conta+"_positionhistory_iipos where IIPOS_MctAddress = \""+mct+"\" order by iipos_mctname");

            ResultSet rs = stmt.executeQuery(queryRelatorio);

          
            while (rs.next()) {
                
                
                vetRelatorio = rs.getString("MCT");
                
                
                  
            }
            
            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Erro no metodo mctName");
            System.out.println(e);
        }
     
        return vetRelatorio;
    }
    /**
     * metodo pesquisa o numero de mcts encontrados no banco
     * @param conta
     * @return retorna um inteiro com o numero mcts.
     */
    public int numMctName(String conta) {
        String queryRelatorio;
         int i= 0;
  
        String vetRelatorio =null;
        try {
              Connection con = ConexaoMySQL.getConexaoMySQL();
                Statement stmt = con.createStatement();

                queryRelatorio = ("SELECT * FROM exporta."+conta+"_positionhistory_iipos;");
           
                ResultSet rs = stmt.executeQuery(queryRelatorio);

                rs.last();
                i = rs.getRow();
                
                rs.close();
        } catch (Exception e) {
            System.out.println("ERRO NO METODO numMctName");
            System.out.println(e);
        }
     
        return i;
    }
    /**
     * metodo pesquisa e retorna todas as embarcações ligadas ao usuario.
     * @param conta String - Conta
     * @param con Connection
     * @param stmt Statement
     * @return Retorna um vetor bidimensional de Strings com o mct e o nome da embarcação.
     */
    public String[][] nomeEmbarcacao(String conta,Connection con, Statement stmt, String idbarco){
        String[][] barcos = new String[2][120];
        String MctName = "";
        if(conta.equals("268477387")){
                MctName = " AND IIPOS_MctName like '%JOSE GUILHERME%'";
                System.out.println("possui J");
            }
        if(idbarco != ""){
            idbarco = " AND b.idbarco = "+idbarco+"";
        }
        //Conexão   
        try {
            String sql =("SELECT distinct(ph.IIPOS_MctAddress) as MCT, ph.IIPOS_MctName as nome, b.nome "
                    + "FROM "+conta+"_positionhistory_iipos ph LEFT JOIN barco b ON ph.IIPOS_MctAddress = b.mct "
                    + "WHERE 1=1 "+idbarco+" "+MctName);
            ResultSet rs = stmt.executeQuery(sql);
            
            int i =0;
            while (rs.next()) {
                
                barcos[1][i] = rs.getString("MCT");
                barcos[0][i] = rs.getString("nome");
                System.out.println("mct: "+barcos[1][i]+" - "+barcos[0][i]);
                i++;
                
            }
            System.out.println("METODO NOMEEMBARCACAO REALIZADO COM SUCESSO");
            
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.err.println("Erro no painel!!!");
        }
        return barcos;
            
    }
    /**
     * Metodo pesquisa o historico de posições das embarcações relacionadas ao cliente e apresenta suas posições.
     * @param conta String - conta do cliente
     * @param con Connection
     * @param stmt Statemente
     * @param stmt1 Statemente
     * @param stmt2 Statemente
     * @return retorna um vetor bidimensional de Strings com os dados e posições das embarcações.
     */
    public String[][] painelAtualizado(String conta,Connection con, Statement stmt, Statement stmt1, Statement stmt2) {
        
        String[][] vetRelatorio = new String[12][120];
        //Conexão
            String MctName = "";
        try {
            if(conta.equals("268477387")){
                MctName = " WHERE IIPOS_MctName like 'J%'";
                System.out.println("possui J");
            }
            String sqlPainel=("select distinct iipos_mctaddress AS MCT, count(*) AS total,\n" +
            "iipos_mctname as NOME, max(IIPOS_TimePosition)as HORA, \n" +
            "MAX(date(iipos_timeposition)) AS DATA, MAX(IIPOS_LATITUDE) AS LAT, \n" +
            "MAX(IIPOS_LONGITUDE) AS LON, IIPOS_Landmark AS LAND  from "+conta+"_positionhistory_iipos "
                    +MctName+" group by iipos_mctaddress desc;");
//-----------------------------------------------------------------------------------------------------//  

            String r1="0";
            String r2="0";
            ResultSet rs = stmt.executeQuery(sqlPainel);
            Rpm rp = new Rpm();
            int i =0;
            while (rs.next()) {
                vetRelatorio[0][i] = rs.getString("NOME");
                vetRelatorio[1][i] = rs.getString("MCT");
                vetRelatorio[2][i] = rs.getString("HORA");
                vetRelatorio[3][i] = rs.getString("LAND").split(",")[2];/*VELOCIDADE */
                vetRelatorio[4][i] =rs.getString("LAND").split(",")[1];/* LOCALIZAÇÃO */
                vetRelatorio[5][i] = rp.rpmAtual1( conta,con,stmt1,vetRelatorio[2][i]);
                vetRelatorio[6][i] = rp.rpmAtual2(conta,con,stmt2,vetRelatorio[1][i]);
                vetRelatorio[8][i] = rs.getString("LAT");
                vetRelatorio[9][i] = rs.getString("LON");
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
            System.err.println("ERRO NO METODO PAINELATUALIZADO");
        }
        
        return vetRelatorio;
    }
    /**
     * 
     * @param conta
     * @param con
     * @param stmt
     * @param mct
     * @return 
     */
    public String rpmAtual1(String conta, Connection con, Statement stmt, String mct) {
        
        String vetRelatorio = "";
        int l = 0;
        //Conexão
        try {
              
           
            //Query sql que vai pro mysql
           
             String sqlPainel=("SELECT IIRTN_RPM, IIRTN_Velocity, IIRTN_MctAddress, IIRTN_MessageTime FROM exporta."+conta+"_messagereturn_iirtn where IIRTN_MctAddress = \""+mct+"\" order by IIRTN_ID desc limit 1");

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
        
    public String rpmAtual2(String conta, Connection con, Statement stmt, String mct){
        
        String vetRelatorio = "";
        int l = 0;
        //Conexão
        try {
          
           
            //Query sql que vai pro mysql
           
             String sqlPainel=("SELECT IIRTN_RPM, IIRTN_Velocity, IIRTN_MctAddress, IIRTN_MessageTime FROM exporta."+conta+"_messagereturn_iirtn where IIRTN_MctAddress = \""+mct+"\" order by IIRTN_ID desc limit 1");

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
