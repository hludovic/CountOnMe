//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DisplayDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    let calculator = CalculatorViewModel(calculator: Calculator())

        // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = calculator.operation

        calculator.delegate = self
    }

    func displayError(_ text: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: text, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    func displayOperation(_ text: String) {
        textView.text = text
    }

    // MARK: - @IBAction
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.tappeNumber(number: numberText)
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.tappeOperator(button: .plus)
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.tappeOperator(button: .minus)
    }

    @IBAction func tappedDividButton(_ sender: UIButton) {
        calculator.tappeOperator(button: .divide)
    }

    @IBAction func tappedMultiplyButton(_ sender: UIButton) {
        calculator.tappeOperator(button: .multiply)
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.tappeEqual()
    }

}
