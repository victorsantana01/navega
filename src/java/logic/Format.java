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
        if (data.indexOf(" ") > 0) {
            String dataReturn = "";
            String vetData[] = data.split(" ");
            String hora = vetData[1];
            String ano = vetData[0];
            String vetAno[] = ano.split("-");
            ano = vetAno[2] + "/" + vetAno[1] + "/" + vetAno[0];
            dataReturn = ano + " " + hora;
            return dataReturn;
        } else {
            String dataReturn = "";
            String vetAno[] = data.split("-");
            String ano = vetAno[2] + "/" + vetAno[1] + "/" + vetAno[0];
            dataReturn = ano;
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
    
    public String tempo(String i, String f){
        //ARRAY DE HORA INICIAL
        String[] iArr = new String[2];
        iArr[0] = i.substring(0,2);
        iArr[1] = i.substring(2,4);
        //ARRAY DE HORA FINAL
        String[] fArr = new String[2];
        fArr[0] = f.substring(0,2);
        fArr[1] = f.substring(2,4);
        
        //TRANSFORMA HORA INICIO EM MINUTOS
        int iTime = Integer.parseInt(iArr[0]);
        iTime *= 60;
        int iTime2 = Integer.parseInt(iArr[1]);
        iTime = iTime + iTime2;
        
        //TRANSFORMA HORA FINAL EM MINUTOS
        int fTime = Integer.parseInt(fArr[0]);
        fTime *= 60;
        int fTime2 = Integer.parseInt(fArr[1]);
        fTime = fTime + fTime2;
        
        //SUBITRAI OS MINUTOS
        int tempo = fTime - iTime;
        int horas = tempo/60;
        int minutos = tempo%60;
        String tempoResultado;
        if(minutos <10){
            tempoResultado = horas+":0"+minutos;
        }else{
            tempoResultado = horas+":"+minutos;
        }
        
        //RETORNA O RESULTADO
        return tempoResultado;
    }
}
