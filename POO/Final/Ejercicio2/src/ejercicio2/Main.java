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
public class Main {
    public static void main(String [] args){
        Catalogo catalogo = new Catalogo();
        
        Artista artista1 = new Artista("Juan", "Ser o no ser");
        Artista artista2 = new Artista("Maria", "Romeo y Julieta");
        
        catalogo.agregarArtista(artista1);
        catalogo.agregarArtista(artista2);
        
        System.out.println(catalogo.toString());
    }
}
