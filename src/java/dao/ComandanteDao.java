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
public class ComandanteDao {
    
    public void incluirComandante(String nome, String matricula, String contato){
        try{
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        
        String sql = ("INSERT INTO `exporta`.`comandante` (`nome`, `matricula`, `contato`) VALUES ('"+nome+"', '"+matricula+"', '"+contato+"');");
        
        stmt.executeUpdate(sql);
        System.out.println("Tabela salva com sucesso!!!!!");
        } catch (SQLException e) {
             System.out.println("ERRO AO TENTAR SALVAR TABELA!!!!!\n"+e);
        }
    }
    public String[][] pesquisaComandantes() {
       
       String[][] comandantes = new String[20][3];
       
       try{
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
//        String sql = ("SELECT (*) FROM exporta.comandante");
//        int size = Integer.parseInt(sql);
        String sql = ("SELECT * FROM exporta.comandante");
        
        ResultSet rs = stmt.executeQuery(sql);
        
        int i =0;
//        String[][] comandantes = new String[size][3];
        while (rs.next()) {
        
        comandantes[i][0]=rs.getString("idcomandante");
        comandantes[i][1]=rs.getString("nome");
        comandantes[i][2]=rs.getString("matricula");
        i++;
        }
        System.out.println("TUDO NICE NO METODO PESQUISACOMANDANTES ........... ");
        rs.close();
       } catch (Exception e) {

            System.err.println(e.getClass().getName() + ": " + e.getMessage());
              System.err.println("Erro!!!");
        } 
    
        return comandantes;
    }
    
}
