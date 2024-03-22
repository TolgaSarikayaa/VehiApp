//
//  ServiceDetailCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 18.02.24.
//

import SwiftUI
import CoreData

struct ServiceDetailCV: View {
    
    @State private var isNavigationActive = false
    
    @FetchRequest(
        entity: ServiceEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ServiceEntity.partName, ascending: true)]
    ) var serviceParts: FetchedResults<ServiceEntity>
    
    
    private var groupedServiceList : [String: [ServiceEntity]] {
        Dictionary(grouping: serviceParts) { parts in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: parts.date ?? Date())
        }
    }
    var body: some View {
        NavigationStack {
                 VStack {
                     if serviceParts.isEmpty {
                         EmptyStateView()
                     } else {
                         ServiceListView(serviceParts: serviceParts)
                         
                     }
                 }
                 .navigationBarItems(trailing: addButton)
                 .sheet(isPresented: $isNavigationActive) {
                     ServiceEditCV()
                 }
                 .navigationTitle("Service Info")
             }
         }

         private var addButton: some View {
             Button(action: {
                 isNavigationActive.toggle()
             }) {
                 Image(systemName: "plus.app")
             }
         }
}

struct EmptyStateView: View {
    var body: some View {
        Text("Add Service")
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
    }
}

struct ServiceListView: View {
    var serviceParts: FetchedResults<ServiceEntity>
    @Environment(\.managedObjectContext) var managedObjectContext

    private var groupedServiceList: [String: [String: [ServiceEntity]]] {
        let groupedByDate = Dictionary(grouping: serviceParts) { part in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: part.date ?? Date())
        }

        var groupedByDateAndBrand: [String: [String: [ServiceEntity]]] = [:]
        for (date, parts) in groupedByDate {
            let groupedByBrand = Dictionary(grouping: parts) { $0.carBrand ?? "Unknown" }
            groupedByDateAndBrand[date] = groupedByBrand
        }
        
        return groupedByDateAndBrand
    }

    var body: some View {
        List {
            ForEach(groupedServiceList.keys.sorted(), id: \.self) { date in
                Section(header: Text(date)) {
                    ForEach(groupedServiceList[date]!.keys.sorted(), id: \.self) { brand in
                        Section(header: Text("Car: \(brand)")) {
                            ForEach(groupedServiceList[date]![brand]!, id: \.self) { part in
                                HStack {
                                    Image(part.partImageName ?? "placeholder")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                    Text(part.partName ?? "Unknown")
                                    Spacer()
                                    Text("\(part.price, specifier: "%.2f")$")
                                }
                            }
                            .onDelete { offsets in
                                deleteService(at: offsets, for: date, and: brand)
                            }
                        }
                    }
                }
            }
        }
    }

    func deleteService(at offsets: IndexSet, for date: String, and brand: String) {
        guard let brandGroup = groupedServiceList[date]?[brand] else { return }
        offsets.forEach { index in
            let part = brandGroup[index]
            managedObjectContext.delete(part)
        }
        try? managedObjectContext.save()
    }
}
#Preview {
    ServiceDetailCV()
}
