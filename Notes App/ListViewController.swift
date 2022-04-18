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

class ListViewController: UIViewController {
    let notesScrollView = UIScrollView()
    let notesStackView = UIStackView()
    let addNewNoteButton = UIButton()
    var shortCardViews: [ShortCardNoteView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupNotesScrollView() {
        // не работает Tap
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
        notesStackView.isUserInteractionEnabled = true
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

    @objc func addNewNoteButtonPressed(_ sender: UIButton) {
        let noteDetailsController = NoteDetailsViewController()
        noteDetailsController.delegate = self
        navigationController?.pushViewController(noteDetailsController, animated: true)
    }

     func pushExistingNote(_ sender: NoteDataModel) {
        let noteDetailsController = NoteDetailsViewController()
         noteDetailsController.delegate = self
         noteDetailsController.title = ""
         noteDetailsController.set(note: sender)
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
    private func updateStackView() {
        notesStackView.arrangedSubviews.forEach({ notesStackView.removeArrangedSubview($0) })
        shortCardViews.forEach({ notesStackView.addArrangedSubview($0) })
    }
}

extension ListViewController: NotesSendingDelegateProtocol {
    func sendDatatoFirstViewController(note: NoteDataModel) {
        let shortCard = ShortCardNoteView(note: note) { [weak self] (model) in
            self?.pushExistingNote(model)
        }
        shortCardViews.append(shortCard)
        updateStackView()
    }
}
