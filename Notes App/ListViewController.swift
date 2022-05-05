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
    private let deleteNoteButton = UIButton()
    private var selectRightBarButtonItem = UIBarButtonItem()
    private var readyRightBarButtonItem = UIBarButtonItem()

    var notes = [NoteDataModel]()
    private let noteCell = "NoteCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Заметки"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .systemGray6

        selectRightBarButtonItem = UIBarButtonItem(title: "Выбрать", style: .plain, target: self, action: #selector(enterEditingMode))
        readyRightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(cancelEditingMode))
        navigationItem.rightBarButtonItems = [selectRightBarButtonItem]

        tableView.allowsMultipleSelectionDuringEditing = true

        configureTableView()
        setupAddNewNoteButton()
    }

    @objc func enterEditingMode() {
        navigationItem.rightBarButtonItems = [readyRightBarButtonItem]
        setupDeleteNoteButton()
        setEditing(true, animated: true)
    }

    @objc func cancelEditingMode() {
        navigationItem.rightBarButtonItems = [selectRightBarButtonItem]
        setupAddNewNoteButton()
        setEditing(false, animated: true)
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

        let buttonImage = UIImage(named: "plusbutton")
        addNewNoteButton.setImage(buttonImage, for: .normal)
        addNewNoteButton.layer.cornerRadius = 25

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
        showNoteDetailsViewController()
    }

    // MARK: DeleteNoteButton configuration

    private func setupDeleteNoteButton() {
        view.addSubview(deleteNoteButton)

        let buttonImage = UIImage(named: "trushbutton")
        deleteNoteButton.setImage(buttonImage, for: .normal)
        deleteNoteButton.layer.cornerRadius = 25

        deleteNoteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteNoteButton.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -20
        ).isActive = true
        deleteNoteButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -60
        ).isActive = true
        deleteNoteButton.widthAnchor.constraint(
            equalToConstant: 50
        )
        .isActive = true
        deleteNoteButton.heightAnchor.constraint(
            equalToConstant: 50
        ).isActive = true

        deleteNoteButton.addTarget(self, action: #selector(deleteNoteButtonPressed), for: .touchUpInside)
    }

    @objc func deleteNoteButtonPressed(_ sender: UIButton) {
    }

    // MARK: func showNoteDetailsViewController

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
        let note = notes[indexPath.row].update(index: indexPath)
        showNoteDetailsViewController(for: note)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // remove the item from the data model
            notes.remove(at: indexPath.row)

            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        if tableView.isEditing {
    //            setupDeleteNoteButton()
    //        } else {
    //            let note = notes[indexPath.row].update(index: indexPath)
    //            showNoteDetailsViewController(for: note)
    //        }
    //    }
    //
    //    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    //        if tableView.isEditing {
    //            if tableView.indexPathsForSelectedRows == nil || tableView.indexPathsForSelectedRows!.isEmpty {
    //                setupAddNewNoteButton()
    //            }
    //        }
    //    }
}

// MARK: NotesSendingDelegateProtocol extension

extension ListViewController: NotesSendingDelegateProtocol {
    func sendDatatoFirstViewController(note: NoteDataModel) {
        guard !note.isNoteEmpty else { return }
        if let index = note.index?.row {
            notes[index] = note
        } else {
            notes.append(note)
        }
        tableView.reloadData()
    }
}
