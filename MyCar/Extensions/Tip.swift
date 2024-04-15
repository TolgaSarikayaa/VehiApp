//
//  Tip.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 15.04.24.
//

import Foundation
import TipKit

struct carTip: Tip {
    var title: Text {
        Text("Car")
    }
    
    var message: Text? {
        Text("Add your car")
    }
    
    var image: Image? {
        Image(systemName: "car.circle.fill")
    }
    
}

struct fuelTip : Tip {
    var title: Text {
        Text("Fuel")
    }
    
    var message: Text? {
        Text("Add fuel")
    }
    
    var image: Image? {
        Image(systemName: "fuelpump.circle.fill")
    }
}

struct serviceTip: Tip {
    var title: Text {
        Text("Service")
    }
    
    var message: Text? {
        Text("Add your maintenance")
    }
    
    var image: Image? {
       Image(systemName: "wrench.and.screwdriver")
    }
}

struct addCarParts: Tip {
    var title: Text {
        Text("Add the car parts")
    }
    
    var message: Text? {
    Text("To save the vehicle part, first enter the price, then click on the circle and press the save button to save it.")
    }
}
