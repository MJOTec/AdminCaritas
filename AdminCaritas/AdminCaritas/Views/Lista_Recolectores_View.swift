//
//  Lista_Recolectores_View.swift
//  AdminCaritas
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI

struct Lista_Recolectores_View: View {
    
    var body: some View {
        NavigationStack{
            Header()
                .offset(y: -35)
            VStack{
                Text("Recolectores")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: 350, alignment: .leading)
    
                    
                }
            }
        }
    }


struct Lista_Recolectores_View_Previews: PreviewProvider {
    static var previews: some View {
        Lista_Recolectores_View()
    }
}
