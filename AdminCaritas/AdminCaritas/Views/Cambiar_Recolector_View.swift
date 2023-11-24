//
//  Cambiar_Recolector_View.swift
//  AdminCaritas
//
//  Created by Jimena Gallegos on 24/11/23.
//

import SwiftUI

struct Cambiar_Recolector_View: View {
    let donador: Int
    @State var listaRecolectores: Array<Repartidores> = []
    @State var cambiar = false
    @State var nombre = "Jimena"
    
    var body: some View {
        VStack{
            Header()
                .padding(.top)
            
            Text("Recolectores")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(width: 350, alignment: .leading)
            
            VStack{
                List{
                    ForEach(listaRecolectores) { recolectores in
                        Button(action: {
                            cambiar = true
                            nombre = recolectores.Nombre
                        }){
                            SwiftUIView(recolector: recolectores)
                        }
                        .alert(isPresented: $cambiar) {
                            Alert(
                                title: Text("¿Seguro que desea reasignar el recibo al recolector \(nombre)?"),
                                primaryButton: .default(
                                    Text("Continuar"),
                                    action: {
                                        cambiar = false
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
                Spacer()
            }
            .onAppear(){
                listaRecolectores = getRepartidores()
            }
        
        }
    }
}

struct Cambiar_Recolector_View_Previews: PreviewProvider {
    static var previews: some View {
        Cambiar_Recolector_View(donador: 1)
    }
}
