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
public class Investigador extends Persona {
    private String especialidad;
    private int categoria;
    
    private Subsidio [] subsidios;
    private int cantSubsidios;
    
    public Investigador(String nombreApellido, String especialidad, int categoria){
        super(nombreApellido);
        this.especialidad = especialidad;
        this.categoria = categoria;
        
        this.subsidios = new Subsidio[5];
        this.cantSubsidios = 0;
    }

    public String getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }

    public int getCategoria() {
        return categoria;
    }

    public void setCategoria(int categoria) {
        this.categoria = categoria;
    }

    public int getCantSubsidios() {
        return cantSubsidios;
    }

    public void setCantSubsidios(int cantSubsidios) {
        this.cantSubsidios = cantSubsidios;
    }
    
    
    public void agregarSubsidio(Subsidio unSubsidio){
        if (cantSubsidios < 5)
            subsidios[cantSubsidios++] = unSubsidio;
    }
    
    public double obtenerMontoSubsidiosOtorgados(){
        double monto = 0;
        for (int i = 0; i < this.cantSubsidios; i++){
            if (this.subsidios[i].isOtorgado()){
                monto = monto + this.subsidios[i].getMonto();
            }
        }
        return monto;
    }
    
    public void otorgarSubsidios(){
        for (int i = 0; i < this.cantSubsidios; i++){
            this.subsidios[i].setOtorgado(true);
        }
    }
    
    public String toString(){
        String aux = super.toString()+"Categoria: "+this.categoria+" Dinero de subsidios otorgados: "+this.obtenerMontoSubsidiosOtorgados()+" ";
        return aux;
    }
}
