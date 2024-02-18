//
//  CarDetailTestCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 01.02.24.
//

import SwiftUI

struct CarDetailCV: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var isNavigationActive = false
    
    @ObservedObject var carDetailViewModel = CarDetailViewModel()
    @ObservedObject var newCarModel = NewCarModel()
    @State private var fuelTyp : String = ""
    
     var car : CarInformation
    
    var body: some View {
        TabView {
                     HStack {
                         VStack(alignment: .leading) {
                             Text(newCarModel.selectedBrand)
                                 .font(.title)
                                 .fontWeight(.bold)
                             Text(newCarModel.selectedModel)
                                 .font(.title2)
                                 .padding(.bottom, 20)
                             HStack {
                                 Image(systemName: "fuelpump.circle.fill")
                                     .font(.system(size: 36))
                                 Text("\(car.fuelType.rawValue) Fuel")
                                     .font(.system(size: 20))
                             }
                             .padding(.bottom, 25)
                             
                             HStack {
                                 Image(systemName: "car.rear.road.lane.dashed")
                                     .font(.system(size: 33))
                                 Text("\(newCarModel.mileage) KM")
                                     .font(.system(size: 20))
                             }
                             .padding(.bottom, 25)
                             
                             HStack {
                                 Image(systemName: "calendar.circle.fill")
                                     .font(.system(size: 36))
                                 Text("Release date \(newCarModel.selectedReleaseDate.onlyDateFormatted())")
                                     .font(.system(size: 16))
                             }
                             .padding(.bottom, 25)
                             
                             HStack {
                                 Image(systemName: "calendar.circle.fill")
                                     .font(.system(size: 36))
                                 Text("Next Service \(newCarModel.selectedNextServiceDate.onlyDateFormatted())")
                                     .font(.system(size: 16))
                             }
                             .padding(.bottom, 25)
                             
                             HStack {
                                 Image(systemName: "calendar.circle.fill")
                                     .font(.system(size: 36))
                                 Text("Insurance Expiration \(newCarModel.selectedInsuranceExpirationDate.onlyDateFormatted())")
                                     .font(.system(size: 16))
                             }
                             Spacer()
                         }
                         .padding(.leading, 20)
                         
                         Spacer()
                         
                         Image("car3")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(width: UIScreen.main.bounds.width / 2, alignment: .trailing)
                             .padding(.trailing, -55)
                     }
                 
                     .sheet(isPresented: $isNavigationActive) {
                         CarEditCV(car: car)
                     }
                     .onAppear {
                         carDetailViewModel.prepareData(newCarModel: newCarModel, car: car)
                     }
                     .navigationBarItems(trailing: Button(action: {
                     isNavigationActive.toggle()
                 }) {
                   Text("Edit")
                 })
                 .tabItem {
                     Label("Details", systemImage: "car.fill")
                 }
                 
                
                 ServiceDetailCV()
                     .tabItem {
                         Label("Settings", systemImage: "gear")
                     }
             }
         }
     }

extension Date {
    func onlyDateFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}


