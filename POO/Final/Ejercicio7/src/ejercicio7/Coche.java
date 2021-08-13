/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejercicio7;

/**
 *
 * @author Usuario
 */
public class Coche {
    private String patente;
    private int cantHoras;
    
    public Coche(String patente, int cantHoras){
        this.patente = patente;
        this.cantHoras = cantHoras;
    }
    
    public int getCantHoras(){
        return this.cantHoras;
    }
}
