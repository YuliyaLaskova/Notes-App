//
//  ViewController.swift
//  NotesViaTableView
//
//  Created by Yuliya Laskova on 18.04.2022.
//

import UIKit

class ListViewController: UIViewController {
    private let tableView = UITableView()
    private let plusButton = UIButton()
    var plusButtonBottomAnchor: NSLayoutConstraint!
    var plusButtonBottomAnchor2: NSLayoutConstraint!
    private let cellHeight = 90.0

    var notes = [NoteDataModel]()
    private let noteCell = "NoteCell"

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        plusButtonBottomAnchor2?.isActive = false
        plusButtonBottomAnchor = plusButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: 100
        )
        plusButtonBottomAnchor?.isActive = true
        view.layoutIfNeeded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showPlusButtonWithAnimation()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        notes = fetchData()
        setupNavBar()
        configureTableView()
        setupPlusButton()
    }

    private func setupNavBar() {
        navigationItem.title = "Заметки"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Выбрать",
            style: .plain,
            target: self,
            action: #selector(toggleTableEditingMode)
        )
    }

    @objc func toggleTableEditingMode() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        let isEdit = tableView.isEditing
        self.navigationItem.rightBarButtonItem?.title = isEdit ? "Готово" : "Выбрать"
        UIView.transition(
            with: plusButton,
            duration: 0.5,
            options: .transitionFlipFromLeft,
            animations: { [weak self] in
                guard let self = self else { return }
                self.plusButton.setImage(UIImage(named: isEdit ? "trushbutton" : "plusbutton"), for: .normal)
            }
        )
    }

    // MARK: TableView configuration

    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = cellHeight
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.register(NoteCell.self, forCellReuseIdentifier: noteCell)
        tableView.allowsMultipleSelectionDuringEditing = true

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

    private func setupPlusButton() {
        view.addSubview(plusButton)
        plusButton.layer.cornerRadius = 25
        plusButton.setImage(UIImage(named: "plusbutton"), for: .normal)

        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -20
        ).isActive = true
        plusButton.widthAnchor.constraint(
            equalToConstant: 50
        )
        .isActive = true
        plusButton.heightAnchor.constraint(
            equalToConstant: 50
        ).isActive = true

        plusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    // MARK: Animation to show plusbutton

    private func showPlusButtonWithAnimation() {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 4,
            options: [.layoutSubviews],
            animations: { [weak self] in
                guard let self = self else { return }
                self.plusButtonBottomAnchor?.isActive = false
                self.plusButtonBottomAnchor2 = self.plusButton.bottomAnchor.constraint(
                    equalTo: self.view.bottomAnchor,
                    constant: -60
                )
                self.plusButtonBottomAnchor2.isActive = true
                self.view.layoutSubviews()
            },
            completion: nil
        )
    }

    @objc private func buttonPressed(_ sender: Any) {
        if tableView.isEditing {
            UIView.animate(
                withDuration: 1,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.deleteButtonPressed()
                }
            )
        } else {
            tapPlusButtonWithAnimation()
        }
    }

    // MARK: Animation when tap PlusButton

    func tapPlusButtonWithAnimation() {
        UIView.animateKeyframes(
            withDuration: 0.6,
            delay: 0.0,
            options: [.layoutSubviews],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.30,
                    animations: {
                        self.plusButton.center.y -= 50.0
                    }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 0.35,
                    relativeDuration: 0.75,
                    animations: {
                        self.plusButton.center.y += 200.0
                    }
                )
            },
            completion: { _ in
                self.showNoteDetailsViewController()
            }
        )
    }
    // MARK: func showNoteDetailsViewController

    private func showNoteDetailsViewController(for note: NoteDataModel? = nil) {
        let noteDetailsController = NoteDetailsViewController()
        noteDetailsController.delegate = self
        noteDetailsController.set(note: note)
        navigationController?.pushViewController(noteDetailsController, animated: true)
    }

    // MARK: delete functions

    @objc func deleteButtonPressed() {
        if let selectedRows = self.tableView.indexPathsForSelectedRows, !(selectedRows.isEmpty) {
            for index in selectedRows {
                _ = updateModel(index: index, isChecked: true)
            }
            notes = notes.filter({ !$0.isChecked })
            tableView.reloadData()
            toggleTableEditingMode()
        } else {
            showAlert(message: "Вы не выбрали ни одной заметки", title: "Ошибка")
        }
    }

    private func updateModel(index: IndexPath, isChecked: Bool) -> NoteDataModel {
        notes[index.row].update(index: index, isChecked: isChecked)
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

        let note = updateModel(index: indexPath, isChecked: cell.isSelected)
        cell.setup(with: note)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: noteCell, for: indexPath)
                as? NoteCell else { return }
        let note = updateModel(index: indexPath, isChecked: cell.isSelected)
        if !tableView.isEditing {
            showNoteDetailsViewController(for: note)
        }
    }
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

// MARK: delete alert extension

extension ListViewController {
    private func showAlert(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

extension ListViewController {
    func fetchData() -> [NoteDataModel] {
        let note0 = NoteDataModel(noteTitle: "title 0", noteText: "Text 0", noteDate: "Date 0")
        let note1 = NoteDataModel(noteTitle: "title 1", noteText: "Text 1", noteDate: "Date 1")
        let note2 = NoteDataModel(noteTitle: "title 2", noteText: "Text 2", noteDate: "Date 2")
        let note3 = NoteDataModel(noteTitle: "title 3", noteText: "Text 3", noteDate: "Date 3")

        return [note0, note1, note2, note3]
    }
}
