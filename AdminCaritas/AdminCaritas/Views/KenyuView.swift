//
//  KenyuView.swift
//  AdminCaritas
//
//  Created by Alumno on 09/11/23.
//

import SwiftUI

struct KenyuView: View {
    let date = Date()
    let df = DateFormatter()
    
    var body: some View {
        VStack{
            Header()
            Text("Manuel Ortiz")
                .font(.title)
                .bold()
                .padding(.bottom)
            HStack{
                Text("   Ruta actual   ")
                    .overlay(RoundedRectangle(cornerRadius: 30)
                        .stroke(Color(red: 0.95, green: 0.95, blue: 0.96), lineWidth: 5)
                    )
                    .background(Color(red: 0.95, green: 0.95, blue: 0.96))
                    .padding(.leading)
                    .foregroundColor(Color(hue: 0.564, saturation: 0.106, brightness: 0.317))
                Spacer()
                Text("\(date.formatted(.dateTime.day().month().year()))")
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
            //Recibos_Pendientes_Lista()
            Spacer(minLength:1)
            HStack(alignment: .top, spacing: 15){
                Tarjeta_Acumulado_Reco()
                //Status_Admin()
            }
        }.padding()
    }
}

struct KenyuView_Previews: PreviewProvider {
    static var previews: some View {
        KenyuView()
    }
}
