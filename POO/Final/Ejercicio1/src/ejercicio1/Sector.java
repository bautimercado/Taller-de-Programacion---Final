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
public class Sector {
    private Coche [] lugares;
    private int cantCoches;
    
    private int costoPorHora;
    
    public Sector (int costoPorHora){
        this.costoPorHora = costoPorHora;
        
        this.lugares = new Coche[20];
        this.cantCoches = 0;
    }
    
    public int agregarCoche(Coche unCoche){
        int pos = -1;
        if (cantCoches < 20){
            pos = cantCoches;
            this.lugares[cantCoches++] = unCoche;
        }
        return pos;
    }
    
    public int getCantCoches(){
        return cantCoches;
    }
}
