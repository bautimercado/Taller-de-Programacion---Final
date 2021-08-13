/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejercicio7;

/**
 *
 * @author Usuario
 */
public class Cochera {
    private Sector inferior;
    private Sector superior;
    
    public Cochera(int costoInferior, int costoSuperior){
        inferior = new Sector(costoInferior);
        superior = new Sector(costoSuperior);
    }
    
    public int agregarCoche(Coche unCoche){
        int pos;
        if (unCoche.getCantHoras() < 24)
            pos = inferior.agregarCoche(unCoche);
        else
            pos = superior.agregarCoche(unCoche);
        return pos;
    }
    
    public String sectorConMasCoches(){
        if (superior.gerCantCoches() > inferior.gerCantCoches())
            return "Superior";
        else
            return "Inferior";
    }
}
