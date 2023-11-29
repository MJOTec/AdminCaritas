//
//  Recibo_View.swift
//  AdminCaritas
//
//  Created by Jimena Gallegos on 23/11/23
//

import SwiftUI

struct Recibo_View: View {
    let donador: Int
    let recolector_id: Int
    var recolector: Repartidores
    var administrador: Administrador
    @State private var showingPopover = false
    @State var cambiar = false
    var body: some View {
        NavigationStack{
            VStack{
                var listaRecibos = getRecibos(idR: recolector_id, token: administrador.access_token)
                Header()
                if let info_donador = listaRecibos.first(where: {$0.id == donador}){
                    
                    
                    Text("\(info_donador.NombreDonante) \(info_donador.ApellidoPaterno)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom,3)
                    
                    
                    VStack{
                        Text("Celular")
                            .frame(width: 310, alignment: .leading)
                        
                        Link("\(info_donador.TelMovil)", destination: URL(string: "tel:\(info_donador.TelMovil)")!)
                            .frame(width: 310, alignment: .leading)
                        
                    }
                    .frame(width: 340, height: 70)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.96))
                    .cornerRadius(15)
                    
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Dirreción")
                                
                                Text("\(info_donador.Colonia.capitalized)")
                                    .foregroundColor(.blue)
                                
                                Text("\(info_donador.Direccion.capitalized)")
                                    .foregroundColor(.blue)
                                
                                Text("\(info_donador.Municipio.capitalized)")
                                    .foregroundColor(.blue)
                                
                                Text("\(info_donador.CP.capitalized)")
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                            
                            Mapa()
                        }
                        .frame(width: 310)
                        
                        Divider()
                            .frame(width: 320)
                        
                        Text("Referencia")
                            .frame(width: 310, alignment: .leading)
                        
                        Text("\(info_donador.Referencias.capitalized)")
                            .foregroundColor(.blue)
                            .frame(width: 310, alignment: .leading)
                    }
                    .frame(width: 340, height: 220)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.96))
                    .cornerRadius(15)
                    
                    
                    
                    VStack{
                        Text("Cantidad a cobrar")
                            .frame(width: 310, alignment: .leading)
                        
                        Text("$\(info_donador.Importe, specifier: "%.2f")")
                            .font(
                                Font.custom("SF Pro", size: 26)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.061, green: 0.51, blue: 0.997))
                            .frame(width: 310, alignment: .leading)
                    }
                    .frame(width: 340, height: 72)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.96))
                    .cornerRadius(10)
                    
                    VStack{
                        Text("Recolector actual")
                            .frame(width: 310, alignment: .leading)
                        
                        Text("\(recolector.Nombre) \(recolector.ApellidoPaterno)")
                            .font(
                                Font.custom("SF Pro", size: 26)
                                    .weight(.medium)
                            )
                            .frame(width: 310, alignment: .leading)
                    }
                    .frame(width: 340, height: 72)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.96))
                    .cornerRadius(10)
                    
                    if(info_donador.Estatus == "Pendiente"){
                        VStack{
                            Button(action: {cambiar = true}){
                                VStack{
                                    Text("Cambiar recolector")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                .frame(width: 340, height: 72)
                                .background(Color(red: 0.0, green: 0.558, blue: 0.629))
                                .cornerRadius(10)
                            }
                            
                        }
                        NavigationLink(isActive: $cambiar, destination: { Cambiar_Recolector_View(donador: donador, administrador: administrador) }, label: { EmptyView()})
                    }
                }
            }
                    
                    
                    
                Spacer()
            }
        }
    }

struct Recibo_View_Previews: PreviewProvider {
    static var previews: some View {
        Recibo_View(donador: 1, recolector_id: 1, recolector: Repartidores(id: 1, Nombre:"Manuel", ApellidoPaterno: "Ortiz", ApellidoMaterno: "", EstadoEntrega: ""), administrador: Administrador(access_token: "", token_type: "", idRecolector: 1))
    }
}
