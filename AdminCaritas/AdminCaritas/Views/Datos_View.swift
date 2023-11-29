//
//  Datos_View.swift
//  AdminCaritas
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI
import Foundation

struct Datos_View: View {
    let date = Date()
    let df = DateFormatter()
    var administrador: Administrador
    var body: some View {
        VStack(alignment: .center) {
            Header()
            HStack{
                Text("Recolectado")
                    .bold()
                    .font(.title2)
                Spacer()
                Text("\(date.formatted(.dateTime.day().month().year().hour().minute()))")
                    .foregroundColor(.gray)
                Spacer()
            }
            
            List {
                ChartView(administrador: administrador)
                VStack{
                    Spacer()
                    Tarjeta_Esperado(administrador: administrador)
                    Tarjeta_Acumulado_Hoy(administrador: administrador)
                    Spacer()
                }
                .frame(width: 333, alignment: .center)
                BarChartView(administrador: administrador)
            }
            .listStyle(.inset)
        }
        .padding()
    }
}

struct Datos_View_Previews: PreviewProvider {
    static var previews: some View {
        Datos_View(administrador: Administrador(access_token: "", token_type: "", idRecolector: 1))
    }
}
