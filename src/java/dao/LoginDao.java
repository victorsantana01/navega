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
/**
 *
 * @author Victor Santana
 */
public class LoginDao {
public String getCredenci(String user, String pass,Connection con,Statement stmt) {

        //VisitaDao v =new VisitaDao();v.setNumRow();
        
            
String vetRelatorio = null;
        //SCRIPT IGN
String SqlQueryIgn = ("SELECT * FROM exporta.funcionario where usuario = '"+user+"' and senha = '"+pass+"'");
        //É iniciada a variavel "Relatorio" que depois receberá os valores do objeto "rs"
        //Conexão
 
        try {
           
            ResultSet rs = stmt.executeQuery(SqlQueryIgn);
            int i = 0;
            while (rs.next()) {
                i++;
                vetRelatorio= rs.getString("nome_funcionario");


            }
            System.out.println("Autenticando Usuario......");
        
        } catch (Exception e) {
            System.out.println("ERRO NA AUTENTICAÇÃO DO USUARIO ........... ");
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }

        return vetRelatorio;
    }


public String[][] getResponsavelSession(String user, String pass,Connection con,Statement stmt) {
         String[][] vetRelatorio = new String[29][100];
        //VisitaDao v =new VisitaDao();v.setNumRow();
        
            

        //SCRIPT IGN
String SqlQueryIgn = ("SELECT * FROM exporta.funcionario where usuario = '"+user+"' and senha = '"+pass+"'");
        //É iniciada a variavel "Relatorio" que depois receberá os valores do objeto "rs"
        //Conexão
 
        try {
              
            ResultSet rs = stmt.executeQuery(SqlQueryIgn);
            int i = 0;
            while (rs.next()) {
               
                vetRelatorio [0][i]= rs.getString("nome_funcionario");
                vetRelatorio [1][i]= rs.getString("senha");
                vetRelatorio [2][i]= rs.getString("IIPOS_AccountNumber");
                i++;
                
            }
System.out.println("Consultando Usuario ........... Usuario");
            
        } catch (Exception e) {
            System.out.println("ERRO AO CONSULTAR USUARIO ........... ");
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }

        return vetRelatorio;
    }
    
}
