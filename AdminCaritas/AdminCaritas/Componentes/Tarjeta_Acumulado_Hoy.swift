//
//  Tarjeta_Acumulado_Hoy.swift
//  AdminCaritas
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI

struct Tarjeta_Acumulado_Hoy: View {
    @State var totalCobrado: Float = 0.0
    var administrador: Administrador
    
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 250, height: 90)
                    .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.96))
                    .shadow(color: .gray, radius: 3, x: 0, y: 2)
                
                VStack{
                    Text("Acumulado Hoy")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray)
                    
                    Text("$\(totalCobrado, specifier: "%.2f")")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 0.03, green: 0.347, blue: 0.545))
                    
                }
            }
        }
        .onAppear(){
            totalCobrado = getTotalDineroCobrado()
        }
    }
    
    func getTotalDineroCobrado() -> Float {
        let listaRecibosEstatus = getRecibosEstatus(token: administrador.access_token)
        let total: Float
        total = listaRecibosEstatus.reduce(0) { (result, recibosEstatus) in
            if recibosEstatus.Estatus == "Cobrado" {
                return result + (recibosEstatus.Total)
            } else {
                return result
            }
        }
        return total
    }
    
}

struct Tarjeta_Acumulado_Hoy_Previews: PreviewProvider {
    static var previews: some View {
        Tarjeta_Acumulado_Hoy(administrador: Administrador(access_token: "", token_type: "", idRecolector: 1))
    }
}
