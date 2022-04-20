//
//  ShortNoteView.swift
//  Notes App
//
//  Created by Yuliya Laskova on 09.04.2022.
//

import UIKit

final class ShortCardNoteView: UIView {

    private var defineNoteCompletionHandler: ((NoteDataModel) -> Void)?
    private var note: NoteDataModel!

    lazy var shortCardView: UIView = {
        let shordCard = UIView()
        shordCard.backgroundColor = .white
        shordCard.sizeToFit()
        shordCard.layoutIfNeeded()
        shordCard.layer.cornerRadius = 15
        shordCard.clipsToBounds = true
        shordCard.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapShortCard)
        )
        shordCard.addGestureRecognizer(tapGesture)
        shordCard.translatesAutoresizingMaskIntoConstraints = false
        shordCard.isUserInteractionEnabled = true
        return shordCard
    }()

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

    convenience init(note: NoteDataModel, completionHandler: ((NoteDataModel) -> Void)?) {
        self.init(frame: CGRect.zero)
        self.note = note
        self.defineNoteCompletionHandler = completionHandler
        setupShortCardView()
    }

    func setupShortCardView() {
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 90).isActive = true
        self.addSubview(shortCardView)

        shortCardView.addSubview(noteNameLabel)
        shortCardView.addSubview(noteTextLabel)
        shortCardView.addSubview(noteDateLabel)

        noteNameLabel.text = note.noteTitle
        noteTextLabel.text = note.noteText
        noteDateLabel.text = note.noteDate

        shortCardView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        shortCardView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        shortCardView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        shortCardView.widthAnchor.constraint(greaterThanOrEqualToConstant: 358).isActive = true

        noteNameLabel.topAnchor.constraint(equalTo: shortCardView.topAnchor, constant: 10).isActive = true
        noteNameLabel.leadingAnchor.constraint(equalTo: shortCardView.leadingAnchor, constant: 16).isActive = true
        noteNameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true

        noteTextLabel.topAnchor.constraint(equalTo: noteNameLabel.bottomAnchor, constant: 4).isActive = true
        noteTextLabel.leadingAnchor.constraint(equalTo: shortCardView.leadingAnchor, constant: 16).isActive = true
        noteTextLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        noteTextLabel.trailingAnchor.constraint(equalTo: shortCardView.trailingAnchor, constant: -5).isActive = true

        noteDateLabel.topAnchor.constraint(equalTo: noteTextLabel.bottomAnchor, constant: 24).isActive = true
        noteDateLabel.leadingAnchor.constraint(equalTo: shortCardView.leadingAnchor, constant: 16).isActive = true
        noteDateLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }

    @objc func didTapShortCard() {
        defineNoteCompletionHandler?(note)
    }
}
