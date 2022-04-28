//
//  NoteCell.swift
//  Notes App
//
//  Created by Yuliya Laskova on 28.04.2022.
//

import UIKit

final class NoteCell: UITableViewCell {

    private var note: NoteDataModel!

    private let noteTitleLabel = UILabel()
    private let noteTextLabel = UILabel()
    private let noteDateLabel = UITextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureLabels()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(with note: NoteDataModel) {
        self.note = note
        noteTitleLabel.text = note.noteTitle
        noteTextLabel.text = note.noteText
        noteDateLabel.text = note.noteDate
    }

    private func configureLabels() {
        addSubview(noteTitleLabel)
        noteTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        noteTitleLabel.textColor = .black
        noteTitleLabel.contentMode = .scaleAspectFit

        noteTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        noteTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        noteTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        noteTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        noteTitleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true

        addSubview(noteTextLabel)
        noteTextLabel.font = .systemFont(ofSize: 14, weight: .light)
        noteTextLabel.textColor = .black
        noteTextLabel.contentMode = .scaleAspectFit

        noteTextLabel.translatesAutoresizingMaskIntoConstraints = false
        noteTextLabel.topAnchor.constraint(equalTo: noteTitleLabel.bottomAnchor, constant: 4).isActive = true
        noteTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        noteTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        noteTextLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true

        addSubview(noteDateLabel)
        noteDateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        noteDateLabel.textColor = .black

        noteDateLabel.translatesAutoresizingMaskIntoConstraints = false
        noteDateLabel.topAnchor.constraint(equalTo: noteTextLabel.bottomAnchor, constant: 24).isActive = true
        noteDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        noteDateLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true

    }
}
