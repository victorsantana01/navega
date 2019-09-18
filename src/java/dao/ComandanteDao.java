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

    public void incluirComandante(String conta, Connection con, Statement stmt, String nome, String matricula, String contato) {
        try {
            
            String sql = ("INSERT INTO `exporta`.`comandante` (`nome`, `matricula`, `contato`) VALUES ('" + nome + "', '" + matricula + "', '" + contato + "');");

            stmt.executeUpdate(sql);
            System.out.println("METODO INCLUIRCOMANDANTE REALIZADO COM SUCESSO ----- TABELA INCLUIDA COM SUCESSO!!!!!");
        } catch (SQLException e) {
            System.out.println("ERRO AO TENTAR SALVAR TABELA!!!!!" + e);
        }
    }

    public String[][] pesquisarComandantes(String conta, Connection con, Statement stmt) {

        String[][] comandantes = new String[5][100];

        try {
            String sql = ("SELECT * FROM exporta.comandante ");
            ResultSet rs = stmt.executeQuery(sql);

            int i = 0;
            while (rs.next()) {

                comandantes[0][i] = rs.getString("idcomandante");
                comandantes[1][i] = rs.getString("nome");
                comandantes[2][i] = rs.getString("matricula");
                comandantes[3][i] = rs.getString("ultimaViagem");
                comandantes[4][i] = rs.getString("contato");
                i++;
            }
            System.out.println("METODO PESQUISACOMANDANTES REALIZADO COM SUCESSO ........... ");
            rs.close();
        } catch (Exception e) {

            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.err.println("Erro!!!");
        }
        return comandantes;
    }

    public String[][] pesquisarComandante(String conta, Connection con, Statement stmt, String id) {

        String[][] comandantes = new String[4][2];

        try {
            String sql = ("SELECT * FROM exporta.comandante WHERE idcomandante ='" + id + "'");
            ResultSet rs = stmt.executeQuery(sql);

            int i = 0;
            while (rs.next()) {

                comandantes[0][i] = rs.getString("idcomandante");
                comandantes[1][i] = rs.getString("nome");
                comandantes[2][i] = rs.getString("matricula");
                comandantes[3][i] = rs.getString("contato");
                i++;
            }
            System.out.println("METODO PESQUISACOMANDANTES REALIZADO COM SUCESSO ........... ");
            rs.close();
        } catch (Exception e) {

            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.err.println("Erro!!!");
        }
        return comandantes;
    }

    public void excluirComandante(String conta, Connection con, Statement stmt, String id) {

        try {
            String sql = ("DELETE FROM `exporta`.`comandante` WHERE `idcomandante`='" + id + "';");
            stmt.executeUpdate(sql);
            System.out.println("METODO ---> EXCLUIR COMANDANTE REALIZADO COM SUCESSO.........");
        } catch (SQLException e) {
            System.out.println(" FALHA NO METODO ---> EXCLUIR COMANDANTE .......... " + e);
        }

    }

    public void editarComandante(String conta, Connection con, Statement stmt, String id, String nome, String matricula, String contato) {
        try {
            String sql = ("UPDATE `exporta`.`comandante` SET `nome`='" + nome + "', `matricula`='" + matricula + "', `contato`='" + contato + "' WHERE `idcomandante`='" + id + "';");
            stmt.executeUpdate(sql);
            System.out.println("METODO ---> EDITAR COMANDANTE REALIZADO COM SUCESSO.........");
        } catch (SQLException e) {
            System.out.println("FALHA NO METODO EDITARCOMANDANTE --------------------" + e);
        }
    }

}
