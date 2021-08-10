/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejercicio4;

/**
 *
 * @author Usuario
 */
public class Artista {
    private String nombre;
    private String nacionalidad;
    
    public Artista(String nombre, String nacionalidad){
        this.nombre = nombre;
        this.nacionalidad = nacionalidad;
    }
    
    public String toString(){
        String aux = " Nombre: "+nombre+" Nacionalidad: "+nacionalidad;
        return aux;
    }
}
