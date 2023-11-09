//
//  Repartidores_Data.swift
//  Reto
//
//  Created by Jimena Gallegos on 13/10/23.
//

import Foundation

var listaRepartidores = getRepartidores()

func getRepartidores() -> Array<Repartidores>{
    var lista: Array<Repartidores> = [
        Repartidores(id: 1, nombre: "Repartidor", apellidos: "1", estado: "No Entregado"),
        Repartidores(id: 2, nombre: "Repartidor", apellidos: "2", estado: "Entregado"),
        Repartidores(id: 3, nombre: "Repartidor", apellidos: "3", estado: "No Entregado"),
        Repartidores(id: 4, nombre: "Repartidor", apellidos: "4", estado: "Entregado"),
        Repartidores(id: 5, nombre: "Repartidor", apellidos: "5", estado: "No Entregado")
    ]
    
    // Carga datos, api, bd, etc
    
    return lista
}
