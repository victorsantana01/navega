/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package relatorios;

import fabricaConexao.ConexaoMySQL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import org.joda.time.DateTime;
import org.joda.time.Days;

/**
 *
 * @author Victor Santana
 */
public class RelatorioNavegacao {
    
    public int getDif(String begn, String finish) throws ParseException {
        int dife;
        
        String dataBegin = begn;
        String dataFinish = finish;
        
        SimpleDateFormat formatador = new SimpleDateFormat("dd HHH:mm:ss");

        SimpleDateFormat dma = new SimpleDateFormat("dd/MM/yyyy");

        java.util.Date dateInicio = (java.util.Date) dma.parse(dataBegin);
        java.util.Date dateFim = (java.util.Date) dma.parse(dataFinish);

        DateTime dataFinal = new DateTime(dateFim);
        DateTime dataInicio = new DateTime(dateInicio);
        Days contador = Days.daysBetween(dataInicio, dataFinal);
        dife = contador.getDays();
        return dife;
    }

    public String[][] resultadoRpm(String inic, String fin, String mct) throws ParseException {
        String[][] vetRelatorio = new String[4][1000];
        RelatorioNavegacao relat = new RelatorioNavegacao();
        int l = 0;
  
        String rpmUni = null;
        String rpmUni02 = null;
        
        String begin = inic;
        String finish = fin;

        SimpleDateFormat dma = new SimpleDateFormat("dd/MM/yyyy");

        java.util.Date dateInicio = (java.util.Date) dma.parse(begin);

        GregorianCalendar dataBegin = new GregorianCalendar();
        dataBegin.setTime(dateInicio);

        int cont = getDif(begin, finish);
        cont = cont + 2;
        String[] hora;
        String[] horaf;
        String [] data;
        String dataTratada;
        String inicio;
        String fim;
        int f;
        int g=0;
        for (int i = 1; i < cont; i++) {//Dias
            begin = dma.format(dataBegin.getTime());
            
            for (int j = 0; j < 24; j++) {//horas
                
              f=j+1; 
              
              //==========Tratamento Hora Final(j)====================//
                Integer.toString(f);
                horaf = Integer.toString(f).split("");
                if (horaf.length == 1) {
                    horaf[0] = "0" + horaf[0];
                }
                if (horaf.length != 1) {
                    horaf[0] = Integer.toString(f);
                    if (horaf[0].equals("24")) {
                        horaf[0] = "00";
                    }
                }
            //========================================================//
              
              //==========Tratamento Hora inicial(j)====================//
                Integer.toString(j);
                hora = Integer.toString(j).split("");
                if (hora.length == 1) {
                    hora[0] = "0" + hora[0];
                }
                if (hora.length != 1) {
                    hora[0] = Integer.toString(j);
                    if (hora[0].equals("24")) {
                        hora[0] = "00";
                    }
                    
                }
            //========================================================//
                data=begin.split("/");
                
                
                dataTratada =data[2]+"-"+data[1]+"-"+data[0];
                
                
                inicio=dataTratada +" "+ hora[0]+":00:00";
                if (hora[0].equals("00")) {
                    fim=dataTratada +" "+hora[0]+":59:59";
                } else {
                    fim=dataTratada +" "+ horaf[0]+":00:00";
                }
                
                  if (hora[0].equals("23")) {
                    fim=dataTratada +" "+hora[0]+":59:59";
                } else {
                    fim=dataTratada +" "+ horaf[0]+":00:00";
                }
                
         
                
                if (relat.getRpm(inicio,fim,mct)== null) {
                    
                    
                }else{
                    
                  rpmUni= relat.getRpm(inicio,fim,mct);
                  rpmUni02=relat.getRpm02(inicio,fim,mct);
                  
                 
               vetRelatorio[1][g]=rpmUni;
               vetRelatorio[0][g]=inicio+" a "+fim;
               vetRelatorio[2][g]=rpmUni02;
               
                    System.out.println("Periodo : "+inicio+" ###  "+fim+" ## RPM: "+relat.getRpm(inicio,fim,mct));
                     
                     
 g++;
                     
                }
                

               
            }

            dataBegin.add(Calendar.DATE, 1);

        }
        
    return vetRelatorio;
}

    public String getRpm(String inicio, String fim,String mct ) {

        String Relatorio = null;

        //SCRIPT IGN
        String SqlQueryIgn = (" \n" +
" SELECT timediff(max(iirtn_messagetime),min(iirtn_messagetime)) as diferença, iirtn_rpm\n" +
" FROM exporta.messagereturn_iirtn where iirtn_rpm > 0 and iirtn_mctaddress='"+mct+"' and iirtn_messagetime between \""+inicio+"\" and \""+fim+"\";");

        //É iniciada a variavel "Relatorio" que depois receberá os valores do objeto "rs"
        //Conexão
        Connection c = null;
       
        try {
                Connection con = ConexaoMySQL.getConexaoMySQL();
           Statement stmt = con.createStatement();
           

            ResultSet rs = stmt.executeQuery(SqlQueryIgn);
         
            while (rs.next()) {
               
                Relatorio = rs.getString("iirtn_rpm");
                if(Relatorio == null){
                    Relatorio="0";
                }
            }

            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }

        return Relatorio;
    }
    
    public String getRpm02(String inicio, String fim,String mct ) {

        String Relatorio = null;

        //SCRIPT IGN
        String SqlQueryIgn = (" \n" +
" SELECT timediff(max(iirtn_messagetime),min(iirtn_messagetime)) as diferença, IIRTN_Velocity\n" +
" FROM exporta.messagereturn_iirtn where IIRTN_Velocity > 0 and iirtn_mctaddress='"+mct+"' and iirtn_messagetime between \""+inicio+"\" and \""+fim+"\";");

        //É iniciada a variavel "Relatorio" que depois receberá os valores do objeto "rs"
        //Conexão
        Connection c = null;
       
        try {
                Connection con = ConexaoMySQL.getConexaoMySQL();
           Statement stmt = con.createStatement();
           

            ResultSet rs = stmt.executeQuery(SqlQueryIgn);
         
            while (rs.next()) {
               
                Relatorio = rs.getString("IIRTN_Velocity");
                if(Relatorio == null){
                    Relatorio="0";
                }
            }

            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }

        return Relatorio;
    }

 
}
