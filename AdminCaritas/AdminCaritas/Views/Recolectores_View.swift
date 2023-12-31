//
//  Recolectores_View.swift
//  AdminCaritas
//
//  Created by Alumno on 23/11/23.
//

import SwiftUI

struct Recolectores_View: View {
    var recolector: Repartidores
    let date = Date()
    let df = DateFormatter()
    var administrador: Administrador
    @State var click = false
    @State var posible = false
    @State var listaRecibos: Array<Recibos> = []
    @State var estadoRecolector = ActualizarEstado(estatus_entrega: "")
    
    var body: some View {
        NavigationStack{
            VStack{
                var total_recibos = listaRecibos
                    .filter { $0.Estatus == "Pendiente" && $0.idRecolector == recolector.id
                        }
                        .reduce(0) { (result, recibo) in
                            return result + 1
                        }
                
                Header()
                Text("\(recolector.Nombre) \(recolector.ApellidoPaterno)")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                
                HStack{
                    Text("   Ruta actual   ")
                        .overlay(RoundedRectangle(cornerRadius: 30)
                            .stroke(Color(red: 0.95, green: 0.95, blue: 0.96), lineWidth: 5)
                        )
                        .background(Color(red: 0.95, green: 0.95, blue: 0.96))
                        .padding(.leading)
                        .foregroundColor(Color(hue: 0.564, saturation: 0.106, brightness: 0.317))
                    Spacer()
                    Text("\(date.formatted(.dateTime.day().month().year()))")
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
                
                List {
                    ForEach(listaRecibos.filter { $0.idRecolector == recolector.id}) { recibo in
                        NavigationLink(destination: Recibo_View(donador: recibo.id, recolector_id: recolector.id, recolector: recolector, administrador: administrador)) {
                            Recibos_Lista(recibo: recibo)
                        }
                    }
                }
                .listStyle(.inset)
                .onAppear(){
                    listaRecibos = getRecibos(idR: recolector.id, token: administrador.access_token)
                }
                
                HStack{
                    Tarjeta_Acumulado_Reco(recolector: recolector, administrador: administrador)
                    
                    VStack{
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 158, height: 58)
                                .background(Color(red: 0.95, green: 0.95, blue: 0.96))
                                .cornerRadius(7)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 7)
                                        .inset(by: 0)
                                        .stroke(.black, lineWidth: 0)
                                )
                            
                            VStack{
                                Text("Estatus")
                                    .font(.footnote)
                                    .foregroundColor(Color(red: 0.45, green: 0.5, blue: 0.52))
                                
                                Text("\(estadoRecolector.estatus_entrega)")
                                    .foregroundColor(Color(red: 0.45, green: 0.5, blue: 0.52))
                                    .bold()
                                .onAppear(){
                                    estadoRecolector = getEstadoRecolector(idRecolector: recolector.id, token: administrador.access_token)
                                    }
                                        
                            }
                            
                        }
                        if(estadoRecolector.estatus_entrega == "No Entregado" && total_recibos == 0){
                            Button(action: {
                                click = true
                            }){
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .background(Color(red: 0.22, green: 0.57, blue: 0.22))
                                        .cornerRadius(7)
                                        .frame(width: 158, height: 37)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                    
                                    Text("Entregado")
                                        .foregroundColor(.white)
                                    
                                }
                            }
                            .alert(isPresented: $click){
                                Alert(
                                    title: Text("¿Seguro que deseas marcar como Entregado?"),
                                    message: Text("Esta acción no se puede deshacer."),
                                    primaryButton: .default(
                                        Text("Continuar"),
                                        action: {
                                            Actualizar_Estado_Recolector(estado: ActualizarEstado(estatus_entrega: "Entregado"), id_recolector: recolector.id, token: administrador.access_token)
                                        }
                                    ),
                                    secondaryButton: .destructive(
                                        Text("Cancelar"),
                                        action: {
                                            
                                        }
                                    )
                                )
                            }
                        }
                        else{
                            Button(action: {
                                posible = true
                            }){
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .background(Color(red: 0.22, green: 0.57, blue: 0.22))
                                        .cornerRadius(7)
                                        .frame(width: 158, height: 37)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                    
                                    Text("Entregado")
                                        .foregroundColor(.white)
                                    
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .background(Color(red: 0.07, green: 0.05, blue: 0.05).opacity(0.42))
                                        .cornerRadius(7)
                                        .frame(width: 158, height: 37)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                }
                            }
                            .alert(isPresented: $posible) {
                                    Alert(
                                        title: Text("No es posible marcar como entregado"),
                                        message: Text("Puede ser porque quedan recibos pendientes" + " o porque ya esta marcado como entregado.")
                                    )
                                }
                            }
    
                        Spacer()
                    }
                    .frame(height: 97)
                    
                }
            }
            
            
            
            Spacer()
            
        }
        .frame(width: 360)
    }
    
}

struct Recolectores_View_Previews: PreviewProvider {
    static var previews: some View {
        Recolectores_View(recolector: Repartidores(id: 2, Nombre: "Manuel", ApellidoPaterno: "Ortiz", ApellidoMaterno: "Equis", EstadoEntrega: "No Entregado"), administrador: Administrador(access_token: "", token_type: "", idRecolector: 1))
    }
}
