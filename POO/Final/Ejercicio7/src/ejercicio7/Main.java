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
public class Main {
    public static void main (String [] args){
        Cochera miCochera = new Cochera(250, 220);
        
        Coche coche1 = new Coche("abc123",12);
        Coche coche2 = new Coche("def456",25);
        Coche coche3 = new Coche("ghi879",30);
        Coche coche4 = new Coche("jkl",100);
                
        miCochera.agregarCoche(coche1);
        miCochera.agregarCoche(coche2);
        miCochera.agregarCoche(coche3);
        miCochera.agregarCoche(coche4);
        
        System.out.println(miCochera.sectorConMasCoches());
    }
}
