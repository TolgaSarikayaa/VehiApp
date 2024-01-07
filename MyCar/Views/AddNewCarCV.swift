//
//  AddNewCarCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import SwiftUI

struct AddNewCarCV: View {
    
    @ObservedObject var carListViewModel : CarListViewModel
    @State private var selectedBrandIndex = 0
    @State private var isPickerVisible = false
    @State private var isDatePickerVisible = false
    @State private var isBrandPickerVisible = false
    @State private var selectedBrand: String = ""
    @State private var selectedDate = Date()
    
    init() {
        self.carListViewModel = CarListViewModel(service: LocalService())
    }
    
    var body: some View {
        List {
                 HStack {
                     TextField("Select Brand", text: $selectedBrand)
                         .disabled(true)
                     
                     Spacer()
                     
                     Button(action: {
                         isBrandPickerVisible.toggle()
                     }) {
                         Image(systemName: "chevron.down")
                             .foregroundColor(.blue)
                     }
                 }
                 .contentShape(Rectangle())
                 .onTapGesture {
                     isBrandPickerVisible.toggle()
                 }

                 if isBrandPickerVisible {
                     Picker(selection: $selectedBrandIndex, label: Text("")) {
                         ForEach(carListViewModel.carList.indices, id: \.self) { index in
                             Text(carListViewModel.carList[index].brand)
                         }
                     }
                     .pickerStyle(MenuPickerStyle())
                     .onChange(of: selectedBrandIndex) { _ in
                         selectedBrand = carListViewModel.carList[selectedBrandIndex].brand
                         isBrandPickerVisible.toggle()
                     }
                 }

                 HStack {
                     Text("Selected Date: \(selectedDate, formatter: DateFormatter.date)")
                         .onTapGesture {
                             isDatePickerVisible.toggle()
                         }

                     Spacer()
                     
                     Button(action: {
                         isDatePickerVisible.toggle()
                     }) {
                         Image(systemName: "calendar")
                             .foregroundColor(.blue)
                     }
                 }

                 if isDatePickerVisible {
                     DatePicker("", selection: $selectedDate, displayedComponents: .date)
                         .datePickerStyle(.graphical)
                 }
             }
             .task {
                 await carListViewModel.downloadCars()
             }
         }
     }

     extension DateFormatter {
         static var date: DateFormatter {
             let formatter = DateFormatter()
             formatter.dateStyle = .medium
             return formatter
         }
     }
#Preview {
    AddNewCarCV()
}
