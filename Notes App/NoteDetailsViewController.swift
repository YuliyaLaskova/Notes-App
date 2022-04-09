//
//  ViewController.swift
//  Notes App
//
//  Created by Yuliya Laskova on 28.03.2022.
//

import UIKit

// final class ShortNoteView {
//    init(noteModel: NoteDataModel) {
//    }
// }

class NoteDetailsViewController: UIViewController /*ListViewController*/ {
    let readyBarButtonItem = UIBarButtonItem()
    let titleTextField = UITextField()
    let noteTextView = UITextView()
    let dateField = UITextField()
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray4

        setupBarButtonItem()
        setupNoteTextView()
        setupTitleTextField()
        setupDateField()

        noteTextView.becomeFirstResponder()
    }

    private func setupBarButtonItem() {
        readyBarButtonItem.title = "Готово"
        navigationItem.rightBarButtonItem = readyBarButtonItem
        readyBarButtonItem.target = self
        readyBarButtonItem.action = #selector(readyBarButtonAction)
    }

    private func setupTitleTextField() {
        titleTextField.backgroundColor = .systemGray5
        titleTextField.placeholder = "Заголовок"
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
        dateField.borderStyle = .roundedRect
        dateField.textAlignment = .center
        dateField.font = .systemFont(ofSize: 14)
        dateField.textColor = .gray
        dateField.text = "\(datePicker.date.formatted(date: .long, time: .omitted))"
        dateField.isUserInteractionEnabled = false

        view.addSubview(dateField)

        dateField.translatesAutoresizingMaskIntoConstraints = false
        dateField.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -20
        ).isActive = true
        dateField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 20
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
        if isNoteEmpty() {
            showAlert(with: "Ошибка", and: "Заполните хотя бы одно поле")
        }
    view.endEditing(true)
    }
}

extension NoteDetailsViewController {
    private func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func isNoteEmpty() -> Bool {
            var isNoteTextEmpty: Bool {
                noteTextView.text == ""
            }
            var isNoteTitleEmpty: Bool {
                titleTextField.text == ""
            }
            return isNoteTextEmpty && isNoteTitleEmpty
         }
}
