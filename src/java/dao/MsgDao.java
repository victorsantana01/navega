/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import fabricaConexao.ConexaoMySQL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author VictorSantana
 */
public class MsgDao {
    
    public String[][] getPrincipalRpm(String begin, String finish, String mct, Connection con, Statement stmt) {
        //VisitaDao v =new VisitaDao();v.setNumRow();

        String[][] vetRelatorio = new String[7][2000];
        //SCRIPT IGN
        String SqlQueryIgn = (" SELECT DISTINCT IIRTN_RPM AS RPM,\n"
                + "COUNT('iIRTN_RPM')*15 AS TEMPO_MIN, COUNT('IIRTN_RPM') AS N_REG,  IIRTN_Latitude AS LAT,  IIRTN_Longitude AS LON\n"
                + "from messagereturn_iirtn\n"
                + "where IIRTN_MctAddress='" + mct + "'and IIRTN_MessageTime between '" + begin + " 00:00:00' and '" + finish + " 23:59:59' and IIRTN_RPM > '0'\n"
                + "group by IIRTN_RPM ORDER BY IIRTN_RPM DESC;");

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

                vetRelatorio[0][i] = rs.getString("RPM");
                if (vetRelatorio[0][i] == null) {
                    vetRelatorio[0][i] = "0";
                }
                vetRelatorio[1][i] = rs.getString("TEMPO_MIN");
                if (vetRelatorio[1][i] == null) {
                    vetRelatorio[1][i] = "0";
                }
                vetRelatorio[2][i] = rs.getString("N_REG");
                vetRelatorio[3][i] = rs.getString("LAT");
                vetRelatorio[4][i] = rs.getString("LON");
                System.out.println(" coleta de rpm principal 1 !!" + vetRelatorio[3][i]);

                i++;

            }
            rs.last();
            n = rs.getRow();
            vetRelatorio[4][0] = String.valueOf(n);
            System.out.println(" QTD-------------------------- !!" + vetRelatorio[4][0]);
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
}
