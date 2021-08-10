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
public class Director extends Persona{
    private int antiguedad;
    
    public Director(String nombre, String dni, int edad, int antiguedad){
        super(nombre, dni, edad);
        this.antiguedad = antiguedad;
    }
    
    public String toString(){
        String aux = super.toString()+" Antigüedad: "+antiguedad;
        return aux;
    }
}
