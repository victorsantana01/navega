/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logic;

import java.text.SimpleDateFormat;

/**
 * Classe criada para formatar o formato de datas e horas
 * @author VictorSantana
 * @author LuizLacerda
 */
public class Format {
    /**
     * Metodo criado para formatar data, de yyyy-mm-dd para dd/mm/yyyy, podendo aceitar date e datetime.
     * @param data String - data a ser formatada
     * @return retorna uma String com a data formatada.
     */
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
    /**
     * Metodo criado para formatar uma date. recebendo apenas data.
     * @param data Stringa - data a ser formatada
     * @return retorna a data formatada.
     */
    public String DiaFormat(String data) {
        String dataReturn = "";

        String ano = data;
        String vetAno[] = ano.split("-");
        ano = vetAno[2] + "/" + vetAno[1] + "/" + vetAno[0];
        dataReturn = ano;

        return dataReturn;
    }
    
    /**
     * metodo feito para retornar a data atual no formato yyyy-mm-dd
     * @return retorna uma string com a data atual.
     */
    public String hoje() {
        java.util.Date data = new java.util.Date();
        SimpleDateFormat formatador = new SimpleDateFormat("yyyy-MM-dd");
        String dat = formatador.format(data);
        return dat;
    }
    /**
     * Metodo recebe duas strings com o valor de horas, transforma em minutos, subtrai e retorna o intervalo de horas e minutos.
     * @param i String - hora inicial
     * @param f String - hora final
     * @return retorna uma String com o valor da subritação das duas horas.
     */
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
