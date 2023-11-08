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
                Tarjeta_Nombre_Amarilla()
                //Tarjeta_Nombre_Verde()
                
                Text("\(recolector.nombre) \(recolector.apellidos)")
                    .font(.title)
                    .offset( x: -40,y: -20)
                
                Text("\(recolector.estado)")
                    .offset( x: -60 ,y: 20)
                    
                      
                
            }
        }
    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        var recolector1: Repartidores = listaRepartidores[0]
        SwiftUIView(recolector: recolector1)
    }
}
