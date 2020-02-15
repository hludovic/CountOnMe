//
//  CalculatorViewModel.swift
//  CountOnMe
//
//  Created by Ludovic HENRY on 15/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol DisplayDelegate {
    func displayText(_ text: String)
    func displayError(_ text: String)
}

class CalculatorViewModel {
    var calculator: Calculator
    var delegate: DisplayDelegate?
        
    private var textString: String {
        didSet {
            calculator.display = textString
            delegate?.displayText(textString)
        }
    }
    
    private var errorMessage: String = "" {
        didSet {
            delegate?.displayError(errorMessage)
        }
    }

    init(calculator: Calculator) {
        self.calculator = calculator
        self.textString = ""
    }
            
    func tappedNumber(number: String) {
        if calculator.expressionHaveResult {
            textString = ""
        }
        textString.append(number)
    }
    
    func tappedAddition() {
        if calculator.canAddOperator {
            textString.append(" + ")
        } else {
            errorMessage = "Un operateur est déja mis !"
        }
    }
    
    func tappedminus() {
        if calculator.canAddOperator {
            textString.append(" - ")
        } else {
            errorMessage = "Un operateur est déja mis !"
        }
    }

    func tappedequal() {
        guard calculator.expressionIsCorrect else {
            errorMessage = "Entrez une expression correcte !"
            return
        }
        
        guard calculator.expressionHaveEnoughElement else {
            errorMessage = "Démarrez un nouveau calcul !"
            return
        }
        
        calculator.calculateResult()
        textString = calculator.display
        
    }

    
}
