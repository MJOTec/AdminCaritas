//
//  BarChartView.swift
//  AdminCaritas
//
//  Created by Jaime Cabrera on 24/11/23.
//

import SwiftUI
import Charts

struct BarChartView: View {
    var administrador: Administrador
    @State var recibosNoCobrados: Array<recibosComentarios> = []
    var body: some View {
        VStack{
            GroupBox ("Recibos No Cobrados") {
                Chart(recibosNoCobrados) {
                    BarMark (x: .value("Comentarios", $0.Comentarios), y: .value("Cantidad", $0.Cantidad))
                        .foregroundStyle(by: .value("Comentarios", $0.Comentarios))
                }
                .frame(height: 400)
                
            }
        }
            .onAppear() {
                recibosNoCobrados = getRecibosNoCobradosComentarios(token: administrador.access_token)
            }
    }
    
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(administrador: Administrador(access_token: "", token_type: "", idRecolector: 1))
    }
}
