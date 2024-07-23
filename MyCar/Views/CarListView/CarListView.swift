//
//  CarEditCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import SwiftUI
import CoreData
import TipKit

struct CarListView: View {
    @State private var searchText = ""
    @State private var isNavigationActive = false
    var carTipView = carTip()
   
    
    @FetchRequest(entity: NewCarEntity.entity(), 
        sortDescriptors: [NSSortDescriptor(keyPath: \NewCarEntity.brand, ascending: true)],
        animation: .default)
    
    private var carList: FetchedResults<NewCarEntity>

    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
           NavigationStack {
               HStack {
                   if carList.isEmpty {
                       Text("Register Your Vehicle")
                           .foregroundColor(.gray)
                           .frame(maxWidth: .infinity, maxHeight: .infinity)
                           .background(Color(UIColor.systemBackground))
                   } else {
                       List {
                           ForEach(searchResult, id: \.self) { car in
                               Section {
                                   NavigationLink(destination: CarDetailCV(car: car.toNewCarModel())) {
                                       VStack(alignment: .leading, spacing: 5) {
                                           CarRow(car: car.toNewCarModel())
                                       }
                                   }
                                   .padding()
                                   .cornerRadius(10)
                               }
                           }
                           .onDelete(perform: deleteCar)
                       }
                   }
               }

               .navigationTitle("My Cars")
               .toolbar {
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button(action: {
                           isNavigationActive = true
                       }) {
                           Image(systemName: "car.fill")
                       }
                       .popoverTip(carTipView)
                   }
               }
               .sheet(isPresented: $isNavigationActive) {
                   NewCarCV()
               }
           }
        
           .searchable(text: $searchText)
       }

       var searchResult: [NewCarEntity] {
           if searchText.isEmpty {
               return Array(carList)
           } else {
               return carList.filter { car in
                   car.model?.lowercased().contains(searchText.lowercased()) ?? false ||
                   car.brand?.lowercased().contains(searchText.lowercased()) ?? false
               }
           }
       }
       
       private func deleteCar(at offsets: IndexSet) {
           for index in offsets {
               let car = carList[index]
               NotificationManager.shared.cancelNotification(for: car.toNewCarModel(), type: .maintenance)
               NotificationManager.shared.cancelNotification(for: car.toNewCarModel(), type: .inspection)
               managedObjectContext.delete(car)
           }
           
           do {
               try managedObjectContext.save()
           } catch {
               print(error.localizedDescription)
           }
       }
   }

struct CarRow: View {
    var car: NewCarModel

    var body: some View {
        VStack(alignment: .leading) {
            if let uiImage = car.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .clipped()
                    .cornerRadius(10)
            } else {
                Image("car")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 200)
                    .cornerRadius(10)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(car.brand)
                        .font(.headline)
                    Text(car.model)
                }
                
                Spacer()
                
                Text(car.licensePlate)
                    .frame(alignment: .trailing)
            }
            
                        let today = Date()
                        let daysRemaining = Calendar.current.dateComponents([.day], from: today, to: car.nextMaintenanceDate).day ?? 0
                        let clampedDaysRemaining = max(0, daysRemaining)

                        let totalDays = max(90, clampedDaysRemaining)

                        ProgressView(value: Double(clampedDaysRemaining), total: Double(totalDays))
                            .progressViewStyle(LinearProgressViewStyle())
                            .tint(progressColor(for: daysRemaining))
                            .frame(height: 4)
            
            VStack(alignment: .leading) {
                        Text("Next Service")
                        .font(.system(size: 14))
                if daysRemaining < 0 {
                    HStack {
                        Text("Maintenance day has passed")
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                        Spacer()
                    }
                } else {
                    HStack {
                        Text("\(clampedDaysRemaining)")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        Text("days remaining")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                  }
                }
            }
        }
    }
extension View {
    func progressColor(for daysRemaining: Int) -> Color {
        switch daysRemaining {
        case ..<30:
            return .red
        case 30..<60:
            return .orange
        case 60...:
            return .green
        default:
            return .gray
        }
    }
}

extension NewCarEntity {
    func toNewCarModel() -> NewCarModel {
        let engineType = EngineType(rawValue: self.fuelType ?? "") ?? .benzin
        let image = self.image != nil ? UIImage(data: self.image!) : nil

        return NewCarModel(
            id: self.id ?? UUID(),
            brand: self.brand ?? "",
            model: self.model ?? "",
            fuelType: engineType,
            mileage: Int(self.mileage),
            releaseDate: self.releaseDate ?? Date(),
            nextMaintenanceDate: self.nextMaintenanceDate ?? Date(),
            lastMaintenanceDate: self.lastMaintenanceDate ?? Date(),
            insuranceExpirationDate: self.insuranceExpirationDate ?? Date(),
            licensePlate: self.licensePlate ?? "", image: image
        )
    }
}


