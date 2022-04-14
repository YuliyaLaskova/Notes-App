//
//  ListViewController.swift
//  Notes App
//
//  Created by Yuliya Laskova on 08.04.2022.
//

import UIKit
import CloudKit

// ВЬЮШКИ НЕ СКРОЛЯТСЯ, НАЕЗЖАЮТ ДРУГ НА ДРУГА.
// КНОПКА СКРЫЛАСЬ НА ЗАДНЕМ ФОНЕ
// ПРИ НАЖАТИИ НА КАРТОЧКУ ЗАМЕТКИ СОЗДАЕТСЯ НОВАЯ, А НЕ ОТКРЫВАЕТСЯ СТАРАЯ

class ListViewController: UIViewController, NotesSendingDelegateProtocol {
    let notesScrollView = UIScrollView()
    let notesStackView = UIStackView()
    let addNewNoteButton = UIButton()
    var notes: [NoteDataModel] = []
    var shortCardViews: [ShortCardNoteView] = []
    var defineNoteCompletionHandler: ((NoteDataModel) -> Void)?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let noteDetailsVC = segue.destination as? NoteDetailsViewController else { return }
        noteDetailsVC.show(NoteDetailsViewController(), sender: addNewNoteButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        fillStackView()
        notesStackView.layoutIfNeeded()
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
        view.addSubview(notesStackView)
        notesStackView.backgroundColor = .systemGray6
        notesStackView.axis = .vertical
        notesStackView.distribution = .equalCentering
        notesStackView.spacing = 4

        notesStackView.translatesAutoresizingMaskIntoConstraints = false
        notesStackView.leadingAnchor.constraint(
            equalTo: notesScrollView.leadingAnchor,
            constant: 20
        ).isActive = true
        notesStackView.topAnchor.constraint(
            equalTo: notesScrollView.topAnchor
        ).isActive = true
        notesStackView.bottomAnchor.constraint(
            equalTo: notesScrollView.bottomAnchor
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
        addNewNoteButton.setTitle("+", for: .normal)
        addNewNoteButton.setTitleColor(.white, for: .normal)
        addNewNoteButton.contentVerticalAlignment = .bottom
        addNewNoteButton.backgroundColor = .systemBlue
        addNewNoteButton.titleLabel?.font = .systemFont(ofSize: 36)
        addNewNoteButton.titleLabel?.textAlignment = .center
        addNewNoteButton.focusGroupPriority = .prioritized

        notesStackView.addSubview(addNewNoteButton)

        addNewNoteButton.translatesAutoresizingMaskIntoConstraints = false
        addNewNoteButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20
        ).isActive = true
        addNewNoteButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
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

    func addShortViews(note: NoteDataModel) -> ShortCardNoteView {
        let shortCard = ShortCardNoteView()
        shortCard.noteNameLabel.text = note.noteTitle
        shortCard.noteTextLabel.text = note.noteText
        shortCard.noteDateLabel.text = note.noteDate
        notesStackView.addArrangedSubview(shortCard)
        return shortCard
    }

    func sendDatatoFirstViewController(note: NoteDataModel) -> ShortCardNoteView {
        let shortCard = ShortCardNoteView()
        shortCard.noteNameLabel.text = note.noteTitle
        shortCard.noteTextLabel.text = note.noteText
        shortCard.noteDateLabel.text = note.noteDate
        notes.append(note)
        shortCardViews.append(shortCard)
        return shortCard
    }

    @objc func addNewNoteButtonPressed(_ sender: UIButton) {
        let noteDetailsController = NoteDetailsViewController()
        navigationController?.pushViewController(noteDetailsController, animated: true)
    }

    func fillStackView () {
        for shortCard in shortCardViews {
            shortCard.isUserInteractionEnabled = true
            notesStackView.addArrangedSubview(shortCard)
        }
    }

    @objc func pushExistingNote(_ sender: ShortCardNoteView) {
        defineNoteCompletionHandler?(NoteDataModel(
            noteTitle: sender.noteNameLabel.text,
            noteText: sender.noteTextLabel.text,
            noteDate: sender.noteDateLabel.text
        ))

        let noteDetailsVC = NoteDetailsViewController()
        noteDetailsVC.delegate = self
        noteDetailsVC.title = ""
        self.navigationController?.pushViewController(noteDetailsVC, animated: true)
    }

    private func setupUI() {
        view.backgroundColor = .systemGray6
        self.title = "Заметки"
        navigationController?.navigationBar.prefersLargeTitles = true

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(pushExistingNote)
        )
        addNewNoteButton.addTarget(self, action: #selector(addNewNoteButtonPressed), for: .touchUpInside)
        notesStackView.addGestureRecognizer(tapGesture)

        setupNotesScrollView()
        setupNotesSteakView()
        setupAddNewNoteButton()
    }
}
