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
public class Proyecto {
    private String nombre;
    private String codigo;
    private Persona director;
    
    private Investigador [] investigadores;
    private int cantInvestigadores;
    
    public Proyecto(String nombre, String codigo){
        this.nombre = nombre;
        this.codigo = codigo;
        
        this.investigadores = new Investigador[50];
        this.cantInvestigadores = 0;
    }
    
    public void agregarInvestigador(Investigador unInvestigador){
        if (cantInvestigadores < 50)
            investigadores[cantInvestigadores++] = unInvestigador;
    }
    
    public double dineroTotalOtorgado(){
        double montoTotal = 0;
        for (int i = 0; i < cantInvestigadores; i++){
            montoTotal += investigadores[i].obtenerMontoSubsidiosOtorgados();
        }
        return montoTotal;
    }
    
    public int buscarInvestigador(String nombreApellido){
        int i = 0;
        while ((i < this.cantInvestigadores) && (!this.investigadores[i].getNombreApellido().equals(nombreApellido)))
            i++;
        if (!this.investigadores[i].getNombreApellido().equals(nombreApellido))
            return -1;
        else
            return i;
    }
    
    public int cantidadDeSubsidios(String nombreApellido){
        int pos = this.buscarInvestigador(nombreApellido);
        if (pos != -1){
            return this.investigadores[pos].getCantSubsidios();
        } else {
            System.out.println("No se encontro al investigador");
            return -1;
        }
    }
    
    public void otorgarTodos(String nombreApellido){
        int pos = this.buscarInvestigador(nombreApellido);
        if (pos != -1){
            this.investigadores[pos].otorgarSubsidios();
        }
    }
    
    public String stringInvestigadores(){
        String aux = "";
        for (int i = 0; i < this.cantInvestigadores; i++){
            aux = aux + "Investigador "+(i+1)+" "+this.investigadores[i].toString();
        }
        return aux;
    }
    
    @Override
    public String toString(){
        String aux = "Nombre: "+this.nombre+" Codigo: "+this.codigo;
        aux = aux +" Director: "+director.toString()+" "+this.stringInvestigadores();
        return aux;
    }

    public Persona getDirector() {
        return director;
    }

    public void setDirector(Persona director) {
        this.director = director;
    }
    
    
}
//;