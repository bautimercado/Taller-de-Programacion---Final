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
public class Catalogo {
    private Artista [] artistas;
    private int cantArtistas;
    
    public Catalogo(){
        artistas = new Artista[15];
        cantArtistas = 0;
    }
    
    public void agregarArtista(Artista unArtista){
        if (cantArtistas < 15)
            artistas[cantArtistas++] = unArtista;
    }
    
    public String toString(){
        String aux = "";
        for (int i = 0; i < cantArtistas; i++)
            aux += artistas[i].toString(i);
        return aux;
    }
}
