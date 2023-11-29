//
//  Lista_Recolectores_View.swift
//  AdminCaritas
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI

struct Lista_Recolectores_View: View {
    @State var listaRecolectores: Array<Repartidores> = []
    var administrador: Administrador
    
    var body: some View {
        
        NavigationStack{
            Header()
            VStack{
                Text("Recolectores")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: 350, alignment: .leading)
                VStack{
                    List{
                        ForEach(listaRecolectores) { recolectores in
                            NavigationLink(destination: Recolectores_View(recolector: recolectores, administrador: administrador)){
                                SwiftUIView(recolector: recolectores)
                            }
                        }
                    }.listStyle(InsetListStyle())
                    Spacer()
                }
                .onAppear(){
                    listaRecolectores = getRepartidores(token: administrador.access_token)
                }
                
            }
            .padding()
        }
        
    }
    
    
}


struct Lista_Recolectores_View_Previews: PreviewProvider {
    static var previews: some View {
        Lista_Recolectores_View(administrador: Administrador(access_token: "", token_type: "", idRecolector: 1))
    }
}
