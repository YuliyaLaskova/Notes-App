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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray4

        setupBarButtonItem()
        setupNoteTextView()
        setupTitleTextField()
    }

    private func setupBarButtonItem() {
        readyBarButtonItem.title = "Ready"
        navigationItem.rightBarButtonItem = readyBarButtonItem
        readyBarButtonItem.target = self
        readyBarButtonItem.action = #selector(readyBarButtonAction)
    }

    private func setupTitleTextField() {
        titleTextField.backgroundColor = .systemGray5
        titleTextField.placeholder = "Enter title of the note"
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
        titleTextField.bottomAnchor.constraint(equalTo: noteTextView.topAnchor, constant: -15).isActive = true
    }

    private func setupNoteTextView() {
        noteTextView.backgroundColor = .systemGray5
        noteTextView.font = .systemFont(ofSize: 14)
        noteTextView.layer.cornerRadius = 10

        view.addSubview(noteTextView)
        noteTextView.becomeFirstResponder()

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
        view.endEditing(true)
    }
}
