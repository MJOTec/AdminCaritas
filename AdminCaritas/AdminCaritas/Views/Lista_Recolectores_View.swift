//
//  Lista_Recolectores_View.swift
//  AdminCaritas
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI

struct Lista_Recolectores_View: View {
    
    var body: some View {
        NavigationStack{
            Header()
            
            
            VStack{
                Text("Recolectores")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: 350, alignment: .leading)
                
                List(listaRepartidores.sorted{ $0.estado == "No Entregado" && $1.estado != "No Entregado" }) { Repartidor in
                    /*NavigationLink(destination: KenyuView(recolector: Repartidor)) {
                        SwiftUIView(recolector: Repartidor)
                    }*/
                    NavigationLink(destination: Recolectores_View(recolector: Repartidor)){
                        SwiftUIView(recolector: Repartidor)
                    }
                }.listStyle(InsetListStyle())
                    
                
                
                
            }.padding()
            }
        
        }
    }


struct Lista_Recolectores_View_Previews: PreviewProvider {
    static var previews: some View {
        Lista_Recolectores_View()
    }
}
