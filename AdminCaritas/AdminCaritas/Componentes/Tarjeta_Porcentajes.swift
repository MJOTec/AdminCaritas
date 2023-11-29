//
//  Tarjeta_Esperado.swift
//  AdminCaritas
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI

struct Tarjeta_Porcentajes: View {
    @State var totalCantidad : Float = 0.0
    var administrador: Administrador
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 70)
                    .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.96))
                    .shadow(color: .gray, radius: 3, x: 0, y: 2)

                VStack {
                    HStack{
                        Text("Total")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.gray)
                    }

                    Text("\(Int(totalCantidad))")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 0.03, green: 0.347, blue: 0.545))
                }
            }
        }.onAppear {
            totalCantidad = Float(getTotalRecibos2())
        }
    }
    
    func getTotalRecibos2() -> Int {
        let listaRecibosEstatus = getRecibosEstatus(token: administrador.access_token)
        
        let total = listaRecibosEstatus.reduce(0) { (result, recibosEstatus) in
            return result + recibosEstatus.Cantidad
        }
        
        return total
    }
}


struct Tarjeta_Porcentajes_Previews : PreviewProvider {
    static var previews: some View {
        Tarjeta_Porcentajes(administrador: Administrador(access_token: "", token_type: "", idRecolector: 1))
    }
}
