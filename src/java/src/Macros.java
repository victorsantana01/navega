/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import java.util.ArrayList;

/**
 *
 * @author Lacerda
 */
public class Macros {
    private String mct;
    private ArrayList<String> texto;

    public Macros(String mct, ArrayList<String> texto) {
        this.mct = mct;
        this.texto = texto;
    }

    public Macros(){
        
    }
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

    
    
    
    
}
