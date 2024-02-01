//
//  CarInformationViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 19.01.24.
//

import Foundation

class CarInformationViewModel : ObservableObject {
    
    @Published var carInformationList: [CarInformation] = []
        
        func addCar(_ car: CarInformation) {
           
            // Burada carList'i uygun bir şekilde saklamak için tercih ettiğiniz bir yöntemi kullanabilirsiniz (örneğin UserDefaults, CoreData, vb.).
            // Ayrıca, carList'i servise veya başka bir veri yönetim katmanına kaydetmek istiyorsanız, bu sınıfı ona göre ayarlayabilirsiniz.
        }
        
        func downloadCars() async {
            // Asenkron bir şekilde araç bilgilerini indirmek için kullanılacak kodu buraya ekleyebilirsiniz.
            // Örneğin, bir API çağrısı yapabilir veya lokal bir veritabanından bilgileri alabilirsiniz.
        }
}
