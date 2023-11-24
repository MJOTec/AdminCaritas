//
//  Recibos.swift
//  Reto
//
//  Created by Jimena Gallegos on 13/10/23.
//

import Foundation

var listaRecibos = getRecibos()

func getRecibos() -> Array<Recibos>{
    var pendientesList: Array<Recibos> = []
    
    guard let url = URL(string:"http://10.14.255.84:8082/recibosRecolector/1") else {
        print("No pude asignar el URL del API")
        return pendientesList
    }
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: url) {
        data, response, error in
        
        let jsonDecoder = JSONDecoder()
        if (data != nil){
            do {
                pendientesList = try jsonDecoder.decode([Recibos].self, from: data!)
            } catch {
                print(error)
            }
            group.leave()
        }
    }
    
    task.resume()
    group.wait()
    print("******** saliendo de la función")
    return pendientesList
}


struct Recibos: Codable, Identifiable{
    var id: Int
    var idRecolector: Int
    var NombreDonante: String
    var ApellidoPaterno: String
    var ApellidoMaterno: String
    var Direccion: String
    var Colonia: String
    var Municipio: String
    var CP: String
    var Referencias: String
    var TelMovil: String
    var TelCasa: String
    var TelOficina: String
    var Importe: Float
    var Estatus: String
}


func Actualizar_Recibo(recibo: Actualizar_Recibos, id_bitacora: Int){
    
    let body: [String: Any] = [
        "id_recolector": recibo.id_recolector,
        "estatus": recibo.estatus,
        "fecha_reprogramacion": recibo.fecha_reprogramacion,
        "usuario_cancelacion": recibo.usuario_cancelacion,
        "comentarios": recibo.comentarios
    ]
    
    let jsonData = try? JSONSerialization.data(withJSONObject: body)
    
    guard let url = URL(string: "http://10.22.197.45:8082/actualizarRecibo/\(id_bitacora)") else{
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

struct Actualizar_Recibos: Codable {
    var id_recolector: Int
    var estatus: String
    var fecha_reprogramacion: String
    var usuario_cancelacion: Int
    var comentarios: String
}
