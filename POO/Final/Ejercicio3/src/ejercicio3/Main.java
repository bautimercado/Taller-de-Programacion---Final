/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejercicio3;

/**
 *
 * @author Usuario
 */
public class Main {
    public static void main (String [] args){
        Catalogo catalogo = new Catalogo();
        
        Artista artista1 = new Artista("Juan", "Argentina");
        Artista artista2 = new Artista("Maria", "Argentina");
        Artista artista3 = new Artista("Ivan", "Rusia");
        
        catalogo.agregarArtista(artista1, 1);
        catalogo.agregarArtista(artista2, 2);
        catalogo.agregarArtista(artista3, 3);
        
        System.out.println(catalogo.cantidadDeArtistasPorNacionalidad("Argentina"));
    }
}
