//
//  FuelDetailView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 17.03.24.
//

import SwiftUI
import CoreData

struct FuelDetailView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @State private var fuelStats: [FuelStats] = []
    @EnvironmentObject var colorManager: ColorManager
    
    @State private var colorMap: [String: Color] = [:]
    
    private func fetchFuelStats() {
        let request: NSFetchRequest<FuelEntity> = FuelEntity.fetchRequest()
        do {
            let fuels = try managedObjectContext.fetch(request)
            let groupedFuels = Dictionary(grouping: fuels, by: { $0.carBrand ?? "" })
            fuelStats = groupedFuels.map { (brand, fuels) in
                let totalFuel = fuels.reduce(0) { $0 + ($1.price) }
                colorManager.setColor(for: brand)
                return FuelStats(brand: brand, totalFuel: totalFuel)
            }
        } catch {
            print("Error fetching fuels: \(error)")
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                PieChart(fuelStats: fuelStats, colorMap: colorManager.colorMap)
                    .frame(height: 260)
                    .padding(.top)
                
                List(fuelStats, id: \.brand) { stat in
                    HStack {
                        Circle()
                            .fill(colorManager.colorMap[stat.brand] ?? .black)
                            .frame(width: 20, height: 20)
                        Text(stat.brand)
                        Spacer()
                        Text("\(stat.totalFuel, specifier: "%.2f")$")
                    }
                }
            }
            .navigationTitle("Total Fuel Purchased")
            .onAppear {
                fetchFuelStats()
            }
        }
    }
}
   extension Color {
       static var random: Color {
           return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
       }
   }

   struct PieChart: View {
       var fuelStats: [FuelStats]
       var colorMap: [String: Color]

       var body: some View {
           GeometryReader { geometry in
                      let width = geometry.size.width
                      let height = geometry.size.height
                      let radius = min(width, height) / 2
                      let center = CGPoint(x: width / 2, y: height / 2)
                      let totalFuel = fuelStats.reduce(0) { $0 + $1.totalFuel }

                      ZStack {
                          Color.clear

                          ForEach(fuelStats, id: \.brand) { stat in
                              let index = fuelStats.firstIndex(where: { $0.brand == stat.brand }) ?? 0
                              let startAngle = fuelStats[..<index].reduce(0) {
                                  $0 + ($1.totalFuel / totalFuel) * 360
                              }
                              let endAngle = startAngle + (stat.totalFuel / totalFuel) * 360
                              let percentage = (stat.totalFuel / totalFuel) * 100
                              let midAngle = Angle(degrees: (startAngle + endAngle) / 2)

                             
                              let labelPosition = CGPoint(
                                  x: center.x + (radius * 0.8) * CGFloat(cos(midAngle.radians)),
                                  y: center.y + (radius * 0.8) * CGFloat(sin(midAngle.radians))
                              )

                              Path { path in
                                  path.move(to: center)
                                  path.addArc(center: center, radius: radius, startAngle: .degrees(startAngle), endAngle: .degrees(endAngle), clockwise: false)
                              }
                              .fill(colorMap[stat.brand] ?? .black)

                            
                              Text("\(String(format: "%.1f", percentage))%")
                                  .position(labelPosition)
                                  .font(.caption)
                          }
                      }
                      .overlay(
                          Circle()
                              .fill(Color.white)
                              .frame(width: radius * 1.2, height: radius * 1.2)
                      )
                  }
              }
          }




