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
    var calculator: Calculator!
    var calculatorVM: CalculatorViewModel!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
        calculatorVM = CalculatorViewModel(calculator: calculator)
    }

    // MARK: - When i start a new calculation whith a blank screen
    func testTheScreenStartsBlank() {
        XCTAssertEqual(calculatorVM.textDisplay, "")
        XCTAssertEqual(calculatorVM.errorMessage, "")
    }

    func testGivenTheScreenStartsBlank_WhenTappeNumber3_ThenTheScreenShouldDisplay3() {
        calculatorVM.tappeNumber(number: "3")

        XCTAssertEqual(calculatorVM.textDisplay, "3")
        XCTAssertEqual(calculatorVM.errorMessage, "")
    }

    func testGivenTheScreenStartsBlank_WhenTappeEqual_ThenErrorMessageShouldAlert() {
        calculatorVM.tappeEqual()

        XCTAssertEqual(calculatorVM.textDisplay, "")
        XCTAssertEqual(calculatorVM.errorMessage, "Démarrez un nouveau calcul !")
    }

    func test_GivenTheScreenStartsBlank_WhenTappeOneOperator_ThenErrorMessageShouldAlert() {
        calculatorVM.tappeOperator(button: .divide)

        XCTAssertEqual(calculatorVM.textDisplay, "")
        XCTAssertEqual(calculatorVM.errorMessage, "Entrez d'abord un chiffre !")
    }

    // MARK: - After entering a good calculation and calculated its result.
    func testGivenTheCalculationIsGood_WhenTappeEqualAgain_ThenErrorMessageShouldAlert() {
        calculatorVM.tappeNumber(number: "2")
        calculatorVM.tappeOperator(button: .plus)
        calculatorVM.tappeNumber(number: "4")
        calculatorVM.tappeEqual()

        calculatorVM.tappeEqual()

        XCTAssertEqual(calculatorVM.textDisplay, "2 + 4 = 6")
        XCTAssertEqual(calculatorVM.errorMessage, "Le calcul est déjà terminé !")
    }

    func testGivenTheCalculationIsGood_WhenTappeOperator_ThenErrorMessageShouldAlert() {
        calculatorVM.tappeNumber(number: "4")
        calculatorVM.tappeOperator(button: .minus)
        calculatorVM.tappeNumber(number: "2")
        calculatorVM.tappeEqual()

        calculatorVM.tappeOperator(button: .multiply)

        XCTAssertEqual(calculatorVM.textDisplay, "4 - 2 = 2")
        XCTAssertEqual(calculatorVM.errorMessage, "Entrez d'abord un chiffre !")
    }

    func testGiventTheCalculationIsGood_WhenTappeNumber_ThenTheDisplayShouldShowOnlyThisNumber() {
        calculatorVM.tappeNumber(number: "6")
        calculatorVM.tappeOperator(button: .divide)
        calculatorVM.tappeNumber(number: "2")
        calculatorVM.tappeEqual()

        calculatorVM.tappeNumber(number: "5")

        XCTAssertEqual(calculatorVM.textDisplay, "5")
        XCTAssertEqual(calculatorVM.errorMessage, "")
    }

    // MARK: - trying to write a good op.
    func testGivenIMultiply2To3_WhenITappeEqual_ThenTheScreenShouldDisplayTheResult() {
        calculatorVM.tappeNumber(number: "2")
        calculatorVM.tappeOperator(button: .multiply)
        calculatorVM.tappeNumber(number: "3")

        calculatorVM.tappeEqual()

        XCTAssertEqual(calculatorVM.textDisplay, "2 × 3 = 6")
        XCTAssertEqual(calculatorVM.errorMessage, "")
    }

    // MARK: - Trying to write a bad op.
    func testGivenCalculationEndWithOneOperator_WhenTappeEqual_ThenErrorMessageShouldAlert() {
        calculatorVM.tappeNumber(number: "111")
        calculatorVM.tappeOperator(button: .multiply)
        calculatorVM.tappeNumber(number: "112")
        calculatorVM.tappeOperator(button: .minus)

        calculatorVM.tappeEqual()

        XCTAssertEqual(calculatorVM.textDisplay, "111 × 112 - ")
        XCTAssertEqual(calculatorVM.errorMessage, "Entrez un chiffre !")
    }

    func testGivenTheOperationIsThreeThenMinus_WhenITappeOneOperator_ThenErrorMessageShouldAlert() {
        calculatorVM.tappeNumber(number: "3")
        calculatorVM.tappeOperator(button: .minus)

        calculatorVM.tappeOperator(button: .plus)

        XCTAssertEqual(calculatorVM.textDisplay, "3 - ")
        XCTAssertEqual(calculatorVM.errorMessage, "Un operateur est déja mis !")
    }

    func testGivenTryAnUnwritableOperation_WhenTappeEqual_ThenErrorMessageShouldAlert() {
        calculator.operation = " × 3 - 5"
        calculatorVM.tappeEqual()

        XCTAssertEqual(calculatorVM.errorMessage, "Entrez une expression correcte !" )
    }

    func testGivenWriteAWordInTheOperation_WhenTappeEqual_ThenErrorMessageShouldAlert() {
        calculator.operation = "2 + Camion"
        calculatorVM.tappeEqual()

        XCTAssertEqual(calculatorVM.errorMessage, "Calcul Impossible" )
    }

    func testGivenTryAWrongOperator_WhenTappeEqual_ThenErrorMessageShouldAlert() {
        calculator.operation = "3 ? 5"
        calculatorVM.tappeEqual()

        XCTAssertEqual(calculatorVM.errorMessage, "Opérateur inconnu" )
    }
    func testGivenTryDividingANumbeByZero_WhenTappeEqual_ThenErrorMessageShouldAlert() {
        calculatorVM.tappeNumber(number: "2")
        calculatorVM.tappeOperator(button: .divide)
        calculatorVM.tappeNumber(number: "0")
        calculatorVM.tappeOperator(button: .plus)
        calculatorVM.tappeNumber(number: "4")

        calculatorVM.tappeEqual()

        XCTAssertEqual(calculatorVM.textDisplay, "2 ÷ 0 + 4")
        XCTAssertEqual(calculatorVM.errorMessage, "Calcul Impossible" )
    }

    func testGivenTryDividingZeroByZero_WhenTappeEqual_ThenTheResultShouldBeNaN() {
        calculatorVM.tappeNumber(number: "0")
        calculatorVM.tappeOperator(button: .divide)
        calculatorVM.tappeNumber(number: "0")
        calculatorVM.tappeOperator(button: .plus)
        calculatorVM.tappeNumber(number: "3")

        calculatorVM.tappeEqual()

        XCTAssertEqual(calculatorVM.textDisplay, "0 ÷ 0 + 3 = NaN")
    }

}
