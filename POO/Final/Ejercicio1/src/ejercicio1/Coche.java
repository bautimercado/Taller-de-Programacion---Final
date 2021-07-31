/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejercicio1;

/**
 *
 * @author Usuario
 */
public class Coche {
    private String patente;
    private int horas;
    
    public Coche(String patente, int horas){
        this.patente = patente;
        this.horas = horas;
    }
    
    public int getHoras(){
        return horas;
    }
}
