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
    @State private var isShareSheetShowing = false
    
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
                                 Text("\(car.fuelType.localized)")
                                     .font(.system(size: 20))
                             }
                             .padding(.bottom, 25)
                             
                             HStack {
                                 Image(systemName: "car.rear.road.lane.dashed")
                                     .font(.system(size: 33))
                                 Text("\(car.mileage) \(NSLocalizedString("Mile", comment: "Distance unit"))")
                                     .font(.system(size: 20))
                             }
                             .padding(.bottom, 25)
                             
                             HStack {
                                 Image(systemName: "calendar.circle.fill")
                                     .font(.system(size: 36))
                                 VStack(alignment: .leading) {
                                     Text("Release date")
                                     Text("\(car.releaseDate.onlyDateFormatted())")
                                         .font(.system(size: 16))
                                 }
                             }
                             .padding(.bottom, 25)
                             
                             HStack {
                                 Image(systemName: "gear.circle.fill")
                                     .font(.system(size: 36))
                                 VStack(alignment: .leading) {
                                     Text("Next Service")
                                     Text("\(car.nextMaintenanceDate.onlyDateFormatted())")
                                         .font(.system(size: 16))
                                 }
                             }
                             .padding(.bottom, 25)
                             
                             HStack {
                                 Image(systemName: "magnifyingglass.circle.fill")
                                     .font(.system(size: 36))
                                 VStack(alignment: .leading) {
                                     Text("Inspection date")
                                     Text("\(car.insuranceExpirationDate.onlyDateFormatted())")
                                         .font(.system(size: 16))
                                 }
                             }
                             
                             .padding(.bottom, 25)
                             
                             HStack {
                                 if car.user.isEmpty {
                                     
                                 } else {
                                     if let userImage = car.userImage {
                                         Image(uiImage: userImage)
                                             .resizable()
                                             .aspectRatio(contentMode: .fill)
                                             .frame(width: 36, height: 36)
                                             .clipShape(Circle())
                                             .font(.system(size: 36))
                                     } else {
                                         Image(systemName: "person.circle.fill")
                                             .font(.system(size: 36))
                                     }
                                     Text("Driver: \(car.user)")
                                         .font(.system(size: 16))
                                     
                                 }
                             }
                             
                             Spacer()
                         }
                         .padding(.leading, 18)
                         
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
        
                     
                     .toolbar {
                         ToolbarItem(placement: .topBarTrailing) {
                             Button {
                                 shareCarDetails()
                             } label: {
                                 Image(systemName: "square.and.arrow.up")
                             }
                         }
                         
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
    
    private func shareCarDetails() {
        let carDetails = """
        \(NSLocalizedString("Brand", comment: "")): \(car.brand)
        \(NSLocalizedString("Model", comment: "")): \(car.model)
        \(NSLocalizedString("Fuel Type", comment: "")): \(car.fuelType)
        \(NSLocalizedString("Mileage", comment: "")): \(car.mileage)
        \(NSLocalizedString("Release date", comment: "")): \(car.releaseDate.onlyDateFormatted())
        \(NSLocalizedString("Next Service", comment: "")): \(car.nextMaintenanceDate.onlyDateFormatted())
        \(NSLocalizedString("Inspection date", comment: "")): \(car.insuranceExpirationDate.onlyDateFormatted())
        """
        
        let activityVC = UIActivityViewController(activityItems: [carDetails], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true, completion: nil)
        }
    }
  }

  extension String {
      var localized: String {
          return NSLocalizedString(self, comment: "")
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



