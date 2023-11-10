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
                if recolector.EstadoEntrega == "No Entregado" {
                    Tarjeta_Nombre_Amarillo()
                } else {
                    Tarjeta_Nombre_Verde2()
                }
                
                Text("\(recolector.Nombre) \(recolector.ApellidoPaterno)")

                    .font(.title2)
                    .fontWeight(.bold)
                    .offset(x: 15, y: -18)
                    .frame(width: 310, height: 28, alignment: .leading)
                    
                
                
                Text("\(recolector.EstadoEntrega)")
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
        var recolector1 = listaRepartidores[0]
        SwiftUIView(recolector: recolector1)
    }
}
