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
import java.util.ArrayList;  
import java.util.List; 
import src.Barco;

/**
 * Classe criada para fazer o crud da tabela Barco.
 * @author Luiz Lacerda
 */
public class BarcoDao {
    
    /** 
     * Metodo de inclusão de barcos no banco de dados.
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statament
     * @param mct String - numero do MCT do barco
     * @param nome String - nome da embarcação
     * @param motor String - numero do motor
     * @param modelo String - modelo do motor
     * @param base String - base da embarcação
     */
    public void incluirBarco(String conta,Connection con, Statement stmt, String mct, String nome, String motor, String modelo, String base) {
        try {
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");

            String sql = ("INSERT INTO `exporta`.`barco` \n"
                    + "(`mct`, `nome`, `motor`,`modelo`,`base`,`dataCad`,`conta`)\n"
                    + " VALUES\n"
                    + " ('" + mct + "', '" + nome + "', '" + motor + "', '" + modelo + "', '" + base + "','" + dtf.format(LocalDateTime.now()) + "', '"+conta+"');");

            stmt.executeUpdate(sql);
            System.out.println("Tabela salva com sucesso!!!!!");
        } catch (SQLException e) {
            System.out.println("ERRO AO TENTAR SALVAR TABELA!!!!!");
            System.out.println("ERRO AO TENTAR SALVAR TABELA!!!!!\n" + e);
        }
    }
    
    public List<Barco> pesquisaBarcosX(String conta,Connection con, Statement stmt) {

        List<Barco> barcos=new ArrayList<Barco>();  

        try {
            String sql = ("SELECT b.idbarco, b.mct, b.nome, m.nome_motor as motor, b.modelo, b.base, b.dataCad FROM exporta.barco b \n" +
                            "join motor_tab m on b.motor=m.idmotor_tab \n" +
                            "WHERE b.conta='"+conta+"' order by dataCad DESC;");

            ResultSet rs = stmt.executeQuery(sql);

            int i = 0;
            while (rs.next()) {
                Barco barco = new Barco();
                
                barco.setId(rs.getString("b.idbarco"));
                barco.setMct(rs.getString("b.mct"));
                barco.setNome(rs.getString("b.nome"));
                barco.setMotor(rs.getString("motor"));
                barco.setModelo(rs.getString("b.modelo"));
                barco.setBase(rs.getString("b.base"));
                barco.setDataCad(rs.getString("b.dataCad"));

                barcos.add(barco);
            }
            System.out.println("TUDO NICE NO METODO PESQUISAMOTOR ........... ");
            rs.close();
        } catch (Exception e) {

            System.err.println("ERRO NO METODO DE PESQUISABARCOS");
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.err.println("Erro!!!");
        }

        return barcos;
    }
    /** 
     * Metodo de pesquisa de barcos, pesquisa e rerna todos os barcos pertencentes ao cliente.
     * @param conta String - conta do usuario.
     * @param con Connection
     * @param stmt Statament
     * @return retorna um vetor bidimensional de String com os dados dos barcos encontrados
     */
    public String[][] pesquisaBarcos(String conta,Connection con, Statement stmt) {

        String[][] barcos = new String[7][100];

        try {
            String sql = ("SELECT b.idbarco, b.mct, b.nome, m.nome_motor as motor, b.modelo, b.base, b.dataCad FROM exporta.barco b \n" +
                            "join motor_tab m on b.motor=m.idmotor_tab \n" +
                            "WHERE b.conta='"+conta+"' order by dataCad DESC;");

            ResultSet rs = stmt.executeQuery(sql);

            int i = 0;
            while (rs.next()) {
                
                barcos[0][i] = rs.getString("b.idbarco");
                barcos[1][i] = rs.getString("b.mct");
                barcos[2][i] = rs.getString("b.nome");
                barcos[3][i] = rs.getString("motor");
                barcos[4][i] = rs.getString("b.modelo");
                barcos[5][i] = rs.getString("b.base");
                barcos[6][i] = rs.getString("b.dataCad");
                i++;
            }
            System.out.println("TUDO NICE NO METODO PESQUISAMOTOR ........... ");
            rs.close();
        } catch (Exception e) {

            System.err.println("ERRO NO METODO DE PESQUISABARCOS");
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.err.println("Erro!!!");
        }

        return barcos;
    }
    
    /** 
     * Pesquisa um barco apartir do seu id.
     * @param conta Stringa - conta do usuario
     * @param con Connection
     * @param stmt Statament
     * @param id String - id do barco pesquisado
     * @return retorna um vetor bidimensional de String com apenas um unico barco.
     */
    public String[][] pesquisarBarco(String conta,Connection con, Statement stmt, String id) {

        String[][] barcos = new String[7][10];

        try {
            String sql = ("SELECT b.idbarco, b.mct, b.nome, m.nome_motor as motor, b.modelo, b.base, b.dataCad FROM exporta.barco b "
                    + "join motor_tab m on b.motor=m.idmotor_tab WHERE b.idbarco = '" + id + "' and b.conta='"+conta+"'");

            ResultSet rs = stmt.executeQuery(sql);
            int i = 0;
            while (rs.next()) {

                barcos[0][i] = rs.getString("b.idbarco");
                barcos[1][i] = rs.getString("b.mct");
                barcos[2][i] = rs.getString("b.nome");
                barcos[3][i] = rs.getString("motor");
                barcos[4][i] = rs.getString("b.modelo");
                barcos[5][i] = rs.getString("b.base");
                barcos[6][i] = rs.getString("b.dataCad");
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
    
    /** 
     * Metodo de pesquisa de motores na tabela motor_tab
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statament
     * @return retorna um vetor bidimensional de string com os dados dos motores achados
     */
    public String[][] pesquisaMotores(String conta,Connection con, Statement stmt) {

        String[][] motores = new String[20][2];

        try {
            String sql = ("SELECT * FROM exporta.motor_tab where conta='"+conta+"'");

            ResultSet rs = stmt.executeQuery(sql);

            int i = 0;
            while (rs.next()) {

                motores[i][0] = rs.getString("idmotor_tab");
                motores[i][1] = rs.getString("nome_motor");
                i++;
            }
            System.out.println("METODO PESQUISAMOTOR FUNCIONANDO ........... ");
            
            rs.close();
        } catch (Exception e) {

            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.err.println("Erro!!!");
        }

        return motores;
    }
    
    /**
     * Metodo de edição de barbo
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statament
     * @param idBarco String - id do barco selecionado.
     * @param mct String - novo MCT que sera editado
     * @param nomeBarco String - novo nome do barco
     * @param motor String - novo nome do motor
     * @param modelo String - novo modelo de motor
     * @param base String - nova base
     */
    public void editarBarco(String conta,Connection con, Statement stmt, String idBarco, String mct, String nomeBarco, String motor, String modelo, String base) {
        System.out.println("METODO ---> EDITAR BARCO INICIADO.........");
        try {
            
            
            String sql = ("UPDATE `exporta`.`barco` SET `mct`='" + mct + "', `nome`='" + nomeBarco + "', `motor`='" + motor + "', `modelo`='" + modelo + "', `base`='" + base + "' WHERE `idbarco`='" + idBarco + "' and conta='"+conta+"' ;");
            stmt.executeUpdate(sql);
            System.out.println("METODO ---> EDITAR BARCO REALIZADO COM SUCESSO.........");

        } catch (SQLException e) {
            System.out.println("ERRO NO METODO EDITARBARCO " + e);
        }
    }
    
    /**
     * metodo de exclusão de barco.
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statament
     * @param idBarco String - id do barco que sera excluido.
     */
    public void excluirBarco(String conta,Connection con, Statement stmt, String idBarco){
        System.out.println("METODO ---> EXCLUIR BARCO INICIADO.........");
        try {
            String sql = ("DELETE FROM `exporta`.`barco` WHERE `idbarco`='"+idBarco+"' and conta='"+conta+"';");
            stmt.executeUpdate(sql);
            System.out.println("METODO ---> EXCLUIR BARCO REALIZADO COM SUCESSO.........");

        } catch (SQLException e) {
            System.out.println("ERRO NO METODO EXCLUIRBARCO " + e);
        }
    }
}
