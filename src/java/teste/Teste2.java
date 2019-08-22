/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package teste;

/**
 *
 * @author VictorSantana
 */
public class Teste2 {
    
    public static void main(String[] args) {
        String entrada = "R. Teotônio Viléla, 229 - Parque Verde, Belém - PA, 66635-890, Brasil#-1.3673371#-48.4543821";
        String splitEntrada [] = entrada.split("#");
        
        System.out.println("Endereço: "+splitEntrada[0]);
        System.out.println("Latitude: "+splitEntrada[1]);
        System.out.println("Longitude: "+splitEntrada[2]);
    }
}
