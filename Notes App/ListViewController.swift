//
//  ListViewController.swift
//  Notes App
//
//  Created by Yuliya Laskova on 08.04.2022.
//

import UIKit
import CloudKit

class ListViewController: UIViewController {
    var notesStackView = UIStackView()
    let addNewNoteButton = UIButton()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let noteDetailsVC = segue.destination as? NoteDetailsViewController else { return }
        noteDetailsVC.show(NoteDetailsViewController(), sender: addNewNoteButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        self.title = "Заметки"
        addNewNoteButton.addTarget(self, action: #selector(addNewNoteButtonPressed), for: .touchUpInside)
        setUpNotesSteakView()
        setupAddNewNoteButton()
    }

  private  func setUpNotesSteakView() {
        notesStackView.backgroundColor = .systemGray5
        view.addSubview(notesStackView)

        notesStackView.translatesAutoresizingMaskIntoConstraints = false
        notesStackView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        notesStackView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
        notesStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        notesStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func setupAddNewNoteButton() {
        addNewNoteButton.layer.cornerRadius = 24
        // addButton.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
        addNewNoteButton.setTitle("+", for: .normal)
        addNewNoteButton.setTitleColor(.white, for: .normal)
        addNewNoteButton.backgroundColor = .systemBlue
        addNewNoteButton.titleLabel?.font = .systemFont(ofSize: 36)
        addNewNoteButton.titleLabel?.textAlignment = .center

        notesStackView.addSubview(addNewNoteButton)

        addNewNoteButton.translatesAutoresizingMaskIntoConstraints = false
        addNewNoteButton.trailingAnchor.constraint(equalTo: notesStackView.trailingAnchor).isActive = true
        addNewNoteButton.bottomAnchor.constraint(equalTo: notesStackView.bottomAnchor, constant: -150).isActive = true
        addNewNoteButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addNewNoteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    @objc func addNewNoteButtonPressed(_ sender: UIButton) {
        let noteDetailsController = NoteDetailsViewController()
        navigationController?.pushViewController(noteDetailsController, animated: true)
    }
}
