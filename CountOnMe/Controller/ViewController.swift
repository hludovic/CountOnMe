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
    let calculatorVM = CalculatorViewModel()

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = calculatorVM.textDisplay
        calculatorVM.delegate = self
    }

    /// This method is required to comply with DisplayDelegate.
    /// It displays an alert message containing the text passed as a parameter.
    /// - Parameter text: This is the message that should be displayed in the alert message.
    func displayError(_ text: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: text, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    /// This method is required to comply with DisplayDelegate.
    /// It displays in the textView the operation sent to it as a parameter.
    /// - Parameter text: This is the message that should be displayed in the "textView"
    func displayOperation(_ text: String) {
        textView.text = text
    }

    // MARK: - @IBAction
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculatorVM.tappeNumber(number: numberText)
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculatorVM.tappeOperator(button: .plus)
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculatorVM.tappeOperator(button: .minus)
    }

    @IBAction func tappedDividButton(_ sender: UIButton) {
        calculatorVM.tappeOperator(button: .divide)
    }

    @IBAction func tappedMultiplyButton(_ sender: UIButton) {
        calculatorVM.tappeOperator(button: .multiply)
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculatorVM.tappeEqual()
    }

}
