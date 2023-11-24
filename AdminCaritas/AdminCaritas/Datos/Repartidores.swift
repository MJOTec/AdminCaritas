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

func getEstadoRecolector(idRecolector:Int) -> ActualizarEstado{
    var estadoRecolector = ActualizarEstado(estatus_entrega: "")
    
    guard let url = URL(string:"http://10.14.255.84:8082/estatusRecolector/\(idRecolector)") else {
        print("No pude asignar el URL del API")
        return estadoRecolector
    }
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: url) {
        data, response, error in
        
        let jsonDecoder = JSONDecoder()
        if (data != nil){
            do {
                estadoRecolector = try jsonDecoder.decode(ActualizarEstado.self, from: data!)
            } catch {
                print(error)
            }
            group.leave()
        }
    }
    
    task.resume()
    group.wait()
    print("******** saliendo de la función")
    return estadoRecolector
}

func Actualizar_Estado_Recolector(estado: ActualizarEstado, id_recolector: Int){
    
    let body: [String: Any] = [
        "estatus_entrega": estado.estatus_entrega
    ]
    
    let jsonData = try? JSONSerialization.data(withJSONObject: body)
    
    guard let url = URL(string: "http://10.14.255.84:8082/actualizarEstadoRecolector/\(id_recolector)") else{
        print("No pude asigna el URL del API")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    request.httpBody = jsonData
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: request){ data, response, error in
        
        if (data != nil){
            let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("*************** Respuesta *****************")
                print(responseJSON)
            }
        }else{
            print("Error: \(error)")
        }
        group.leave()
    }
    
    task.resume()
    group.wait()
    print("********* saliendo de la función")
    return
}

func ReasignarRecolector(estado: ActualizarEstado, id_recolector: Int){
    
    let body: [String: Any] = [
        "estatus_entrega": estado.estatus_entrega
    ]
    
    let jsonData = try? JSONSerialization.data(withJSONObject: body)
    
    guard let url = URL(string: "http://10.14.255.84:8082/actualizarEstadoRecolector/\(id_recolector)") else{
        print("No pude asigna el URL del API")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    request.httpBody = jsonData
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: request){ data, response, error in
        
        if (data != nil){
            let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("*************** Respuesta *****************")
                print(responseJSON)
            }
        }else{
            print("Error: \(error)")
        }
        group.leave()
    }
    
    task.resume()
    group.wait()
    print("********* saliendo de la función")
    return
}

struct Repartidores: Identifiable, Codable {
    var id: Int
    var Nombre: String
    var ApellidoPaterno: String
    var ApellidoMaterno: String
    var EstadoEntrega: String
}

struct ActualizarEstado: Codable {
    var estatus_entrega: String
}
