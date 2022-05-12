//
//  NoteCell.swift
//  Notes App
//
//  Created by Yuliya Laskova on 28.04.2022.
//

import UIKit

final class NoteCell: UITableViewCell {

    private var note: NoteDataModel!

    private let noteViewCell = UIView()
    private let noteTitleLabel = UILabel()
    private let noteTextLabel = UILabel()
    private let noteDateLabel = UITextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
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

    private func setupUI() {

        self.backgroundColor = .systemGray6
        contentView.addSubview(noteViewCell)
        noteViewCell.addSubview(noteTitleLabel)
        noteViewCell.addSubview(noteTextLabel)
        noteViewCell.addSubview(noteDateLabel)

        noteViewCell.backgroundColor = .white
        noteViewCell.layer.cornerRadius = 14
        noteViewCell.translatesAutoresizingMaskIntoConstraints = false
//        noteViewCell.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        // noteViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        noteViewCell.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
//        noteViewCell.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        noteViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//
//        //        noteViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        noteViewCell.bottomAnchor.constraint(
//            equalTo: self.bottomAnchor, constant: -4
//        ).isActive = true
        noteViewCell.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        noteViewCell.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        noteViewCell.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        noteViewCell.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        noteTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        noteTitleLabel.textColor = .black
        noteTitleLabel.contentMode = .scaleAspectFit

        noteTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        noteTitleLabel.topAnchor.constraint(equalTo: noteViewCell.topAnchor, constant: 10).isActive = true
        noteTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
       // noteTitleLabel.trailingAnchor.constraint(equalTo: noteViewCell.trailingAnchor, constant: -16).isActive = true
        noteTitleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true

        noteTextLabel.font = .systemFont(ofSize: 10, weight: .light)
        noteTextLabel.textColor = .black
        noteTextLabel.contentMode = .scaleAspectFit

        noteTextLabel.translatesAutoresizingMaskIntoConstraints = false
        noteTextLabel.topAnchor.constraint(equalTo: noteTitleLabel.bottomAnchor, constant: 4).isActive = true
        noteTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        //noteTextLabel.trailingAnchor.constraint(equalTo: noteViewCell.trailingAnchor, constant: -16).isActive = true
        noteTextLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true

        noteDateLabel.font = .systemFont(ofSize: 10, weight: .regular)
        noteDateLabel.textColor = .black

        noteDateLabel.translatesAutoresizingMaskIntoConstraints = false
        noteDateLabel.topAnchor.constraint(equalTo: noteTextLabel.bottomAnchor, constant: 24).isActive = true
        noteDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        noteDateLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true

    }
}
