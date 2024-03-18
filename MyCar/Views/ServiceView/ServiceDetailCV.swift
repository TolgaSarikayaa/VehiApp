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
    @Environment(\.managedObjectContext) var managedObjectContext
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
                if groupedServiceList.isEmpty {
                    Text("Add Service")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(UIColor.systemBackground))
                } else {
                    List {
                        ForEach(groupedServiceList.keys.sorted(), id: \.self) { date in
                            Section(header: Text(date)) {
                                ForEach(groupedServiceList[date] ?? [] ) { parts in
                                    HStack {
                                        Image(parts.partImageName ?? "")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                        Text(parts.partName ?? "Unknown")
                                        Text("Car: \((parts.carBrand) ?? "")")
                                        Spacer()
                                        Text("\(parts.price, specifier: "%.2f")$")
                                    }
                                }
                                .onDelete { offsets in
                                    deleteService(at: offsets, for: date)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarItems(trailing: Button(action: {
                isNavigationActive.toggle()
            }) {
                Image(systemName: "plus.app")
            })
            .sheet(isPresented: $isNavigationActive) {
                ServiceEditCV()
            }
            .navigationTitle("Service Info")
        }
    }
    func deleteService(at offsets: IndexSet, for date: String) {
        guard let dateGroup = groupedServiceList[date] else { return }
        offsets.forEach { index in
            let serviceEntity = dateGroup[index]
            managedObjectContext.delete(serviceEntity)
        }
        try? managedObjectContext.save()
    }
}

#Preview {
    ServiceDetailCV()
}
