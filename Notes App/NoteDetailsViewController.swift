//
//  ViewController.swift
//  Notes App
//
//  Created by Yuliya Laskova on 28.03.2022.
//

import UIKit

class ViewController: UIViewController {
    let readyBarButtonItem = UIBarButtonItem()
    let titleTextField = UITextField()
    let noteTextView = UITextView()
    let dateField = UITextField()
    let datePicker = UIDatePicker()

    struct NoteDataModel {
        let noteTitle: String
        let noteText: String
        let noteDate: String?
        let textIsEmpty: Bool
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray4

        setupBarButtonItem()
        setupNoteTextView()
        setupTitleTextField()
        setupDateField()
        createDatePicker()

        noteTextView.becomeFirstResponder()
    }

    private func setupBarButtonItem() {
        readyBarButtonItem.title = "Ready"
        navigationItem.rightBarButtonItem = readyBarButtonItem
        readyBarButtonItem.target = self
        readyBarButtonItem.action = #selector(readyBarButtonAction)
    }

    private func setupTitleTextField() {
        titleTextField.backgroundColor = .systemGray5
        titleTextField.placeholder = "Title of the note"
        titleTextField.font = .boldSystemFont(ofSize: 22)
        titleTextField.borderStyle = .roundedRect

        view.addSubview(titleTextField)

        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleTextField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        titleTextField.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
        titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }

    private func setupDateField() {
        dateField.backgroundColor = .systemGray5
        dateField.placeholder = "\(datePicker.date.formatted(date: .long, time: .omitted))"
        dateField.font = .boldSystemFont(ofSize: 22)
        dateField.borderStyle = .roundedRect

        view.addSubview(dateField)

        dateField.translatesAutoresizingMaskIntoConstraints = false
        dateField.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
        dateField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        dateField.heightAnchor.constraint(equalTo: titleTextField.heightAnchor).isActive = true
        dateField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5).isActive = true
        dateField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateField.bottomAnchor.constraint(equalTo: noteTextView.topAnchor, constant: -5).isActive = true
    }

    private func setupNoteTextView() {
        noteTextView.backgroundColor = .systemGray5
        noteTextView.font = .systemFont(ofSize: 14)
        noteTextView.layer.cornerRadius = 5

        view.addSubview(noteTextView)

        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
        noteTextView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        noteTextView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -20
        ).isActive = true
        noteTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc private func readyBarButtonAction() {
        checkNote()
        view.endEditing(true)
    }

//    @objc func checkNote() {
//        if noteTextView.text.isEmpty && titleTextField.text?.isEmpty == true {
//            let message = "Enter title or text"
//            let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
//            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(action)
//
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }

    private func createDatePicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        dateField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date

        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: nil,
            action: #selector (dateDoneBtnPressed)
        )
        toolbar.setItems([doneButton], animated: true)

        dateField.inputAccessoryView = toolbar
    }

    @objc func dateDoneBtnPressed() {
        if dateField.text?.isEmpty == true {
            dateField.resignFirstResponder()
            dateField.text = dateField.placeholder
        } else {
            dateField.resignFirstResponder()
            dateField.text = "\(datePicker.date.formatted(date: .long, time: .omitted))"
        }
    }
}

extension ViewController {
     func checkNote() {
        if noteTextView.text.isEmpty && titleTextField.text?.isEmpty == true {
            let message = "Enter title or text"
            let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(action)

            self.present(alertController, animated: true, completion: nil)
        }
    }
}
