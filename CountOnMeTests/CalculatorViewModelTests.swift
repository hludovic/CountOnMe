//
//  CalculatorViewModelTests.swift
//  CountOnMeTests
//
//  Created by Ludovic HENRY on 14/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorViewModelTests: XCTestCase {
    var calculator: CalculatorViewModel!
    
    override func setUp() {
        super.setUp()
        calculator = CalculatorViewModel(calculator: Calculator())
    }
    
    func testTheScreenStartClean() {
        XCTAssertEqual("", calculator.textString)
    }
    
    func testGivenTheScreenIsClean_WhenEnter3_ThenTheScreenShows3() {
        calculator.tappedNumber(number: "3")
        XCTAssertEqual("3", calculator.textString)
    }
    
    func testGivenTheScreenIsBlank_WhenTappeEqual_ThenErrorMessageWillAlert() {
        calculator.tappedequal()
        XCTAssertEqual(calculator.errorMessage, "Démarrez un nouveau calcul !")
    }
    
    func testGivenWrongCalculIsEntered_WhenTappeEqual_ThenErrorMessageWillAlert() {
        calculator.tappedAddition()
        calculator.tappedNumber(number: "111")
        calculator.tappedMinus()
        calculator.tappedNumber(number: "112")
        calculator.tappedMinus()
        calculator.tappedequal()
        XCTAssertEqual(" + 111 - 112 - ", calculator.textString)
        XCTAssertEqual(calculator.errorMessage, "Entrez une expression correcte !")
    }
    
    func testGivenTheCalculIsGood_WhenTappeEqualTwice_ThenErrorMessageWillAlert() {
        
    }
}
