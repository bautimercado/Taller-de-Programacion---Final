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
public class Main {
    public static void main (String [] args){
        Catalogo miCatalogo = new Catalogo();
        
        Artista artista1 = new Artista("Emilio", "Argentino");
        Artista artista2 = new Artista("Nicolas", "Uruguayo");
        
        miCatalogo.agregarArtista(artista1, 1);
        miCatalogo.agregarArtista(artista2, 15);
        
        System.out.println(miCatalogo.toString());
    }
}
