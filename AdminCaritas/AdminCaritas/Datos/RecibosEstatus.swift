//
//  Recibos.swift
//  Reto
//
//  Created by Jaime Cabrera on 13/10/23.
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


func getRecibosNoCobradosComentarios() -> Array<recibosComentarios> {
    var ListaRecibosNoCobrados: Array<recibosComentarios> = []
    
    guard let url = URL(string:"http://10.14.255.84:8082/recibosComentarios") else {
        print("No pude asignar el URL del API")
        return ListaRecibosNoCobrados
    }
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: url) {
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
