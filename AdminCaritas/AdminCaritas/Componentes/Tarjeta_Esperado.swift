//
//  Tarjeta_Esperado.swift
//  AdminCaritas
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI

struct Tarjeta_Esperado: View {
    @State var totalCantidad: Float = 0.0

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 250, height: 90)
                    .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.96))
                    .shadow(color: .gray, radius: 3, x: 0, y: 2)

                VStack {
                    Text("Esperado")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray)

                    Text("$\(totalCantidad, specifier: "%.2f")")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 0.03, green: 0.347, blue: 0.545))
                }
            }
        }
        .onAppear {
            totalCantidad = getTotalDineroEsperado()
        }
    }

    func getTotalDineroEsperado() -> Float {
        let listaRecibosEstatus = getRecibosEstatus()

        let total = listaRecibosEstatus.reduce(0) { (result, recibosEstatus) in
            return result + Float(recibosEstatus.Total)
        }

        return total
    }
}

struct Tarjeta_Esperado_Previews: PreviewProvider {
    static var previews: some View {
        Tarjeta_Esperado()
    }
}
