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
import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;

/**
 *
 * @author Luiz Lacerda
 */
public class BarcoDao {

    public void incluirBarco(String codBarco, String nome, String motor, String modelo, String base) {
        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");

            String sql = ("INSERT INTO `exporta`.`barco` \n"
                    + "(`codBarco`, `nome`, `motor`,`modelo`,`base`,`dataCad`)\n"
                    + " VALUES\n"
                    + " ('" + codBarco + "', '" + nome + "', '" + motor + "', '" + modelo + "', '" + base + "','" + dtf.format(LocalDateTime.now()) + "');");

            stmt.executeUpdate(sql);
            System.out.println("Tabela salva com sucesso!!!!!");
        } catch (SQLException e) {
            System.out.println("ERRO AO TENTAR SALVAR TABELA!!!!!");
            System.out.println("ERRO AO TENTAR SALVAR TABELA!!!!!\n" + e);
        }
    }

    public String[][] pesquisaBarcos() {

        String[][] barcos = new String[7][100];

        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
            String sql = ("SELECT idbarco, codBarco, nome, motor_tab.nome_motor as motor, modelo, base, dataCad FROM exporta.barco "
                    + "join motor_tab on exporta.barco.motor=exporta.motor_tab.idmotor_tab order by dataCad DESC;");

            ResultSet rs = stmt.executeQuery(sql);

            int i = 0;
            while (rs.next()) {

                barcos[0][i] = rs.getString("idbarco");
                barcos[1][i] = rs.getString("codBarco");
                barcos[2][i] = rs.getString("nome");
                barcos[3][i] = rs.getString("motor");
                barcos[4][i] = rs.getString("modelo");
                barcos[5][i] = rs.getString("base");
                barcos[6][i] = rs.getString("dataCad");
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

    public String[][] pesquisarBarco(String id) {

        String[][] barcos = new String[7][10];

        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
            String sql = ("SELECT idbarco, codBarco, nome, motor_tab.nome_motor as motor, modelo, base, dataCad FROM exporta.barco "
                    + "join motor_tab on exporta.barco.motor=exporta.motor_tab.idmotor_tab WHERE idbarco = '" + id + "'");

            ResultSet rs = stmt.executeQuery(sql);
            int i = 0;
            while (rs.next()) {

                barcos[0][i] = rs.getString("idbarco");
                barcos[1][i] = rs.getString("codBarco");
                barcos[2][i] = rs.getString("nome");
                barcos[3][i] = rs.getString("motor");
                barcos[4][i] = rs.getString("modelo");
                barcos[5][i] = rs.getString("base");
                barcos[6][i] = rs.getString("dataCad");
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

    public String[][] pesquisaMotores() {

        String[][] motores = new String[20][2];

        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
            String sql = ("SELECT * FROM exporta.motor_tab");

            ResultSet rs = stmt.executeQuery(sql);

            int i = 0;
            while (rs.next()) {

                motores[i][0] = rs.getString("idmotor_tab");
                motores[i][1] = rs.getString("nome_motor");
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

    public void editarBarco(String idBarco, String codBarco, String nomeBarco, String motor, String modelo, String base) {
        System.out.println("METODO ---> EDITAR BARCO INICIADO.........");
        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
            String sql = ("UPDATE `exporta`.`barco` SET `codBarco`='" + codBarco + "', `nome`='" + nomeBarco + "', `motor`='" + motor + "', `modelo`='" + modelo + "', `base`='" + base + "' WHERE `idbarco`='" + idBarco + "';");
            stmt.executeUpdate(sql);
            System.out.println("METODO ---> EDITAR BARCO REALIZADO COM SUCESSO.........");

        } catch (SQLException e) {
            System.out.println("ERRO NO METODO EDITARBARCO " + e);
        }
    }
}
