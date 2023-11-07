//
//  ContentView.swift
//  AdminCaritas
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
                Datos_View()
                    .tabItem{
                        Label("Menu",systemImage: "house.circle")
                    }
                Lista_Recolectores_View()
                    .tabItem{
                        Label("Recolectores", systemImage: "figure.walk.circle.fill")
                    }
                
            }
            .tint(Color("PantoneAC"))
            .navigationBarBackButtonHidden(true)
            //sirve para cambiar el background del nav bar
            /*
             .onAppear(){
             UITabBar.appearance().barTintColor = UIColor(Color("PantoneGC"))
             UITabBar.appearance().backgroundColor = UIColor(Color("PantoneGC"))
             }
             */
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
