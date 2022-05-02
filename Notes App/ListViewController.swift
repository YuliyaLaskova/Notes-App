//
//  ViewController.swift
//  NotesViaTableView
//
//  Created by Yuliya Laskova on 18.04.2022.
//

import UIKit

class ListViewController: UIViewController {
    private let tableView = UITableView()
    private let addNewNoteButton = UIButton()
    private var editItem: IndexPath?
    var notes = [NoteDataModel]()
    private let noteCell = "NoteCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Заметки"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .systemGray6

        configureTableView()
        setupAddNewNoteButton()
    }

    // MARK: TableView configuration

    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 90
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.register(NoteCell.self, forCellReuseIdentifier: noteCell)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setTableViewDelegates() {
        tableView.delegate   = self
        tableView.dataSource = self
    }

    // MARK: AddNewNoteButton configuration

    private func setupAddNewNoteButton() {
        view.addSubview(addNewNoteButton)

        addNewNoteButton.layer.cornerRadius = 25
        addNewNoteButton.setTitle("+", for: .normal)
        addNewNoteButton.setTitleColor(.white, for: .normal)
        addNewNoteButton.contentVerticalAlignment = .bottom
        addNewNoteButton.backgroundColor = .systemBlue
        addNewNoteButton.titleLabel?.font = .systemFont(ofSize: 36)
        addNewNoteButton.titleLabel?.textAlignment = .center

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

        addNewNoteButton.addTarget(self, action: #selector(addNewNoteButtonPressed), for: .touchUpInside)
    }

    @objc func addNewNoteButtonPressed(_ sender: UIButton) {
        editItem = nil
        showNoteDetailsViewController()
    }

    private func showNoteDetailsViewController(for note: NoteDataModel? = nil) {
        let noteDetailsController = NoteDetailsViewController()
        noteDetailsController.delegate = self
        noteDetailsController.set(note: note)
        navigationController?.pushViewController(noteDetailsController, animated: true)
    }
}

// MARK: TableView extentions

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: noteCell, for: indexPath)
                as? NoteCell else { return UITableViewCell() }

        let note = notes[indexPath.row]
        cell.setup(with: note)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clickedNoteCell = notes[indexPath.row]
        editItem = indexPath
        showNoteDetailsViewController(for: clickedNoteCell)
    }
}

// MARK: NotesSendingDelegateProtocol extension

extension ListViewController: NotesSendingDelegateProtocol {
    func sendDatatoFirstViewController(note: NoteDataModel) {
        guard !note.isNoteEmpty else { return }
        if let index = editItem?.row {
            notes[index] = note
        } else {
            notes.append(note)
        }
        tableView.reloadData()
    }
}
