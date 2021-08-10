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
public class Catalogo {
    private Artista [] artistas;
    
    public Catalogo(){
        artistas = new Artista[15];
    }
    
    public void agregarArtista(Artista unArtista, int categoria){
        //Suponiendo que el parametro categoria es un nro entre 1..15 y no entre 0..14
        if ((1 <= categoria) && (categoria <= 15))
            artistas[categoria-1] = unArtista;
    }
    
    public String toString(){
        String aux = "";
        for (int i = 0; i < 15; i++){
            aux += " Categoria "+(i+1);
            if (artistas[i] != null)
                aux += artistas[i].toString();
            else
                aux += " Sin artista";
        }
        return aux;
    }
}
