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
    var body: some View {
        VStack {
            //Header()
            HStack{
                Text("Recolectado")
                    .bold()
                    .font(.largeTitle)
                Spacer()
                Text("\(date.formatted(.dateTime.day().month().year().hour().minute()))")
                    .foregroundColor(.gray)
                Spacer()
            }
            ChartView()
            Tarjeta_Esperado()
            Tarjeta_Acumulado_Hoy()
            Spacer()
        }
        .padding()
    }
}

struct Datos_View_Previews: PreviewProvider {
    static var previews: some View {
        Datos_View()
    }
}
