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
public abstract class Persona {
    private String nombre;
    private String dni;
    private int edad;
    
    public Persona(String nombre, String dni, int edad){
        this.nombre = nombre;
        this.dni = dni;
        this.edad = edad;
    }
    
    public String toString(){
        String aux = " Nombre: "+nombre+" DNI: "+dni+" Edad: "+edad;
        return aux;
    }
}
