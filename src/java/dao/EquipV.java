/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Lacerda
 */
public class EquipV {
    
    
    public String getEquips(String conta, Connection con, Statement stmt){
        System.out.println("ENTROU NO METODO GET EQUIPS");
        String equips="";
        try{
            String sql = "SELECT * FROM `visibilidade_equipamentos` WHERE usuario = '"+conta+"'";
            ResultSet rs = stmt.executeQuery(sql);
            
            if(rs.next()){
                equips = rs.getString("mcts");
            }else{
                equips = "";
            }            
        }catch(Exception e){
            System.out.println("ERRO NO METODO GETEQUIPS");
            System.out.println(e);
        }
        System.out.println("SAIU DO METODO GETEQUIPS");        
        return equips;
    }
    
    public void setEquips(String conta, Connection con, Statement stmt,Statement stmt2,String mcts){
        System.out.println("ENTROU NO METODO SETEQUIP");
        String sqlExiste ="";
        String sqlnew="";
        try{
            sqlExiste = "Select * FROM visibilidade_equipamentos WHERE usuario = '"+conta+"'";
            ResultSet rs = stmt.executeQuery(sqlExiste);
            
            if(rs.next()){
                sqlnew = "UPDATE `visibilidade_equipamentos` SET `mcts`='"+mcts+"' WHERE usuario='"+conta+"'";
                System.out.println("UPDATE");
            }else{
                sqlnew = "INSERT INTO `visibilidade_equipamentos`(`usuario`, `mcts`) VALUES ('"+conta+"','"+mcts+"')";
                System.out.println("NEW");
            }
            stmt2.executeUpdate(sqlnew);
            
        }catch(Exception e){
            System.out.println("ERRO NO METODO SETEQUIPS");
            System.out.println(e);
        }
        System.out.println("FIM DO METODO SETEQUIP");
    }
}
