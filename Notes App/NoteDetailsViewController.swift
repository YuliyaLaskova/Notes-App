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

class NoteDetailsViewController: UIViewController {
    let readyBarButtonItem = UIBarButtonItem()
    let titleTextField = UITextField()
    let noteTextView = UITextView()
    let dateField = UITextField()
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6

        setupDateField()
        setupTitleTextField()
        setupNoteTextView()
        setupBarButtonItem()
        noteTextView.becomeFirstResponder()
    }

    private func setupBarButtonItem() {
        readyBarButtonItem.title = "Готово"
        navigationItem.rightBarButtonItem = readyBarButtonItem
        readyBarButtonItem.target = self
        readyBarButtonItem.action = #selector(readyBarButtonAction)
    }

    private func setupDateField() {
        dateField.backgroundColor = .systemGray6
        dateField.borderStyle = .none
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
        dateField.heightAnchor.constraint(equalToConstant: 16).isActive = true
        dateField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
    }

    private func setupTitleTextField() {
        titleTextField.backgroundColor = .systemGray6
        titleTextField.borderStyle = .none
        titleTextField.placeholder = "Заголовок"
        titleTextField.font = .boldSystemFont(ofSize: 22)

        view.addSubview(titleTextField)

        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 20).isActive = true
        titleTextField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 20
        ).isActive = true
        titleTextField.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -70
        ).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    private func setupNoteTextView() {
        noteTextView.backgroundColor = .systemGray6
        noteTextView.font = .systemFont(ofSize: 14)
        noteTextView.layer.cornerRadius = 5

        view.addSubview(noteTextView)

        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -20
        ).isActive = true
        noteTextView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 20
        ).isActive = true
        noteTextView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -20
        ).isActive = true
        noteTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 28).isActive = true
    }
    // сохранять данные? // каким образом? нужно использовать кор дата или юзердефолтс или ничего?
    //    func saveViewData() {
    //        let model = NoteDataModel(noteTitle: titleTextField.text, noteText: noteTextView.text, noteDate: dateField.text)
    //
    //    }

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
