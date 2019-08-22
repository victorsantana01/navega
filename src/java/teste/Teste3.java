/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package teste;

import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import dao.Rpm;

/**
 *
 * @author VictorSantana
 */
public class Teste3 {

    public static void main(String[] args) {
        Rpm rpm = new Rpm();
        String[][] painel;
        painel = rpm.getRpm("2019-04-01", "2019-04-04", "334323").clone();
        int cont = Integer.parseUnsignedInt(painel[5][0]);
        System.out.println("Numero de registros: "+cont);
        if (cont>0) {
         int r = 0;   
         int maior = 0;   
         System.out.println("Hà registro!!");   
            for (int i = 0; i < cont; i++) {
                //System.out.println("--->>" + painel[0][i]);
                r = Integer.parseInt(painel[0][i]);
                if (r > maior) {
                    maior = r;
                }
            }
             System.out.println("Maior = "+maior);

        
        }else{
            System.out.println("Sem registro!!");
        }

    }
}