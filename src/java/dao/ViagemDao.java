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
import logic.Format;
/**
 *
 * @author Luiz Lacerda
 */
public class ViagemDao {

    public void incluirViagem(String nomeV, String status, String usuario, String origem, String inicioV, String destino, String fimV, String idBarco, String comandante) {
        System.out.println("METODO ---> INCLUIR VIAGEM INICIADO.........");
        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
            Format format = new Format();
            fimV = format.DataFormat(fimV);
            inicioV = format.DataFormat(inicioV);
            System.out.println("inicioV: "+inicioV);
            System.out.println("fimV: "+fimV);

            String sql = ("INSERT INTO `exporta`.`viagem` (`nomeViagem`, `status`, `usuario`, `origem`, `inicioViagem`, `destino`, `fimViagem`, `nomeEmbarcacao`, `comandante`) "
                    + "VALUES ('" + nomeV + "', '" + status + "', '" + usuario + "', '" + origem + "', '" + inicioV +"', '" + destino + "', '" + fimV +"', '" + idBarco + "', '" + comandante + "');");

            stmt.executeUpdate(sql);
            System.out.println("METODO ---> INCLUIR VIAGEM REALIZADO COM SUCESSO.........");
        } catch (SQLException e) {
            System.out.println(" FALHA NO METODO ---> INCLUIR VIAGEM ......... " + e);
        }

    }

    public String[][] pesquisarViagens() {

        String[][] viagens = new String[10][10000];

        try {
            Connection con = ConexaoMySQL.getConexaoMySQL();
            Statement stmt = con.createStatement();
            String sql = ("SELECT idViagem, nomeViagem, if(1>status, 'Agendado',if(2>status, 'Em Progresso', 'Finalizado')) as status, origem, inicioViagem, destino, fimViagem, barco.nome as nomeEmbarcacao, comandante.nome as comandante, viagem.dataCad FROM exporta.viagem"
                    + " left join exporta.barco on exporta.viagem.nomeEmbarcacao = exporta.barco.codBarco "
                    + " left join exporta.comandante on exporta.viagem.comandante = exporta.comandante.idcomandante order by dataCad DESC;");

            ResultSet rs = stmt.executeQuery(sql);

            int i = 0;
            while (rs.next()) {

                viagens[0][i] = rs.getString("idViagem");
                viagens[1][i] = rs.getString("nomeViagem");
                viagens[2][i] = rs.getString("status");
                viagens[3][i] = rs.getString("origem");
                viagens[4][i] = rs.getString("inicioViagem");
                viagens[5][i] = rs.getString("destino");
                viagens[6][i] = rs.getString("fimViagem");
                viagens[7][i] = rs.getString("nomeEmbarcacao");
                viagens[8][i] = rs.getString("comandante");
                viagens[9][i] = rs.getString("dataCad");
                i++;
            }
            System.out.println("METODO PESQUISAVIAGEM REALIZADO COM SUCESSO........... ");
            rs.close();
        } catch (Exception e) {

            System.err.println("ViagemDao :" + e.getClass().getName() + ": " + e.getMessage());
            System.err.println("Erro!!!");
        }

        return viagens;
    }

    

}
