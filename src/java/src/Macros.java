/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import java.util.ArrayList;
import java.util.Iterator;

/**
 *
 * @author Lacerda
 */
public class Macros {
    private String mct;
    private String comentario = "SEM COMENTARIO";
    private ArrayList<String> texto;

//    public Macros(String mct, ArrayList<String> texto) {
//        System.out.println("MACROS CONSTRUTOR");
//        Iterator<String> iteratorText = texto.iterator();
//        ArrayList<String> text2 = new ArrayList<String>();
//        while(iteratorText.hasNext() && iteratorDef.hasNext()){
//            System.out.println("entrou no while");
//            String iT = iteratorText.next();
//            String iD = iteratorDef.next();
//            System.out.println("texto: "+iT+" Def: "+iD);
//            if(iD.equals("4")){
//                this.comentario = comentario+" "+iT;
//            }else{
//               text2.add(iT);
//            }
//        }
//        this.mct = mct;
//        this.texto = text2;
//        System.out.println("HAAAAAAAAAAAAAAAAAAAAAA!!: "+this.comentario);
//    }
//
//    public Macros(){
//        
//    }
    public String getMct() {
        return mct;
    }

    public ArrayList<String> getTexto() {
        return texto;
    }

    public void setMct(String mct) {
        this.mct = mct;
    }

    public void setTexto(ArrayList<String> texto) {
        this.texto = texto;
    }  
    
    public String getComentario(){
        return comentario;
    }
    
    public void setComentario(String c){
        this.comentario = c;
    }
    
}
