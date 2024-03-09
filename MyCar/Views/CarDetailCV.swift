//
//  CarDetailTestCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 01.02.24.
//

import SwiftUI

struct CarDetailCV: View {
    
    @Environment(\.dismiss) private var dismiss
   
    
    @State private var isNavigationActive = false
    
    @ObservedObject var carDetailViewModel = CarDetailViewModel()
    @ObservedObject var newCarModel = SelectCarModel()
    @State private var fuelTyp : String = ""
    
     var car : NewCarModel
    
    var body: some View {
                     HStack {
                         VStack(alignment: .leading) {
                             Text(car.brand)
                                 .font(.title)
                                 .fontWeight(.bold)
                             Text(car.model)
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
                                 Text("\(car.mileage) KM")
                                     .font(.system(size: 20))
                             }
                             .padding(.bottom, 25)
                             
                             HStack {
                                 Image(systemName: "calendar.circle.fill")
                                     .font(.system(size: 36))
                                 Text("Release date \(car.releaseDate.onlyDateFormatted())")
                                     .font(.system(size: 16))
                             }
                             .padding(.bottom, 25)
                             
                             HStack {
                                 Image(systemName: "calendar.circle.fill")
                                     .font(.system(size: 36))
                                 Text("Next Service \(car.nextMaintenanceDate.onlyDateFormatted())")
                                     .font(.system(size: 16))
                             }
                             .padding(.bottom, 25)
                             
                             HStack {
                                 Image(systemName: "calendar.circle.fill")
                                     .font(.system(size: 36))
                                 Text("Insurance Expiration \(car.insuranceExpirationDate.onlyDateFormatted())")
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
        VStack {
            NavigationLink(destination: ServiceDetailCV()) {
                Text("Add Service")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
           
        }
        .padding(.bottom,20)
                 
                     .sheet(isPresented: $isNavigationActive) {
                         CarEditCV(car: car)
                     }
                     
                     .toolbar {
                         ToolbarItem(placement: .topBarTrailing) {
                             Button(action: {
                                 isNavigationActive.toggle()
                             }, label: {
                                 Text("Edit")
                             })
                         }
                     }
                     .toolbar(.hidden, for: .tabBar)
             }
       
         }

extension Date {
    func onlyDateFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
public enum Visibility {
    case automatic
    case hidden
    case visible
}


