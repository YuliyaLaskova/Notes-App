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
    private let noteDateLabel = UILabel()
    lazy var iconImageView = UIImageView()

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
        if let userIconStr = note.userIcon {
            loadUserImage(userIconStr: userIconStr)
        }
    }

    private func loadUserImage(userIconStr: String) {
        NetManager.shared.fetchUserIcon(userIconPath: userIconStr) { [weak self] image in
            self?.iconImageView.image = image
        }

    }

    private func setupUI() {
        self.backgroundColor = .systemGray6
        contentView.addSubview(noteViewCell)
        noteViewCell.addSubview(noteTitleLabel)
        noteViewCell.addSubview(noteTextLabel)
        noteViewCell.addSubview(noteDateLabel)
        noteViewCell.addSubview(iconImageView)

        noteViewCell.translatesAutoresizingMaskIntoConstraints = false
        noteTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        noteTextLabel.translatesAutoresizingMaskIntoConstraints = false
        noteDateLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false

        noteViewCell.backgroundColor = .white
        noteViewCell.layer.cornerRadius = 14

        noteViewCell.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        noteViewCell.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        noteViewCell.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        noteViewCell.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        noteTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        noteTitleLabel.textColor = .black
        noteTitleLabel.contentMode = .scaleAspectFit

        noteTitleLabel.topAnchor.constraint(equalTo: noteViewCell.topAnchor, constant: 10).isActive = true
        noteTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        noteTitleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true

        noteTextLabel.font = .systemFont(ofSize: 10, weight: .light)
        noteTextLabel.textColor = .black
        noteTextLabel.contentMode = .scaleAspectFit

        noteTextLabel.topAnchor.constraint(equalTo: noteTitleLabel.bottomAnchor, constant: 4).isActive = true
        noteTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        noteTextLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true

        noteDateLabel.font = .systemFont(ofSize: 10, weight: .regular)
        noteDateLabel.textColor = .black

        noteDateLabel.topAnchor.constraint(equalTo: noteTextLabel.bottomAnchor, constant: 24).isActive = true
        noteDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        noteDateLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true

        iconImageView.frame.size = CGSize(width: 24, height: 24)
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2

        iconImageView.trailingAnchor.constraint(equalTo: noteViewCell.trailingAnchor, constant: -16).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: noteViewCell.bottomAnchor, constant: -10).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
}
