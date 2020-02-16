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
    
    func testGivenCalculStartWithOneOperator_WhenTappeEqual_ThenErrorMessageWillAlert() {
        calculator.tappeOperatorButton(button: .plus)
        calculator.tappedNumber(number: "111")
        calculator.tappeOperatorButton(button: .minus)
        calculator.tappedNumber(number: "112")
        
        calculator.tappedequal()
        XCTAssertEqual(" + 111 - 112", calculator.textString)
        XCTAssertEqual(calculator.errorMessage, "Entrez une expression correcte !")
    }
    
    func testGivenCalculEndWithOneOperator_WhenTappeEqual_ThenErrorMessageWillAlert() {
        calculator.tappedNumber(number: "111")
        calculator.tappeOperatorButton(button: .minus)
        calculator.tappedNumber(number: "112")
        calculator.tappeOperatorButton(button: .minus)

        calculator.tappedequal()
        XCTAssertEqual("111 - 112 - ", calculator.textString)
        XCTAssertEqual(calculator.errorMessage, "Entrez une expression correcte !")
    }

    func testGivenTappeTwoOperators_WhenTappedEqual_ThenErrorMessageWillAlert() {
        calculator.tappeOperatorButton(button: .plus)
        calculator.tappeOperatorButton(button: .minus)

        XCTAssertEqual(calculator.errorMessage, "Un operateur est déja mis !")
    }
    
    func testGivenTheCalculIsGood_WhenTappeEqualTwice_ThenErrorMessageWillAlert() {
        calculator.tappedNumber(number: "2")
        calculator.tappeOperatorButton(button: .plus)
        calculator.tappedNumber(number: "4")
        calculator.tappedequal()
        calculator.tappedequal()
        
        XCTAssertEqual(calculator.errorMessage, "Le calcul est déjà terminé !")
        
    }
}
