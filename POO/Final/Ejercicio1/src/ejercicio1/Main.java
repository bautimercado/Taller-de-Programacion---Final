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
public class Main {
    public static void main (String [] args){
        Cochera miCochera = new Cochera(220, 250);
        
        Coche coche1 = new Coche("ABC123", 2);
        Coche coche2 = new Coche("DEF456", 4);
        Coche coche3 = new Coche("GHI789", 12);
        Coche coche4 = new Coche("JKL012", 25);
        
        miCochera.agregarCoche(coche1, "inferior");
        miCochera.agregarCoche(coche2, "superior");
        miCochera.agregarCoche(coche3, "superior");
        miCochera.agregarCoche(coche4, "superior");
        
        System.out.println(miCochera.cocheraConMasCoches());
    }
}
