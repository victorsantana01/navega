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
 * @author AllforOne
 */
public class ViagemDao {
    
    
    
    
    public void incluirViagem(String nomeV, String status , String usuario, String origem, String inicioV, String destino, String fimV, String idBarco, String comandante){
     
        try{
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        
        
        String sql = ("INSERT INTO `exporta`.`viagem` (`nomeViagem`, `status`, `usuario`, `origem`, `inicioViagem`, `destino`, `fimViagem`, `nomeEmbarcacao`, `comandante`) "+
                "VALUES ('"+nomeV+"', '"+status+"', '"+usuario+"', '"+origem+"', '"+inicioV+"', '"+destino+"', '"+fimV+"', '"+idBarco+"', '"+comandante+"');");
        
        stmt.executeUpdate(sql);
  System.out.println("Tabela salva com sucesso!!!!!");
        } catch (SQLException e) {
             System.out.println("ERRO AO TENTAR SALVAR TABELA!!!!!");
             System.out.println("ERRO AO TENTAR SALVAR TABELA!!!!!\n"+e);
        }
        
    }
    
    public String[][] pesquisaViagens(){
        
        String[][] viagens = new String[50][11];
       
       try{
        Connection con = ConexaoMySQL.getConexaoMySQL();
        Statement stmt = con.createStatement();
        String sql = ("SELECT * FROM exporta.viagem");
        
        ResultSet rs = stmt.executeQuery(sql);
        
        int i =0;
        while (rs.next()) {
        
        viagens[i][0]=rs.getString("idViagem");
        viagens[i][1]=rs.getString("nomeViagem");
        viagens[i][2]=rs.getString("destino");
        viagens[i][3]=rs.getString("origem");
        viagens[i][4]=rs.getString("nomeEmbarcacao");
        viagens[i][5]=rs.getString("usuario");
        viagens[i][6]=rs.getString("inicioViagem");
        viagens[i][7]=rs.getString("fimViagem");
        viagens[i][8]=rs.getString("regViagem");
        viagens[i][9]=rs.getString("comandante");
        viagens[i][10]=rs.getString("comboio");
        i++;
        }
        System.out.println("TUDO NICE NO METODO PESQUISAMOTOR ........... ");
        rs.close();
       } catch (Exception e) {

            System.err.println(e.getClass().getName() + ": " + e.getMessage());
              System.err.println("Erro!!!");
        } 
    
        return viagens;
    }
    
}
