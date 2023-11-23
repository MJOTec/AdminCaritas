//
//  Recolectores_View.swift
//  AdminCaritas
//
//  Created by Alumno on 23/11/23.
//

import SwiftUI

struct Recolectores_View: View {
    var recolector: Repartidores
    let date = Date()
    let df = DateFormatter()
    @State var listaRecibos: Array<Recibos> = []
    
    var body: some View {
        VStack{
            Header()
            Text("\(recolector.nombre) \(recolector.apellidos)")
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
            
            List {
                ForEach(listaRecibos.filter { $0.idRecolector == recolector.id }) { recibo in
                    Recibos_Lista(recibo: recibo)
                }
            }
            .listStyle(.inset)
            .onAppear(){
                listaRecibos = getRecibos()
            }
            .frame(width: 350)
            
            HStack{
                Rectangle()
            }
            
            
            
            Spacer()
            
        }
    }
}

struct Recolectores_View_Previews: PreviewProvider {
    static var previews: some View {
        Recolectores_View(recolector: Repartidores(id: 1, nombre: "Manuel", apellidos: "Ortiz", estado: ""))
    }
}
