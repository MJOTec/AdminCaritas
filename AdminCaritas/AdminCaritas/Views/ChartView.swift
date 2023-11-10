//
//  ChartView.swift
//  PruebaGraficas2
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI
import Charts

struct ToyShape: Identifiable {
    var color: String
    var type: String
    var count: Double
    var id = UUID()
}
/*
 struct ChartView: View {
 var stackedBarData: [ToyShape] = [
 .init(color: "yellow", type: "Pendiente", count: 2),
 .init(color: "green", type: "Cobrado", count: 2),
 .init(color: "red", type: "Pospuesto", count: 2),
 
 ]
 var body: some View {
 Chart {
 ForEach(stackedBarData) { shape in
 BarMark(
 x: .value("Total Count", shape.count)
 )
 .foregroundStyle(by: .value("Shape Color", shape.color))
 }
 }
 .chartForegroundStyleScale([
 "red": .red, "green": .green, "yellow": .yellow
 ])
 .frame(height: 100)
 }
 }
 
 struct ChartView_Previews: PreviewProvider {
 static var previews: some View {
 ChartView()
 }
 }
 */

struct PieChartCell: Shape {
    let startAngle: Angle
    let endAngle: Angle
    func path(in rect: CGRect) -> Path {
        let center = CGPoint.init(x: (rect.origin.x + rect.width)/2, y: (rect.origin.y + rect.height)/2)
        let radii = min(center.x, center.y)
        let path = Path { p in
            p.addArc(center: center,
                     radius: radii,
                     startAngle: startAngle,
                     endAngle: endAngle,
                     clockwise: true)
            p.addLine(to: center)
        }
        return path
    }
}

struct InnerCircle: Shape {
    let ratio: CGFloat
    func path(in rect: CGRect) -> Path {
        let center = CGPoint.init(x: (rect.origin.x + rect.width)/2, y: (rect.origin.y + rect.height)/2)
        let radii = min(center.x, center.y) * ratio
        let path = Path { p in
            p.addArc(center: center,
                     radius: radii,
                     startAngle: Angle(degrees: 0),
                     endAngle: Angle(degrees: 360),
                     clockwise: true)
            p.addLine(to: center)
        }
        return path
    }
}

struct DonutChart: View {
    @State private var selectedCell: UUID = UUID()
    
    let dataModel: ChartDataModel
    let onTap: (ChartCellModel?) -> ()
    var body: some View {
        ZStack {
            PieChart(dataModel: dataModel, onTap: onTap)
            InnerCircle(ratio: 2/3).foregroundColor(.white)
            VStack {
                ForEach(sample) { dataSet in
                    HStack {
                        Circle().foregroundColor(dataSet.color)
                            .frame(width: 15)
                        Text(dataSet.name).font(.footnote)
                    }
                }
            }
        }
    }
}

struct PieChart: View {
    @State private var selectedCell: UUID = UUID()
    
    let dataModel: ChartDataModel
    let onTap: (ChartCellModel?) -> ()
    
    var body: some View {
        ZStack {
            ForEach(dataModel.chartCellModel) { dataSet in
                PieChartCell(startAngle: self.dataModel.angle(for: dataSet.value), endAngle: self.dataModel.startingAngle)
                    .foregroundColor(dataSet.color)
                    .onTapGesture {
                        withAnimation {
                            if self.selectedCell == dataSet.id {
                                self.onTap(nil)
                                self.selectedCell = UUID()
                            } else {
                                self.selectedCell = dataSet.id
                                self.onTap(dataSet)
                            }
                        }
                    }.scaleEffect((self.selectedCell == dataSet.id) ? 1.05 : 1.0)
            }
        }
    }
}

struct ChartView: View {
    @State private var selectedDonut: String = ""
    @State private var chartCellModelList: [ChartCellModel] = []
    @State private var TotalPersonas: Int = 0
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    DonutChart(dataModel: ChartDataModel(dataModel: chartCellModelList), onTap: { dataModel in
                        if let dataModel = dataModel {
                            self.selectedDonut = "Estatus: \(dataModel.name)\nPorcentaje: \(Int(dataModel.value))%"
                        } else {
                            self.selectedDonut = ""
                        }
                    })
                    .onAppear() {
                        chartCellModelList = getRecibos()
                        TotalPersonas = getTotalRecibos()
                    }
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding()
                    
                    VStack {
                        ForEach(chartCellModelList) { dataSet in
                            HStack {
                                Circle().foregroundColor(dataSet.color)
                                    .frame(width: 15)
                                Text("\((dataSet.value/Double(TotalPersonas) * 100), specifier: "%.2f")%").font(.footnote)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getRecibos() -> [ChartCellModel] {
        let listaRecibosEstatus = getRecibosEstatus()
        print(listaRecibosEstatus[0].Total)
        
        // Convierte la lista de RecibosEstatus a la lista de ChartCellModel
        let chartCellModelList: [ChartCellModel] = listaRecibosEstatus.map { recibosEstatus in
            // Define los colores según tus criterios
            let color: Color
            if recibosEstatus.Estatus == "Pendiente" {
                color = .yellow
            } else if recibosEstatus.Estatus == "Cobrado" {
                color = .green
            } else {
                color = .red
            }
            
            // Puedes ajustar el valor según tus necesidades
            let value: CGFloat = CGFloat(recibosEstatus.Cantidad)
            
            // Usa el nombre del estatus como nombre en el nuevo modelo
            let name: String = recibosEstatus.Estatus
            
            return ChartCellModel(color: color, value: value, name: name)
        }
        
        return chartCellModelList
    }
}

func getTotalRecibos() -> Int {
    let listaRecibosEstatus = getRecibosEstatus()
    
    let total = listaRecibosEstatus.reduce(0) { (result, recibosEstatus) in
        return result + recibosEstatus.Cantidad
    }
    
    return total
}




struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ChartCellModel: Identifiable {
    let id = UUID()
    let color: Color
    let value: CGFloat
    let name: String
}

final class ChartDataModel: ObservableObject {
    var chartCellModel: [ChartCellModel]
    var startingAngle = Angle(degrees: 0)
    private var lastBarEndAngle = Angle(degrees: 0)
    
    
    init(dataModel: [ChartCellModel]) {
        chartCellModel = dataModel
    }
    
    var totalValue: CGFloat {
        chartCellModel.reduce(CGFloat(0)) { (result, data) -> CGFloat in
            result + data.value
        }
    }
    
    func angle(for value: CGFloat) -> Angle {
        if startingAngle != lastBarEndAngle {
            startingAngle = lastBarEndAngle
        }
        lastBarEndAngle += Angle(degrees: Double(value / totalValue) * 360 )
        print(lastBarEndAngle.degrees)
        return lastBarEndAngle
    }
}


let sample = [ ChartCellModel(color: Color.yellow, value: 50, name: "Pendiente"),
               ChartCellModel(color: Color.red, value: 20, name: "No cobrado"),
               ChartCellModel(color: Color.green, value: 55, name: "Cobrado")]



