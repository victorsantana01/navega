/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logic;

import java.text.SimpleDateFormat;

/**
 *
 * @author VictorSantana
 */
public class Format {

    public String DataFormat(String data) {
        System.out.println("ENTROU NO DATAFORMAT!");
        if (data.indexOf(" ") > 0) {
            String dataReturn = "";
            String vetData[] = data.split(" ");
            String hora = vetData[1];
            String ano = vetData[0];
            String vetAno[] = ano.split("-");
            ano = vetAno[2] + "/" + vetAno[1] + "/" + vetAno[0];
            dataReturn = ano + " " + hora;
            System.out.println("SAIU DO METODO DATAFORMAT1");
            return dataReturn;
        } else {
            String dataReturn = "";
            String vetAno[] = data.split("-");
            String ano = vetAno[2] + "/" + vetAno[1] + "/" + vetAno[0];
            dataReturn = ano;
            System.out.println("SAIU DO METODO DATAFORMAT2");
            return dataReturn;
        }

    }

    public String DiaFormat(String data) {
        String dataReturn = "";

        String ano = data;
        String vetAno[] = ano.split("-");
        ano = vetAno[2] + "/" + vetAno[1] + "/" + vetAno[0];
        dataReturn = ano;

        return dataReturn;
    }

    public String hoje() {
        java.util.Date data = new java.util.Date();
        SimpleDateFormat formatador = new SimpleDateFormat("yyyy-MM-dd");
        String dat = formatador.format(data);
        return dat;
    }
}
