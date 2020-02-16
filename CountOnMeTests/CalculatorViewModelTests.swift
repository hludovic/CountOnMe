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

    func testTheScreenStartsClean() {
        XCTAssertEqual("", calculator.textString)
    }

    func testGivenTheScreenIsClean_WhenEnter3_ThenTheScreenShows3() {
        calculator.tappeNumber(number: "3")

        XCTAssertEqual(calculator.textString, "3")
    }

    func testGivenTheScreenIsBlank_WhenTappeEqual_ThenErrorMessageWillAlert() {
        calculator.tappeEqual()

        XCTAssertEqual(calculator.errorMessage, "Démarrez un nouveau calcul !")
        XCTAssertEqual(calculator.textString, "")
    }

    func test_GivenTheScreenIsClean_WhenTappeOneOperator_ThenErrorMessageWillAlert() {
        calculator.tappeOperator(button: .divide)

        XCTAssertEqual(calculator.errorMessage, "Entrez d'abord un chiffre")
        XCTAssertEqual(calculator.textString, "")
    }

    func testGivenCalculationEndWithOneOperator_WhenTappeEqual_ThenErrorMessageWillAlert() {
        calculator.tappeNumber(number: "111")
        calculator.tappeOperator(button: .multiply)
        calculator.tappeNumber(number: "112")
        calculator.tappeOperator(button: .minus)

        calculator.tappeEqual()

        XCTAssertEqual("111 * 112 - ", calculator.textString)
        XCTAssertEqual(calculator.errorMessage, "Entrez une expression correcte !")
    }

    func testGivenTheOperationIsThreeMinus_WhenTappedPlus_ThenErrorMessageWillAlert() {
        calculator.tappeNumber(number: "3")
        calculator.tappeOperator(button: .minus)

        calculator.tappeOperator(button: .plus)

        XCTAssertEqual(calculator.textString, "3 - ")
        XCTAssertEqual(calculator.errorMessage, "Un operateur est déja mis !")
    }

    func testGivenTheCalculationIsGood_WhenTappeEqualTwice_ThenErrorMessageWillAlert() {
        calculator.tappeNumber(number: "2")
        calculator.tappeOperator(button: .plus)
        calculator.tappeNumber(number: "4")

        calculator.tappeEqual()
        calculator.tappeEqual()

        XCTAssertEqual(calculator.textString, "2 + 4 = 6")
        XCTAssertEqual(calculator.errorMessage, "Le calcul est déjà terminé !")
    }

    func testGivenTheCalculationIsGood_WhenTappeOperator_ThenErrorMessageWillAlert() {
        calculator.tappeNumber(number: "4")
        calculator.tappeOperator(button: .minus)
        calculator.tappeNumber(number: "2")
        calculator.tappeEqual()

        calculator.tappeOperator(button: .multiply)

        XCTAssertEqual(calculator.textString, "4 - 2 = 2")
        XCTAssertEqual(calculator.errorMessage, "Le calcul est déjà terminé !")
    }

    func testGiventTheCalculationIsGood_WhenTappeNumber_ThenTheCalculatorStartNewOperationWithThisNumber() {
        calculator.tappeNumber(number: "6")
        calculator.tappeOperator(button: .divide)
        calculator.tappeNumber(number: "2")
        calculator.tappeEqual()

        calculator.tappeNumber(number: "5")

        XCTAssertEqual(calculator.textString, "5")
    }

    func testMultiplication() {
        calculator.tappeNumber(number: "2")
        calculator.tappeOperator(button: .multiply)
        calculator.tappeNumber(number: "3")
        calculator.tappeEqual()

        XCTAssertEqual("2 * 3 = 6", calculator.textString)
    }
}
