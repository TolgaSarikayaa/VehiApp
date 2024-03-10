//
//  DatePickerView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 13.02.24.
//

import SwiftUI

struct DatePickerView: View {
       
    var label: String
       @Binding var selectedDate: Date
       @Binding var isPickerVisible: Bool
       var formatter: DateFormatter
    
    var body: some View {
        VStack {
                   HStack {
                       Text("\(label): \(selectedDate, formatter: formatter)")
                           .onTapGesture {
                               self.isPickerVisible.toggle()
                           }
                       Spacer()
                       Button {
                           self.isPickerVisible.toggle()
                       } label: {
                           Image(systemName: "calendar")
                       }
                   }
                   if isPickerVisible {
                       DatePicker("", selection: $selectedDate, displayedComponents: .date)
                           .datePickerStyle(.graphical)
                   }
               }
           }
    }

