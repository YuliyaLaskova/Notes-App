//
//  ViewController.swift
//  Notes App
//
//  Created by Yuliya Laskova on 28.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var readyButton: UIButton!

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var mainTextField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

    }

    @IBAction func readyButtonPressed() {
        view.endEditing(true)
    }

  private func setupUI() {
        view.backgroundColor = .systemGray6

        titleTextField.layer.cornerRadius = 10
        titleTextField.backgroundColor = .systemGray5
        titleTextField.font = .boldSystemFont(ofSize: 22)
        titleTextField.textColor = .black
        titleTextField.adjustsFontSizeToFitWidth = true
        titleTextField.placeholder = "Write the title"

        mainTextField.layer.cornerRadius = 10
        mainTextField.backgroundColor = .systemGray5
        mainTextField.font = .systemFont(ofSize: 14)
        mainTextField.textColor = .black

        mainTextField.becomeFirstResponder()

        readyButton.layer.cornerRadius = 5
        readyButton.tintColor = .black
        readyButton.backgroundColor = .systemBlue
    }
}
