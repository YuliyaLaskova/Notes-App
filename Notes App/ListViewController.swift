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
    private let deleteButton = UIButton()
    var plusButtonBottomAnchor: NSLayoutConstraint!

    var notes = [NoteDataModel]()
    private let noteCell = "NoteCell"

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        plusButtonBottomAnchor?.isActive = true
        view.layoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showPlusButtonWithAnimation()
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
            action: #selector(updateSelectButton)
        )
    }

    @objc func updateSelectButton () {
        if !tableView.isEditing {
            enterEditingMode()
        } else {
            cancelEditingMode()
        }
    }

    // MARK: animations for changing button state

    private  func enterEditingMode() {
        tableView.setEditing(true, animated: true)
        self.navigationItem.rightBarButtonItem?.title = "Готово"
        UIView.transition(
            with: plusButton,
            duration: 0.5,
            options: .transitionFlipFromLeft,
            animations: { [weak self] in
                guard let self = self else { return }
                self.plusButton.setImage(UIImage(named: "trushbutton"), for: .normal)
            }, completion: nil
        )
    }

    private func cancelEditingMode() {
        tableView.setEditing(false, animated: true)
        self.navigationItem.rightBarButtonItem?.title = "Выбрать"
        UIView.transition(
            with: plusButton,
            duration: 0.5,
            options: .transitionFlipFromLeft,
            animations: { [weak self] in
                guard let self = self else { return }
                self.plusButton.setImage(UIImage(named: "plusbutton"), for: .normal)
            }, completion: nil
        )
    }

    // MARK: TableView configuration

    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 90
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

        plusButtonBottomAnchor = plusButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: 100
        )
        plusButtonBottomAnchor?.isActive = true
        self.view.addConstraint(plusButtonBottomAnchor)

        plusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    // MARK: Animation to show plusbutton

    // срабатывает только при первой загрузке приложения

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
                self.plusButton.bottomAnchor.constraint(
                    equalTo: self.view.bottomAnchor,
                    constant: -60
                ).isActive = true
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
                }, completion: { [weak self] _ in
                    guard let self = self else { return }
                    self.tableView.reloadData()
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
        let selectedRows = self.tableView.indexPathsForSelectedRows
        if selectedRows != nil {
            for var selectionIndex in selectedRows! {
                while selectionIndex.item >= notes.count {
                    selectionIndex.item -= 1
                }
                tableView(tableView, commit: .delete, forRowAt: selectionIndex)
            }
            cancelEditingMode()
        } else {
            showAlert(message: "Вы не выбрали ни одной заметки", title: "Ошибка")
        }
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
        //  check marks color in editing mode
        // cell.tintColor = .blu
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row].update(index: indexPath)
        if tableView.isEditing == false {
            showNoteDetailsViewController(for: note)
        }
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
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
