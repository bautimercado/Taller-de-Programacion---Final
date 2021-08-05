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
public class Catalogo {
    private Artista [] artistasPorCategoria;
    
    public Catalogo(){
        this.artistasPorCategoria = new Artista[15];
    }
    
    public void agregarArtista(Artista unArtista, int categoria){
        /*suponiendo que la variable categoria contiene un nro entre 1 y 15
        *y no entre 0 y 14..
        */
        artistasPorCategoria[categoria-1] = unArtista;
    }
    
    public int cantidadDeArtistasPorNacionalidad(String nacionalidad){
        int cant = 0;
        for (int i = 0; i < 15; i++){
            if ((artistasPorCategoria[i] != null) && (artistasPorCategoria[i].getNacionalidad().equals(nacionalidad)))
                cant++;
        }
        return cant;
    }
}
