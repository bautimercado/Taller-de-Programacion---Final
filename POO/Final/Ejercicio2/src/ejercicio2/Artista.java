/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejercicio2;

/**
 *
 * @author Usuario
 */
public class Artista {
    private String nombre;
    private String obra;
    
    public Artista(String nombre, String obra){
        this.nombre = nombre;
        this.obra = obra;
    }
    
    public String toString(int nro){
        String aux = "Nombre de artista "+(nro+1)+" : "+this.nombre+" Obra: "+this.obra+" ";
        return aux;
    }
}
