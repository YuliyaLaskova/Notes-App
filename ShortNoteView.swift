//
//  ShortNoteView.swift
//  Notes App
//
//  Created by Yuliya Laskova on 09.04.2022.
//

import UIKit

final class ShortCardNoteView: UIView {

    private var defineNoteCompletionHandler: ((NoteDataModel, ShortCardNoteView) -> Void)?
    private var note: NoteDataModel!

    let noteNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let noteTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let noteDateLabel: UITextField = {
        let label = UITextField()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    convenience init(note: NoteDataModel, completionHandler: ((NoteDataModel, ShortCardNoteView) -> Void)?) {
        self.init(frame: .zero)
        backgroundColor = .white
        layer.cornerRadius = 15

        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 90).isActive = true
        widthAnchor.constraint(equalToConstant: 358).isActive = true

        self.defineNoteCompletionHandler = completionHandler
        self.note = note
        noteNameLabel.text = note.noteTitle
        noteTextLabel.text = note.noteText
        noteDateLabel.text = note.noteDate

        setupShortCardView()
        tapObserver()
    }

    func setupShortCardView() {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        self.addSubview(noteNameLabel)
        self.addSubview(noteTextLabel)
        self.addSubview(noteDateLabel)

        self.leadingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        self.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true

        noteNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        noteNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        noteNameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true

        noteTextLabel.topAnchor.constraint(equalTo: noteNameLabel.bottomAnchor, constant: 4).isActive = true
        noteTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        noteTextLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        noteTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true

        noteDateLabel.topAnchor.constraint(equalTo: noteTextLabel.bottomAnchor, constant: 24).isActive = true
        noteDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        noteDateLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }

    private func tapObserver() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapShortCard)
        )
        self.addGestureRecognizer(tapGesture)
    }

    @objc func didTapShortCard() {
        defineNoteCompletionHandler?(note, self)
    }

    func update(with note: NoteDataModel) {
        self.note = note
        noteNameLabel.text = note.noteTitle
        noteTextLabel.text = note.noteText
        noteDateLabel.text = note.noteDate
    }
}
