/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import logic.Format;

/**
 *
 * @author Lacerda
 */
public class Viagem {
    private String idViagem, nome, status, origem, inicio, destino, fim, mct, comandante, dataCad;
    Format format = new Format();
    public Viagem() {
    }

    public Viagem(String idViagem, String nome, String status, String origem, String inicio, String destino, String fim, String mct, String comandante) {
        this.idViagem = idViagem;
        this.nome = nome;
        this.status = status;
        this.origem = origem;
        this.inicio = inicio;
        this.destino = destino;
        this.fim = fim;
        this.mct = mct;
        this.comandante = comandante;
    }

    public String getIdViagem() {
        return idViagem;
    }

    public void setIdViagem(String idViagem) {
        this.idViagem = idViagem;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOrigem() {
        return origem;
    }

    public void setOrigem(String origem) {
        this.origem = origem;
    }

    public String getInicio() {
        return format.DataFormat(inicio);
    }

    public void setInicio(String inicio) {
        this.inicio = inicio;
    }

    public String getDestino() {
        return destino;
    }

    public void setDestino(String destino) {
        this.destino = destino;
    }

    public String getFim() {
        return format.DataFormat(fim);
    }

    public void setFim(String fim) {
        this.fim = fim;
    }

    public String getMct() {
        return mct;
    }

    public void setMct(String mct) {
        this.mct = mct;
    }

    public String getComandante() {
        return comandante;
    }

    public void setComandante(String comandante) {
        this.comandante = comandante;
    }

    public String getDataCad() {
        return format.DataFormat(dataCad);
    }

    public void setDataCad(String dataCad) {
        this.dataCad = dataCad;
    }
    
    
    
    
    
}
