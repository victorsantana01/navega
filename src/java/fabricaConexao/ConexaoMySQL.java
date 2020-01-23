/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fabricaConexao;

//Classes necessárias para uso de Banco de dados //
 
import java.sql.Connection;
 
import java.sql.DriverManager;
 
import java.sql.SQLException;
 
  
 
//Início da classe de conexão//
 
public class ConexaoMySQL {
 
             public static String status = "Não conectou...";
 
//Método Construtor da Classe//
        public ConexaoMySQL() {
 
    }
 
  
 
//Método de Conexão//
 
public static java.sql.Connection getConexaoMySQL() 
{
 
        Connection connection = null;          //atributo do tipo Connection
 
  
 
try {
 
// Carregando o JDBC Driver padrão
 
String driverName = "com.mysql.jdbc.Driver";                        
 
Class.forName(driverName);
 
  
 
// Configurando a nossa conexão com um banco de dados//
    //String serverName = "node154823-env-6118138.jelasticlw.com.br";
            //String serverName = "18.188.247.78";    //caminho do servidor do BD - OLD
            String serverName = "18.190.147.254";    //caminho do servidor do BD

            String mydatabase = "exporta";        //nome do seu banco de dados
 
            String url = "jdbc:mysql://" + serverName + "/" + mydatabase;
 

 
           String username = "nortetrac";        //nome de um usuário de seu BD      
 
           String password = "2012@norte";      //sua senha de acesso  String password = "AAGxop09361";
 
            
            connection = DriverManager.getConnection(url, username, password);
 
  
 
            //Testa sua conexão//  
 
            if (connection != null) {
 
                status = ("STATUS--->Conectado com sucesso!");
 
            } else {
 
                status = ("STATUS--->Não foi possivel realizar conexão");
 
            }
 
            System.out.println("CONEXÃO ABERTA COM SUCESSO!!!!!!");
 
            return connection;
 
  
            
        } catch (ClassNotFoundException e) {  //Driver não encontrado
 
            System.out.println("O driver expecificado nao foi encontrado.");
 
            return null;
 
        } catch (SQLException e) {
 
//Não conseguindo se conectar ao banco
 
            System.out.println("Nao foi possivel conectar ao Banco de Dados.");
 
            return null;
 
        }
    }
    //Método que retorna o status da sua conexão//
 
    public static String statusConection() {
 
        return status;
 
    }
 
   
 
   //Método que fecha sua conexão//
 
    public static boolean FecharConexao() {
 
        try {
 
            ConexaoMySQL.getConexaoMySQL().close();
 
            return true;
 
        } catch (SQLException e) {
 
            return false;
 
        }
 
  
 
    }
 
   
 
   //Método que reinicia sua conexão//
 
    public static java.sql.Connection ReiniciarConexao() {
 
        FecharConexao();
 
  
 
        return ConexaoMySQL.getConexaoMySQL();
 
    }
    public static void main(String[] args) {
        getConexaoMySQL();
    }
 
}
