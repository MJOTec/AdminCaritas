//
//  SwiftUIView.swift
//  AdminCaritas
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI
    
struct SwiftUIView: View {
    var recolector: Repartidores
    
    var body: some View {
        VStack{
            ZStack{
                if recolector.estado == "No Entregado" {
                    Tarjeta_Nombre_Amarillo()
                } else {
                    Tarjeta_Nombre_Verde2()
                }
                
                Text("\(recolector.nombre) \(recolector.apellidos)")

                    .font(.title2)
                    .fontWeight(.bold)
                    .offset(x: 15, y: -18)
                    .frame(width: 310, height: 28, alignment: .leading)
                    
                
                
                Text("\(recolector.estado)")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                    .padding(.leading, -130)
                    .padding(.top, 33)
                    
                    
                      
                
            }
        }
    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        var recolector1: Repartidores = listaRepartidores[2]
        SwiftUIView(recolector: recolector1)
    }
}
