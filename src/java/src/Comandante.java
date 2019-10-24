/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

/**
 *
 * @author Lacerda
 */
public class Comandante {
    String idComandante, nome, matricula, ultimaViagem, contato;

    public Comandante() {
    }

    public Comandante(String idComandante, String nome, String matricula, String ultimaViagem, String contato) {
        this.idComandante = idComandante;
        this.nome = nome;
        this.matricula = matricula;
        this.ultimaViagem = ultimaViagem;
        this.contato = contato;
    }

    public Comandante(String nome, String matricula, String ultimaViagem, String contato) {
        this.nome = nome;
        this.matricula = matricula;
        this.ultimaViagem = ultimaViagem;
        this.contato = contato;
    }

    public String getIdComandante() {
        return idComandante;
    }

    public void setIdComandante(String idComandante) {
        this.idComandante = idComandante;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getUltimaViagem() {
        return ultimaViagem;
    }

    public void setUltimaViagem(String ultimaViagem) {
        this.ultimaViagem = ultimaViagem;
    }

    public String getContato() {
        return contato;
    }

    public void setContato(String contato) {
        this.contato = contato;
    }
    
    
}
