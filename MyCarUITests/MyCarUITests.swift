//
//  MyCarUITests.swift
//  MyCarUITests
//
//  Created by Tolga Sarikaya on 01.01.24.
//

import XCTest

final class MyCarUITests: XCTestCase {
    
    
    
    class MyCarUITests: XCTestCase {
        
        let app = XCUIApplication()
        
        override func setUpWithError() throws {
            continueAfterFailure = false
            app.launch()
        }
        
        func testAddNewCar() throws {
            // Open "Add New Car"
            app.navigationBars["MyCar"].buttons["Add New Car"].tap()
            
            // Select Brand
            let brandPicker = app.pickers["Select Brand"]
            brandPicker.children(matching: .pickerWheel).element(boundBy: 0).adjust(toPickerWheelValue: "Brand 1")
            
            // Select Model
            let modelPicker = app.pickers["Select Model"]
            modelPicker.children(matching: .pickerWheel).element(boundBy: 0).adjust(toPickerWheelValue: "Model 1")
            
            // Select Engine Type
            let engineTypePicker = app.pickers["Select Engine type"]
            engineTypePicker.children(matching: .pickerWheel).element(boundBy: 0).adjust(toPickerWheelValue: "Benzin")
            
            // Select Release Date
            app.staticTexts["Select release date"].tap()
            app.datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "January")
            app.datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "1")
            app.datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2024")
            
            // Select Milage
            let mileageTextField = app.textFields["Enter Milage"]
            mileageTextField.tap()
            mileageTextField.typeText("10000")
            
            // Checking the expected status of the screen
            XCTAssertTrue(app.navigationBars["MyCar"].buttons["Add New Car"].exists)
            XCTAssertTrue(app.navigationBars["Add New Car"].staticTexts["Add New Car"].exists)
            XCTAssertTrue(app.staticTexts["Select Brand and Model"].exists)
            XCTAssertTrue(app.staticTexts["Select your car information"].exists)
        }
    }
    
}
