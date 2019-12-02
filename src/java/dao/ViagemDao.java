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
import java.util.ArrayList;
import java.util.List;
import logic.Format;
import src.Viagem;

/**
 * Classe criada para fazer o crud com a tabela Viagem.
 * @author Luiz Lacerda
 */
public class ViagemDao {
    /**
     * metodo cria uma nova viagem.
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @param nomeV String - nome da viagem
     * @param status String - Status da viagem
     * @param origem String - origem da viagem
     * @param inicioV String - data inicial da viagem
     * @param destino String - destino da viagem
     * @param fimV String - data final da viagem
     * @param codBarco String - codigo da embarcação da viagem
     * @param comandante  String - codigo do comandante da viagem
     */
    public void incluirViagem(String conta,Connection con, Statement stmt, String nomeV, String status, String origem, String inicioV, String destino, String fimV, String codBarco, String comandante) {
        System.out.println("METODO ---> INCLUIR VIAGEM INICIADO.........");
        
        try {
            Format format = new Format();
            fimV = format.DataFormat(fimV);
            inicioV = format.DataFormat(inicioV);
            System.out.println("inicioV: " + inicioV);
            System.out.println("fimV: " + fimV);

            String sql = ("INSERT INTO `exporta`.`viagem` (`nomeViagem`, `status`, `conta`, `origem`, `inicioViagem`, `destino`, `fimViagem`, `mct`, `comandante`) "
                    + "VALUES ('" + nomeV + "', '" + status + "', '" + conta + "', '" + origem + "', '" + inicioV + "', '" + destino + "', '" + fimV + "', '" + codBarco + "', '" + comandante + "');");

            stmt.executeUpdate(sql);
            System.out.println("METODO ---> INCLUIR VIAGEM REALIZADO COM SUCESSO.........");
        } catch (SQLException e) {
            System.out.println(" FALHA NO METODO ---> INCLUIR VIAGEM ......... " + e);
        }

    }
    /**
     * metodo exclui uma viagem
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @param id String - id da viagem que sera excluida
     */
    public void excluirViagem(String conta,Connection con, Statement stmt, String id) {
        System.out.println("ENTROU NO METODO EXCLUIRVIAGEM");
        try {
            String sql = ("DELETE FROM `exporta`.`viagem` WHERE `idViagem`='" + id + "';");
            stmt.executeUpdate(sql);
            System.out.println("METODO ---> EXCLUIR VIAGEM REALIZADO COM SUCESSO.........");
        } catch (SQLException e) {
            System.out.println(" FALHA NO METODO ---> EXCLUIR VIAGEM .......... " + e);
        }
    }
    /**
     * metodo edita os dados de uma viagem
     * @param conta String - conta do cliente
     * @param con Connection
     * @param stmt Statement
     * @param id String - id da viagem a ser editada
     * @param nomeV String - nome da viagem
     * @param status String - status da viagem
     * @param origem String - origem da viagem
     * @param inicioV String - data inicial da viagem
     * @param destino String - destino da viagem
     * @param fimV String - data final da viagem
     * @param mct String - mct da viagem
     * @param comandante String - comandante da viagem
     */
    public void editarViagem(String conta,Connection con, Statement stmt, String id,String nomeV, String status, String origem, String inicioV, String destino, String fimV, String mct, String comandante) {
        System.out.println("METODO ---> EDITAR VIAGEM INICIADO.........");
        try {
            Format format = new Format();
            fimV = format.DataFormat(fimV);
            inicioV = format.DataFormat(inicioV);
            System.out.println("inicioV: " + inicioV);
            System.out.println("fimV: " + fimV);

            String sql = ("UPDATE `exporta`.`viagem` SET `nomeViagem`='" + nomeV + "', `status`='" + status + "', `origem`='" + origem + "', `inicioViagem`='" + inicioV + "', `destino`='" + destino + "', `fimViagem`='" + fimV + "', `mct`='" + mct + "', `comandante`='" + comandante + "' WHERE `idViagem`='"+id+"'");

            stmt.executeUpdate(sql);
            System.out.println("METODO ---> EDITAR VIAGEM REALIZADO COM SUCESSO.........");
        } catch (SQLException e) {
            System.out.println(" FALHA NO METODO ---> EDITAR VIAGEM ......... " + e);
        }

    }
    /**
     * metodo pesquisa uma viagem via id
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @param id - String id da viagem
     * @return retorna uma String com os dados da viagem.
     */
    public String[][] pesquisarViagens(String conta,Connection con, Statement stmt, String id) {

        String[][] viagem = new String[11][10];

        try {
//          String sql = ("SELECT idViagem, nomeViagem, status, origem, inicioViagem, destino, fimViagem, mct, comandante FROM exporta.viagem WHERE idViagem = '"+id+"';");
            String sql = ("SELECT v.idViagem, v.nomeViagem, v.status, v.origem, v.inicioViagem, v.destino, v.fimViagem, v.mct, \n" +
            "v.comandante, m.nome_motor, b.mct\n" +
            "	FROM exporta.viagem v \n" +
            "    left join exporta.barco b on v.mct = b.mct\n" +
            "    left join exporta.motor_tab m on b.motor = m.idmotor_tab \n" +
            "    where v.idViagem = '"+id+"' and v.conta = '"+conta+"';");
            
            ResultSet rs = stmt.executeQuery(sql);
            System.out.println("CONSULTA REALIZADA COM SUCESSO");
            int i = 0;
            while (rs.next()) {

                viagem[0][i] = rs.getString("v.idViagem");
                viagem[1][i] = rs.getString("v.nomeViagem");
                viagem[2][i] = rs.getString("v.status");
                viagem[3][i] = rs.getString("v.origem");
                viagem[4][i] = rs.getString("v.inicioViagem");
                viagem[5][i] = rs.getString("v.destino");
                viagem[6][i] = rs.getString("v.fimViagem");
                viagem[7][i] = rs.getString("v.mct");
                viagem[8][i] = rs.getString("v.comandante");
                viagem[9][i] = rs.getString("m.nome_motor");
                viagem[10][i] = rs.getString("b.mct");
                i++;
            }

            System.out.println("METODO PESQUISAVIAGEM REALIZADO COM SUCESSO........... ");
            rs.close();
        } catch (SQLException e) {
            System.out.println("ERROR - PESQUISAR POR ID --- " + e);
        }
        return viagem;
    }
    /**
     * metodo pesquisa viagens por status
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @param status String - status a ser pesquisado
     * @return retorna um vetor bidimensional de string com os dados das viagens achadas
     */
    public String[][] pesquisarViagensPorStatus(String conta,Connection con, Statement stmt, String status) {

        String[][] viagem = new String[12][2000];

        try {
//          String sql = ("SELECT idViagem, nomeViagem, status, origem, inicioViagem, destino, fimViagem, mct, comandante FROM exporta.viagem WHERE idViagem = '"+id+"';");
            String sql = ("SELECT v.idViagem, v.nomeViagem, v.status, v.origem, v.inicioViagem, v.destino, v.fimViagem, v.mct, \n" +
            "v.comandante, m.nome_motor, b.mct, b.nome, c.nome, v.dataCad\n" +
            "	FROM exporta.viagem v \n" +
            "    left join exporta.barco b on v.mct = b.mct\n" +
            "    left join exporta.motor_tab m on b.motor = m.idmotor_tab \n" +
            "    left join exporta.comandante c on v.comandante = c.idcomandante"+
            "    where v.status = '"+status+"' and v.conta = '"+conta+"';");
            
            ResultSet rs = stmt.executeQuery(sql);
            System.out.println("CONSULTA REALIZADA COM SUCESSO");
            int i = 0;
            while (rs.next()) {

                viagem[0][i] = rs.getString("v.idViagem");
                viagem[1][i] = rs.getString("v.nomeViagem");
                viagem[2][i] = rs.getString("v.status");
                viagem[3][i] = rs.getString("v.origem");
                viagem[4][i] = rs.getString("v.inicioViagem");
                viagem[5][i] = rs.getString("v.destino");
                viagem[6][i] = rs.getString("v.fimViagem");
                viagem[7][i] = rs.getString("b.nome");
                viagem[8][i] = rs.getString("c.nome");
                viagem[9][i] = rs.getString("m.nome_motor");
                viagem[10][i] = rs.getString("b.mct");
                viagem[11][i] = rs.getString("v.dataCad");
                i++;
            }

            System.out.println("METODO PESQUISAVIAGEM REALIZADO COM SUCESSO........... ");
            rs.close();
        } catch (SQLException e) {
            System.out.println("ERROR - PESQUISAR POR ID --- " + e);
        }
        return viagem;
    }

    /**
     * metodo pesquisa todas as viagens ligadas ao usuario
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @return retorna um vetor bidimensional de String com os dados das viagens encontradas
     */
    public String[][] pesquisarViagens(String conta,Connection con, Statement stmt) {

        String[][] viagens = new String[10][10000];

        try {
            String sql = ("SELECT idViagem, nomeViagem, if(1>status, 'Agendado',if(2>status, 'Em Progresso', 'Finalizado')) as status, "
                    + "origem, inicioViagem, destino, fimViagem, v.mct, c.nome as comandante, v.dataCad FROM exporta.viagem v"
                    + " left join exporta.barco b on v.mct = b.mct "
                    + " left join exporta.comandante c on v.comandante = c.idcomandante"
                    + " where v.conta = '"+conta+"' order by v.dataCad DESC;");

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
                viagens[7][i] = rs.getString("mct");
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
    
    /**
     * metodo pesquisa viagem apartir da conta.
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @return retorna uma lista de objetos do tipo viagem.
     */
    public List<Viagem> pesquisarViagensX(String conta,Connection con, Statement stmt) {

//        String[][] viagens = new String[10][10000];
        List<Viagem> viagens = new ArrayList<Viagem>();

        try {
            String sql = ("SELECT idViagem, nomeViagem, if(1>status, 'Agendado',if(2>status, 'Em Progresso', 'Finalizado')) as status, "
                    + "origem, inicioViagem, destino, fimViagem, v.mct, c.nome as comandante, v.dataCad FROM exporta.viagem v"
                    + " left join exporta.barco b on v.mct = b.mct "
                    + " left join exporta.comandante c on v.comandante = c.idcomandante"
                    + " and v.conta = '"+conta+"' order by v.dataCad DESC;");

            ResultSet rs = stmt.executeQuery(sql);

            int i = 0;
            while (rs.next()) {
                Viagem viagem = new Viagem();
                viagem.setIdViagem(rs.getString("idViagem"));
                viagem.setNome(rs.getString("nomeViagem"));
                viagem.setStatus(rs.getString("status"));
                viagem.setOrigem(rs.getString("origem"));
                viagem.setInicio(rs.getString("inicioViagem"));
                viagem.setDestino(rs.getString("destino"));
                viagem.setFim(rs.getString("fimViagem"));
                viagem.setMct(rs.getString("mct"));
                viagem.setComandante(rs.getString("comandante"));
                viagem.setDataCad(rs.getString("dataCad"));
                viagens.add(viagem);
            }
            System.out.println("METODO PESQUISAVIAGEM REALIZADO COM SUCESSO........... ");
            rs.close();
        } catch (Exception e) {

            System.err.println("ViagemDao :" + e.getClass().getName() + ": " + e.getMessage());
            System.err.println("Erro!!!");
        }
        return viagens;
    }
    /**
     * metodo pesquisa viagens por mct
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @param mct String - mct do aparelho
     * @return retorna uma string com o status da viagem encontrada 
     */
    public String pesquisarViagemStatusPorMCT(String conta,Connection con, Statement stmt, String mct, String data){
        String status="";
        
        try{
            String sql = ("SELECT * FROM `viagem` where conta = '"+conta+"' AND mct = '"+mct+"' AND '"+data+"' BETWEEN inicioViagem AND fimViagem");
            ResultSet rs = stmt.executeQuery(sql);
            
            if(rs.next()){
                status = rs.getString("status");
                
            }else{
                status = "INEXISTENTE";
            }
        }catch(Exception e){
            System.out.println("ERRO NO METODO PESQUISARVIAGEMPORMCT");
            System.out.println(e);
        }
        
        return status;
    }
    /**
     * metodo pesquisa viagem por mct
     * @param conta String - conta do usuario
     * @param con Connection
     * @param stmt Statement
     * @param mct String - mct do barco
     * @return retorna uma String com os dados da viagem encontrada
     */
    public String pesquisarViagemPorMCT(String conta,Connection con, Statement stmt, String mct, String data){
        String id="";
        
        try{
            String sql = ("SELECT * FROM `viagem` where conta = '"+conta+"' AND mct = '"+mct+"'  AND '"+data+"' BETWEEN inicioViagem AND fimViagem");
            ResultSet rs = stmt.executeQuery(sql);
            
            if(rs.next()){
                id = rs.getString("idViagem");
                
            }else{
                id = "INEXISTENTE";
            }
        }catch(Exception e){
            System.out.println("ERRO NO METODO PESQUISARVIAGEMPORMCT");
            System.out.println(e);
        }
        
        return id;
    }

}
