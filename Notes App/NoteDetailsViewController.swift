//
//  ViewController.swift
//  Notes App
//
//  Created by Yuliya Laskova on 28.03.2022.
//

import UIKit

protocol NotesSendingDelegateProtocol: AnyObject {
    func sendDatatoFirstViewController(note: NoteDataModel)
}

class NoteDetailsViewController: UIViewController {
    private let readyRightBarButtonItem = UIBarButtonItem()
    private let titleTextField = UITextField()
    private let noteTextView = UITextView()
    private let dateField = UITextField()
    private var index: IndexPath?

    weak var delegate: NotesSendingDelegateProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        notificationSetup()
        setupUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            let noteCell = NoteDataModel(
                noteTitle: titleTextField.text,
                noteText: noteTextView.text,
                noteDate: dateField.text,
                index: index
            )
            self.delegate?.sendDatatoFirstViewController(note: noteCell)
        }
    }

    // MARK: Keyboard + notification

    func notificationSetup() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWasShown(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardWasShown(notification: NSNotification) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
        let info = notification.userInfo
        if let keyboardRect = info?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardSize = keyboardRect.size
            noteTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            noteTextView.scrollIndicatorInsets = noteTextView.contentInset
        }
    }

    @objc func keyboardWillBeHidden(notification: NSNotification) {
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = .clear
        noteTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        noteTextView.scrollIndicatorInsets = noteTextView.contentInset
    }

    // MARK: Setups

    private func setupRightBarButtonItem() {
        readyRightBarButtonItem.title = "Готово"
        navigationItem.rightBarButtonItem = readyRightBarButtonItem
        readyRightBarButtonItem.target = self
        readyRightBarButtonItem.action = #selector(readyBarButtonAction)
    }

    private func setupDateField() {
        dateField.backgroundColor = .systemGray6
        dateField.borderStyle = .none
        dateField.textAlignment = .center
        dateField.font = .systemFont(ofSize: 14, weight: .medium)
        dateField.textColor = .gray
        dateField.text = formatDate(date: Date())
        dateField.isUserInteractionEnabled = false

        view.addSubview(dateField)

        dateField.translatesAutoresizingMaskIntoConstraints = false
        dateField.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 12
        ).isActive = true
        dateField.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -20
        ).isActive = true
        dateField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 20
        ).isActive = true
        dateField.heightAnchor.constraint(
            equalToConstant: 16
        ).isActive = true
    }

    private func setupTitleTextField() {
        view.addSubview(titleTextField)

        titleTextField.backgroundColor = .systemGray6
        titleTextField.borderStyle = .none
        titleTextField.placeholder = "Введите название"
        titleTextField.font = .systemFont(ofSize: 24, weight: .medium)

        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(
            equalTo: dateField.bottomAnchor,
            constant: 20
        ).isActive = true
        titleTextField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 20
        ).isActive = true
        titleTextField.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -70
        ).isActive = true
        titleTextField.heightAnchor.constraint(
            equalToConstant: 24
        ).isActive = true
    }

    private func setupNoteTextView() {
        view.addSubview(noteTextView)
        noteTextView.backgroundColor = .systemGray6
        noteTextView.font = .systemFont(ofSize: 16)
        noteTextView.layer.cornerRadius = 5

        noteTextView.adjastableForKeyboard()
        noteTextView.becomeFirstResponder()

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
        noteTextView.topAnchor.constraint(
            equalTo: titleTextField.bottomAnchor,
            constant: 28
        ).isActive = true
    }

    @objc private func readyBarButtonAction() {
        view.endEditing(true)
        if isNoteEmpty() {
            showAlert(with: "Ошибка", and: "Заполните хотя бы одно поле")
        }
    }

    func set(note model: NoteDataModel?) {
        guard let model = model else { return }
        titleTextField.text = model.noteTitle
        noteTextView.text = model.noteText
        dateField.text = model.noteDate
        self.index = model.index
    }

    private func setupUI() {
        view.backgroundColor = .systemGray6

        setupDateField()
        setupTitleTextField()
        setupNoteTextView()
        setupRightBarButtonItem()
    }
}

// MARK: alert extension

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

extension NoteDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let newPosition = noteTextView.endOfDocument
        noteTextView.selectedTextRange = noteTextView.textRange(from: newPosition, to: newPosition)
        return noteTextView.becomeFirstResponder()
    }
}

// MARK: Keyboard extension

extension UITextView {
    func adjastableForKeyboard() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = convert(keyboardScreenEndFrame, from: window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            contentInset = .zero
        } else {
            contentInset = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: keyboardViewEndFrame.height - safeAreaInsets.bottom,
                right: 0
            )
        }

        scrollIndicatorInsets = contentInset
        scrollRangeToVisible(selectedRange)
    }
}

// MARK: date format extension

extension NoteDetailsViewController {
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd.MM.YYYY EEEE HH:mm"
        return formatter.string(from: date)
    }
}
