//
//  CarEditCV.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 05.01.24.
//

import SwiftUI

struct CarEditCV: View {
    
    @ObservedObject var carInformationListViewModel = CarInformationViewModel()
    
    @State private var isNavigationActive = false
    
    var body: some View {
        NavigationStack {
                    List {
                        if carInformationListViewModel.carInformationList.isEmpty {
                            
                        } else {
                            ForEach(carInformationListViewModel.carInformationList) { carInformation in
                                VStack(alignment: .leading, spacing: 5) {
                                    Image("car2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 300, height: 300)
                                        .cornerRadius(10)
                                    Text("\(carInformation.brand) \(carInformation.model)")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                }
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            }
                        }
                    }
                    .navigationTitle("My Cars")
                    .navigationBarItems(trailing: Button(action: {
                        isNavigationActive.toggle()
                    }) {
                        Image(systemName: "car.fill")
                            .foregroundColor(.blue)
                    })

                    NavigationLink(
                        destination: NewCarCV(),
                        isActive: $isNavigationActive,
                        label: {
                            EmptyView()
                        })
                }
                .task {
                    //await carInformationListViewModel.downloadCars()
                }
            }
        }

        #Preview {
            CarEditCV()
        }
