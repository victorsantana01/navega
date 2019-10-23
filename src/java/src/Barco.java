/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

/**
 *
 * @author ricardson
 */
public class Barco {
    private String id, mct, nome,motor, modelo, base, dataCad, conta;

    public Barco() {}
    
    public Barco(String id, String mct, String nome, String motor, String modelo, String base, String dataCad, String conta) {
        this.id = id;
        this.mct = mct;
        this.nome = nome;
        this.motor = motor;
        this.modelo = modelo;
        this.base = base;
        this.dataCad = dataCad;
        this.conta = conta;
    }
    public Barco(String id, String mct, String nome, String motor, String modelo, String base, String dataCad) {
        this.id = id;
        this.mct = mct;
        this.nome = nome;
        this.motor = motor;
        this.modelo = modelo;
        this.base = base;
        this.dataCad = dataCad;
    }
    
    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMct() {
        return mct;
    }

    public void setMct(String mct) {
        this.mct = mct;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getMotor() {
        return motor;
    }

    public void setMotor(String motor) {
        this.motor = motor;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getBase() {
        return base;
    }

    public void setBase(String base) {
        this.base = base;
    }

    public String getDataCad() {
        return dataCad;
    }

    public void setDataCad(String dataCad) {
        this.dataCad = dataCad;
    }

    public String getConta() {
        return conta;
    }

    public void setConta(String conta) {
        this.conta = conta;
    }
    
    
}
