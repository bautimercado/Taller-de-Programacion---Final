/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejercicio1;

/**
 *
 * @author Usuario
 */

public class Cochera {
    private Sector inferior;
    private Sector superior;
    
    public Cochera(int costoHorasSuperior, int costoHorasInferior){
        inferior = new Sector(costoHorasInferior);
        superior = new Sector(costoHorasSuperior);
    }
    
    public int agregarCoche(Coche unCoche, String sector){
        int pos = -1;
        if(sector.toLowerCase().equals("inferior"))
            pos = this.inferior.agregarCoche(unCoche);
        else if (sector.toLowerCase().equals("superior"))
            pos = this.superior.agregarCoche(unCoche);
        
        return pos;
    }
    
    public int agregarCochePorHora(Coche unCoche){
        int pos = -1;
        if (unCoche.getHoras() > 24)
            pos = superior.agregarCoche(unCoche);
        else
            pos = inferior.agregarCoche(unCoche);
        return pos;
    }
    
    public String cocheraConMasCoches(){
        if (superior.getCantCoches() > inferior.getCantCoches())
            return "superior";
        else
            return "inferior";
    }
}
