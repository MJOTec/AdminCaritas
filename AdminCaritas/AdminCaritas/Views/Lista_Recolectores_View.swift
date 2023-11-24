//
//  Lista_Recolectores_View.swift
//  AdminCaritas
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI

struct Lista_Recolectores_View: View {
    @State var listaRecolectores: Array<Repartidores> = []
    
    var body: some View {
        
        NavigationStack{
            Header()
            VStack{
                Text("Recolectores")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: 350, alignment: .leading)
                VStack{
                    List{
                        ForEach(listaRecolectores) { recolectores in
                            NavigationLink(destination: Recolectores_View(recolector: recolectores)){
                                SwiftUIView(recolector: recolectores)
                            }
                        }
                    }.listStyle(InsetListStyle())
                    Spacer()
                }
                .onAppear(){
                    listaRecolectores = getRepartidores()
                }
                
            }
            .padding()
        }
        
    }
    
    
}


struct Lista_Recolectores_View_Previews: PreviewProvider {
    static var previews: some View {
        Lista_Recolectores_View()
    }
}
