//
//  CarEditCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import SwiftUI
import CoreData

struct CarListView: View {
    @State private var searchText = ""
    @State private var isNavigationActive = false
   
    
    @FetchRequest( entity: NewCarEntity.entity(), 
        sortDescriptors: [NSSortDescriptor(keyPath: \NewCarEntity.brand, ascending: true)],
        animation: .default)
    
      private var carList: FetchedResults<NewCarEntity>

    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResult, id: \.self) { car in
                    Section {
                        NavigationLink {
                         //  CarDetailCV(car: car)
                        } label: {
                            VStack(alignment: .leading, spacing: 5) {
                                Image("car")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 200)
                                    .cornerRadius(10)
                                
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
                            }
                        }
                        .padding()
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }.onDelete(perform: deleteCar)
            }
            .navigationTitle("My Cars")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isNavigationActive = true
                    }) {
                        Image(systemName: "plus")
                    }
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
            managedObjectContext.delete(car)
        }

        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

public enum Visibility {
    case automatic
    case hidden
    case visible
}
