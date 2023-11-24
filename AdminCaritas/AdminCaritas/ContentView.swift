//
//  ContentView.swift
//  AdminCaritas
//
//  Created by Alumno on 07/11/23.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    //Variable para acceder a los sensores
    let motion = CMMotionManager()
    @State private var accelerometerData: CMAccelerometerData?
    @State private var accelerometerMoved = false
    var body: some View {
        NavigationStack{
            VStack{
                NavigationLink(destination: LogInView(), isActive: $accelerometerMoved) {
                    EmptyView()
                }
                 
                .hidden()
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
                .onAppear(){
                    startAccelerometer()
                }
            }
        }
            //sirve para cambiar el background del nav bar
            /*
             .onAppear(){
             UITabBar.appearance().barTintColor = UIColor(Color("PantoneGC"))
             UITabBar.appearance().backgroundColor = UIColor(Color("PantoneGC"))
             }
             */
            
    }
    func startAccelerometer() {
        if motion.isAccelerometerAvailable {
            motion.accelerometerUpdateInterval = 0.5

            motion.startAccelerometerUpdates(to: .main) { data, error in
                guard let data = data else { return }
                self.accelerometerData = data

                // Aquí puedes realizar acciones adicionales según el movimiento del acelerómetro
                if data.acceleration.x > 1.0 {
                    // Si el dispositivo se mueve en la dirección positiva de X, por ejemplo, puedes navegar a otra pantalla
                    self.accelerometerMoved = true
                    print("\(data.acceleration.x)")
                }
            }
        }
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
