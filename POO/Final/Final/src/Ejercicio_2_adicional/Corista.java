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
public class Corista extends Persona{
    private int tono;
    
    public Corista(String nombre, String dni, int edad, int tono){
        super(nombre, dni, edad);
        this.tono = tono;
    }
    
    
}
