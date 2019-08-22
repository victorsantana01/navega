/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package teste;

import dao.ConsumoDao;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 *
 * @author Victor Santana
 */
public class Teste {

    public String consumo(String litros, String minutos) {

        String consumo = "";

        int h = 60;
        double consumoInt;
        System.out.println("litros:" +litros);
        if (litros.equals(null)) {
            litros = "0.0";
        }
        double litrosInt = Double.valueOf(litros);
        
        if (minutos == null) {
            minutos = "0";
        }
        double minutosInt = Double.valueOf(minutos);

        consumoInt = litrosInt * minutosInt / h;

        consumo = Double.toString(consumoInt);
        System.out.println("Consumo é: " + consumo + " litro(s)");
        return consumo;
    }

      public void hoje() {
       Date data = new Date();
        SimpleDateFormat formatador = new SimpleDateFormat("dd/MM/yyyy");
        formatador.format(data);
    }

    public static void main(String[] args) throws ParseException {
       /* Teste te = new Teste();
        te.consumo("120", "45");
        te.arredondamento("2589");
        ConsumoDao cons = new ConsumoDao();
        System.err.println("Litros: " + cons.getLitrosPorRpm("Cat", "600"));
*/
        Teste te = new Teste();
        
        //System.out.println("dia da semana é:  "+te.getDiaSemana("07/01/2019"));
    }
}
