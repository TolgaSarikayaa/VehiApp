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
                                           CarRow(car: car)
                                    
                                       }
                                   }
                                   .padding()
                                   .cornerRadius(10)
                                   .shadow(radius: 5)
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
    var car: NewCarEntity

    var body: some View {
        VStack(alignment: .leading) {
            if let image = car.image, let uiImage = UIImage(data: image) {
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
                    Text(car.brand ?? "")
                        .font(.headline)
                    Text(car.model ?? "")
                }
                
                Spacer()
                
                Text(car.licensePlate ?? "")
                    .frame(alignment: .trailing)
            }
            if let nextServiceDate = car.nextMaintenanceDate {
                let daysRemaining = Calendar.current.dateComponents([.day], from: Date(), to: nextServiceDate).day ?? 0
                ProgressView(value: Double(max(daysRemaining, 0)), total: 90)
                    .progressViewStyle(LinearProgressViewStyle())
                    .tint(progressColor(for: daysRemaining))
                    .frame(height: 4)
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


