//
//  ListViewController.swift
//  Notes App
//
//  Created by Yuliya Laskova on 08.04.2022.
//

import UIKit
import CloudKit

class ListViewController: UIViewController {
    let notesScrollView = UIScrollView()
    var notesStackView = UIStackView()
    let addNewNoteButton = UIButton()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let noteDetailsVC = segue.destination as? NoteDetailsViewController else { return }
        noteDetailsVC.show(NoteDetailsViewController(), sender: addNewNoteButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupNotesScrollView() {
        notesScrollView.backgroundColor = .systemGray6
        view.addSubview(notesScrollView)

        notesScrollView.translatesAutoresizingMaskIntoConstraints = false
        notesScrollView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor
        ).isActive = true
        notesScrollView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor
        ).isActive = true
        notesScrollView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor
        ).isActive = true
        notesScrollView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor
        ).isActive = true
    }

    private  func setupNotesSteakView() {
        notesStackView.backgroundColor = .white

        view.addSubview(notesStackView)

        notesStackView.translatesAutoresizingMaskIntoConstraints = false
        notesStackView.leadingAnchor.constraint(
            equalTo: notesScrollView.leadingAnchor,
            constant: 20
        ).isActive = true
        notesStackView.topAnchor.constraint(
            equalTo: notesScrollView.topAnchor
        ).isActive = true
        notesStackView.widthAnchor.constraint(
            equalTo: notesScrollView.widthAnchor,
            constant: -40
        ).isActive = true
        notesStackView.heightAnchor.constraint(
            equalTo: notesScrollView.heightAnchor
        ).isActive = true
    }

    private func setupAddNewNoteButton() {
        addNewNoteButton.layer.cornerRadius = 25
        // addButton.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
        addNewNoteButton.setTitle("+", for: .normal)
        addNewNoteButton.setTitleColor(.white, for: .normal)
        addNewNoteButton.contentVerticalAlignment = .bottom
        addNewNoteButton.backgroundColor = .systemBlue
        addNewNoteButton.titleLabel?.font = .systemFont(ofSize: 36)
        addNewNoteButton.titleLabel?.textAlignment = .center

        notesStackView.addSubview(addNewNoteButton)

        addNewNoteButton.translatesAutoresizingMaskIntoConstraints = false
        addNewNoteButton.trailingAnchor.constraint(
            equalTo: notesStackView.trailingAnchor
        ).isActive = true
        addNewNoteButton.bottomAnchor.constraint(
            equalTo: notesStackView.bottomAnchor,
            constant: -60
        ).isActive = true
        addNewNoteButton.widthAnchor.constraint(
            equalToConstant: 50
        )
        .isActive = true
        addNewNoteButton.heightAnchor.constraint(
            equalToConstant: 50
        ).isActive = true
    }

    @objc func addNewNoteButtonPressed(_ sender: UIButton) {
        let noteDetailsController = NoteDetailsViewController()
        navigationController?.pushViewController(noteDetailsController, animated: true)
    }

    private func setupUI() {
        view.backgroundColor = .systemGray6
        self.title = "Заметки"
        navigationController?.navigationBar.prefersLargeTitles = true

        addNewNoteButton.addTarget(self, action: #selector(addNewNoteButtonPressed), for: .touchUpInside)

        setupNotesScrollView()
        setupNotesSteakView()
        setupAddNewNoteButton()
    }
}
