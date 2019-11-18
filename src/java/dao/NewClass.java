/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

/**
 * Classe criada para excluir dados duplicados na macro.
 * @author ricardson
 */
public class NewClass {
    public static void main(String[] args) {
        
        String conta = "268525817";
        
        MacroDao m = new MacroDao();
        
        m.apagaDuplicados(conta);   
    }
}
