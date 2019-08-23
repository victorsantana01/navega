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
 * @author Luiz Lacerda
 */
public class ComandanteDao {
    private String idComandante, nome, matricula, ultimaViagem, contato;
    
    public void adicionaComandante(){
        
    }
    public String[][] pesquisaComandantes() {
        System.out.println("ENTROU NO PESQUISAcOMANTES!!!");
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
