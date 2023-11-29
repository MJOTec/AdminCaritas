//
//  Cambiar_Recolector_View.swift
//  AdminCaritas
//
//  Created by Jimena Gallegos on 24/11/23.
//

import SwiftUI

struct Cambiar_Recolector_View: View {
    let donador: Int
    var administrador: Administrador
    @State var listaRecolectores: Array<Repartidores> = []
    @State var cambiar = false
    @State var cambiado = false
    @State var nombre = "Jimena"
    @State var id_rec = 0
    @State var estatus_entrega = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                Header()
                    .padding(.top)
                
                Text("Recolectores Disponibles")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: 350, alignment: .center)
                
                VStack{
                    List{
                        ForEach(listaRecolectores.filter{$0.EstadoEntrega == "No Entregado"}) { recolectores in
                            Button(action: {
                                cambiar = true
                                nombre = recolectores.Nombre
                                id_rec = recolectores.id
                                estatus_entrega = "Entregado"
                            }){
                                SwiftUIView(recolector: recolectores)
                            }
                            .alert(isPresented: $cambiar) {
                                Alert(
                                    title: Text("¿Seguro que desea reasignar el recibo al recolector \(nombre)?"),
                                    primaryButton: .default(
                                        Text("Continuar"),
                                        action: {
                                            ReasignarRecolector(reasignar: Reasignar(id_recolector: id_rec, id_bitacora: donador), token: administrador.access_token
                                            )
                                            cambiar = false
                                            cambiado = true
                                            
                                        }
                                    ),
                                    secondaryButton: .destructive(
                                        Text("Cancelar"),
                                        action: {
                                            cambiar = false
                                        }
                                    )
                                )
                            }
                        }
                    }
                    .listStyle(InsetListStyle())
                    
                    NavigationLink(isActive: $cambiado, destination: { ContentView(administrador: administrador) }, label: { EmptyView()})
                    
                    Spacer()
                }
                .frame(width: 350)
                .onAppear(){
                    listaRecolectores = getRepartidores(token: administrador.access_token)
                }
            }
            
        }
    }
}

struct Cambiar_Recolector_View_Previews: PreviewProvider {
    static var previews: some View {
        Cambiar_Recolector_View(donador: 1, administrador: Administrador(access_token: "", token_type: "", idRecolector: 1))
    }
}
