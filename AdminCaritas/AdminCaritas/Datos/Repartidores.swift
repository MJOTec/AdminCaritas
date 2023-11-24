//
//  Repartidores.swift
//  Reto
//
//  Created by Jimena Gallegos on 13/10/23.
//

import Foundation

var listaRepartidores = getRepartidores()

func getRepartidores() -> Array<Repartidores>{
    var repartidoresList: Array<Repartidores> = []
    
    guard let url = URL(string:"http://10.14.255.84:8082/recolectores") else {
        print("No pude asignar el URL del API")
        return repartidoresList
    }
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: url) {
        data, response, error in
        
        let jsonDecoder = JSONDecoder()
        if (data != nil){
            do {
                repartidoresList = try jsonDecoder.decode([Repartidores].self, from: data!)
            } catch {
                print(error)
            }
            group.leave()
        }
    }
    
    task.resume()
    group.wait()
    print("******** saliendo de la función")
    return repartidoresList
}

struct Repartidores: Identifiable, Codable {
    var id: Int
    var Nombre: String
    var ApellidoPaterno: String
    var ApellidoMaterno: String
    var EstadoEntrega: String
}
