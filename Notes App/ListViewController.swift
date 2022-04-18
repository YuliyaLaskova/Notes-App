//
//  ListViewController.swift
//  Notes App
//
//  Created by Yuliya Laskova on 08.04.2022.
//

import UIKit

// ВЬЮШКИ располагаются не так
// ПРИ НАЖАТИИ НА КАРТОЧКУ ЗАМЕТКИ СОЗДАЕТСЯ НОВАЯ, А НЕ ОТКРЫВАЕТСЯ СТАРАЯ

// для таблиц оставить addnewbutton, noteDataModel

class ListViewController: UIViewController, NotesSendingDelegateProtocol {
    let notesScrollView = UIScrollView()
    let notesStackView = UIStackView()
    let addNewNoteButton = UIButton()
    var notes: [NoteDataModel] = []
    var shortCardViews: [ShortCardNoteView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupNotesScrollView() {
        notesScrollView.alwaysBounceVertical = true
        view.addSubview(notesScrollView)

        notesScrollView.backgroundColor = .systemGray6
        notesScrollView.translatesAutoresizingMaskIntoConstraints = false
        notesScrollView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor
        ).isActive = true
        notesScrollView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor
        ).isActive = true
        notesScrollView.topAnchor.constraint(
            equalTo: view.topAnchor
        ).isActive = true
        notesScrollView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor
        ).isActive = true
    }

    private  func setupNotesSteakView() {
        notesScrollView.addSubview(notesStackView)

        notesStackView.distribution = .fillProportionally
        notesStackView.axis = .vertical
        notesStackView.alignment = .center
        notesStackView.spacing = 4
        notesStackView.backgroundColor = .systemGray6

        notesStackView.translatesAutoresizingMaskIntoConstraints = false
        notesStackView.leadingAnchor.constraint(
            equalTo: notesScrollView.contentLayoutGuide.leadingAnchor
        ).isActive = true
        notesStackView.trailingAnchor.constraint(
            equalTo: notesScrollView.contentLayoutGuide.trailingAnchor
        ).isActive = true
        notesStackView.topAnchor.constraint(
            equalTo: notesScrollView.contentLayoutGuide.topAnchor
        ).isActive = true
        notesStackView.bottomAnchor.constraint(
            equalTo: notesScrollView.contentLayoutGuide.bottomAnchor
        ).isActive = true
        notesStackView.widthAnchor.constraint(
            equalTo: notesScrollView.widthAnchor
        ).isActive = true
//        notesStackView.heightAnchor.constraint(
//            equalTo: notesScrollView.heightAnchor
//        ).isActive = true

        // найти как установить констрейнте приоритет и установить 250
    }

    private func setupAddNewNoteButton() {
        addNewNoteButton.layer.cornerRadius = 25
        addNewNoteButton.setTitle("+", for: .normal)
        addNewNoteButton.setTitleColor(.white, for: .normal)
        addNewNoteButton.contentVerticalAlignment = .bottom
        addNewNoteButton.backgroundColor = .systemBlue
        addNewNoteButton.titleLabel?.font = .systemFont(ofSize: 36)
        addNewNoteButton.titleLabel?.textAlignment = .center
       // addNewNoteButton.focusGroupPriority = .prioritized

        view.addSubview(addNewNoteButton)

        addNewNoteButton.translatesAutoresizingMaskIntoConstraints = false
        addNewNoteButton.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -20
        ).isActive = true
        addNewNoteButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
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

    func sendDatatoFirstViewController(note: NoteDataModel) -> ShortCardNoteView {
        let shortCard = ShortCardNoteView()
        shortCard.noteNameLabel.text = note.noteTitle
        shortCard.noteTextLabel.text = note.noteText
        shortCard.noteDateLabel.text = note.noteDate
        notes.append(note)
        shortCard.defineNoteCompletionHandler = { [weak self] in
            self?.pushExistingNote(note)
        }
        shortCardViews.append(shortCard)
        notesStackView.addArrangedSubview(shortCard)
        return shortCard
    }

    @objc func addNewNoteButtonPressed(_ sender: UIButton) {
        let noteDetailsController = NoteDetailsViewController()
        noteDetailsController.delegate = self
        navigationController?.pushViewController(noteDetailsController, animated: true)
    }

     func pushExistingNote(_ sender: NoteDataModel) {
        let noteDetailsController = NoteDetailsViewController()
         noteDetailsController.delegate = self
         noteDetailsController.title = ""
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
