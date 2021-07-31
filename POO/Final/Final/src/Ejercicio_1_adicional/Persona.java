/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejercicio_1_adicional;

/**
 *
 * @author Usuario
 */
public class Persona {
    private String nombreApellido;
    
    public Persona(String nombreApellido){
        this.nombreApellido = nombreApellido;
    }

    public String getNombreApellido() {
        return nombreApellido;
    }

    public void setNombre(String nombreApellido) {
        this.nombreApellido = nombreApellido;
    }
    
    @Override
    public String toString(){
        String aux = "Nombre y apellido: "+this.nombreApellido+" ";
        return aux;
    }
}
