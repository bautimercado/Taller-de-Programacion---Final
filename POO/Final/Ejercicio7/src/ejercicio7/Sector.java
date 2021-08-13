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
public class Sector {
    private Coche [] lugares;
    private int cantCoches;
    private int costoPorHora;
    
    public Sector(int costoPorHora){
        lugares = new Coche[20];
        this.costoPorHora = costoPorHora;
        this.cantCoches = 0;
    }
    
    public int agregarCoche(Coche unCoche){
        int pos = cantCoches;
        lugares[cantCoches++] = unCoche;
        return pos;
    }
    
    public int gerCantCoches(){
        return this.cantCoches;
    }
}
