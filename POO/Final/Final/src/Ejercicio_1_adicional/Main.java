/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejercicio_1_adicional;

/**
 *
 * @author Usuario
 */
public class Main {
    public static void main (String [] args){
        Proyecto proyecto = new Proyecto("Informatica", "SQL");
        
        Persona director = new Persona("Juan Perez");
        
        Investigador investigador1 = new Investigador("Bautista Mercado", "Analista", 1);
        Investigador investigador2 = new Investigador("Johana Bustamante", "Diseñadora", 2);
        
        Subsidio subsidio1 = new Subsidio(1000, "Pagara prata");
        Subsidio subsidio2 = new Subsidio(500, "weno");
        
        investigador1.agregarSubsidio(subsidio2);
        investigador1.agregarSubsidio(subsidio1);
        
        investigador2.agregarSubsidio(subsidio2);
        investigador2.agregarSubsidio(subsidio1);
        
        proyecto.setDirector(director);
        
        proyecto.agregarInvestigador(investigador2);
        proyecto.agregarInvestigador(investigador1);
        
        proyecto.otorgarTodos("Bautista Mercado");
        
        
        System.out.println(proyecto.toString());
    }
}
