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
 * @author Luiz Lacerda
 */
public class BarcoDao {
    
    
    public void incluirBarco(String codBarco, String nome, String motor, String modelo, String base){
        try{
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        
        String sql = ("INSERT INTO `exporta`.`barco` \n" +
        "(`codBarco`, `nome`, `motor`,`modelo`,`base`)\n" +
        " VALUES\n" +
        " ('"+codBarco+"', '"+nome+"', '"+motor+"', '"+modelo+"', '"+base+"');");
        
        stmt.executeUpdate(sql);
        System.out.println("Tabela salva com sucesso!!!!!");
        } catch (SQLException e) {
             System.out.println("ERRO AO TENTAR SALVAR TABELA!!!!!");
             System.out.println("ERRO AO TENTAR SALVAR TABELA!!!!!\n"+e);
        }
    }
    public String[][] pesquisaBarcos(){
        
        String[][] barcos = new String[20][2];
       
       try{
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        String sql = ("SELECT * FROM exporta.barco");
        
        ResultSet rs = stmt.executeQuery(sql);
        
        int i =0;
        while (rs.next()) {
        
        barcos[i][0]=rs.getString("codBarco");
        barcos[i][1]=rs.getString("nome");
        barcos[i][1]=rs.getString("motor");
        barcos[i][1]=rs.getString("modelo");
        barcos[i][1]=rs.getString("base");
        i++;
        }
        System.out.println("TUDO NICE NO METODO PESQUISAMOTOR ........... ");
        rs.close();
       } catch (Exception e) {

            System.err.println(e.getClass().getName() + ": " + e.getMessage());
              System.err.println("Erro!!!");
        } 
    
        return barcos;
    }
    public String[][] pesquisaMotores(){
        
        String[][] motores = new String[20][2];
       
       try{
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        String sql = ("SELECT * FROM exporta.motor_tab");
        
        ResultSet rs = stmt.executeQuery(sql);
        
        int i =0;
        while (rs.next()) {
        
        motores[i][0]=rs.getString("idmotor_tab");
        motores[i][1]=rs.getString("nome_motor");
        i++;
        }
        System.out.println("TUDO NICE NO METODO PESQUISAMOTOR ........... ");
        rs.close();
       } catch (Exception e) {

            System.err.println(e.getClass().getName() + ": " + e.getMessage());
              System.err.println("Erro!!!");
        } 
    
        return motores;
    }
}
