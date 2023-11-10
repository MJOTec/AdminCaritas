//
//  Status_Admin.swift
//  AdminCaritas
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI

struct Status_Admin: View {
    @State private var status:Bool = false
    @State private var alert:Bool = false
    @State private var buttonExists:Bool = true
    //@State var repatidor: Repartidores
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 160, height: 60)
                    .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.96))
                    .shadow(color: .gray, radius: 3, x: 0, y: 2)
                VStack{
                    Text("Status")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray)
                    if(status == false){
                        Text("No entregado")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hue: 0.564, saturation: 0.106, brightness: 0.417))
                    }
                    else{
                        Text("Entregado")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hue: 0.564, saturation: 0.106, brightness: 0.417))
                    }
                }
            }
            if(buttonExists == true)
            {
                Button(action: {
                    self.alert = true
                }, label: {
                    Text("Prueba")
                        .buttonStyle(.borderedProminent)
                        .frame(width: 140, height: 20)
                })
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.24, green: 0.7, blue: 0.24))
                .alert(isPresented: $alert){
                    Alert(title: Text("¿Cambiar estatus?"),
                          message: Text("Una vez confirmado, no se puede deshacer"),
                          primaryButton: .destructive(Text("Sí"))
                          {
                        self.status = true
                        self.buttonExists = false
                    },
                          secondaryButton: .cancel(Text("No"))
                          
                    )
                }
                .padding(.top, -5)
                .shadow(color: .gray, radius: 3, x: 0, y: 2)
            }
        }
    }
}

struct Status_Admin_Previews: PreviewProvider {
    static var previews: some View {
        //var rep1: Repartidores = listaRepartidores[1]
        Status_Admin()
    }
}
