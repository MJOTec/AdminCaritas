//
//  Recibos.swift
//  Reto
//
//  Created by Jimena Gallegos on 13/10/23.
//

import Foundation

var listaRecibosEstatus = getRecibosEstatus()

func getRecibosEstatus() -> Array<RecibosEstatus>{
    var ListaRecibos: Array<RecibosEstatus> = []
    
    guard let url = URL(string:"http://10.14.255.84:8082/recibosEstatus") else {
        print("No pude asignar el URL del API")
        return ListaRecibos
    }
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: url) {
        data, response, error in
        
        let jsonDecoder = JSONDecoder()
        if (data != nil){
            do {
                ListaRecibos = try jsonDecoder.decode([RecibosEstatus].self, from: data!)
            } catch {
                print(error)
            }
            group.leave()
        }
    }
    
    task.resume()
    group.wait()
    print("******** saliendo de la función")
    return ListaRecibos
}


struct RecibosEstatus: Codable {
    var Estatus: String
    var Cantidad: Int
    var Total:Float
}
