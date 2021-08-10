/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejercicio_2_adicional;

/**
 *
 * @author Usuario
 */
public abstract class Coro {
    private String nombre;
    private Director director;
    
    public Coro(Director director){
        this.director = director;
    }
    
    public abstract void agregarCorista(Corista unCorista);
    
    public abstract boolean coroLleno();
    
    public abstract boolean coroBienFormado();
    
    public String toString(){
        String aux = "Nombre coro: "+nombre+" Director: "+director.toString();
        return aux;
    }
}
