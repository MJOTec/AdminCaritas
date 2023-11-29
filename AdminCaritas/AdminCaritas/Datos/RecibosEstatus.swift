//
//  Recibos.swift
//  Reto
//
//  Created by Jimena Gallegos on 13/10/23.
//

import Foundation

//var listaRecibosEstatus = getRecibosEstatus(token: "")

func getRecibosEstatus(token: String) -> Array<RecibosEstatus>{
    var ListaRecibos: Array<RecibosEstatus> = []
    
    guard let url = URL(string:"https://equipo16.tc2007b.tec.mx:8443/recibosEstatus") else {
        print("No pude asignar el URL del API")
        return ListaRecibos
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: request) {
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

func getRecibosNoCobradosComentarios(token: String) -> Array<recibosComentarios> {
    var ListaRecibosNoCobrados: Array<recibosComentarios> = []

    guard let url = URL(string:"https://equipo16.tc2007b.tec.mx:8443/recibosComentarios") else {
        print("No pude asignar el URL del API")
        return ListaRecibosNoCobrados
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let group = DispatchGroup()
    group.enter()

    let task = URLSession.shared.dataTask(with: request) {
        data, response, error in

        let jsonDecoder = JSONDecoder()
        if (data != nil){
            do {
                ListaRecibosNoCobrados = try jsonDecoder.decode([recibosComentarios].self, from: data!)
            } catch {
                print(error)
            }
            group.leave()
        }
    }

    task.resume()
    group.wait()
    print("******** saliendo de la función")
    return ListaRecibosNoCobrados
}


struct RecibosEstatus: Codable {
    var Estatus: String
    var Cantidad: Int
    var Total:Float
}

struct recibosComentarios: Codable, Identifiable {
    var id:Int
    var Comentarios: String
    var Cantidad: Int
}
