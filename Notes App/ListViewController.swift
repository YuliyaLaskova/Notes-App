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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showPlusButtonWithAnimation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6

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
        UIView.transition(
            with: plusButton,
            duration: 0.5,
            options: .transitionFlipFromLeft
        ) {
            self.plusButton.setImage(UIImage(named: "trushbutton"), for: .normal)
        } completion: { _ in
            self.navigationItem.rightBarButtonItem?.title = "Готово"
        }
    }

    private func cancelEditingMode() {
        tableView.setEditing(false, animated: true)
        UIView.transition(
            with: plusButton,
            duration: 0.5,
            options: .transitionFlipFromLeft
        ) {
            self.plusButton.setImage(UIImage(named: "plusbutton"), for: .normal)
            self.tableView.isEditing = false
        } completion: { _ in
            self.navigationItem.rightBarButtonItem?.title = "Выбрать"
        }
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

        plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
    }

    @objc func plusButtonPressed(_ sender: UIButton) {
        // showNoteDetailsViewController()
        tapPlusButtonWithAnimation()
    }

    // MARK: Animation to show plusbutton

    // срабатывает только при первой загрузке приложения

    private func showPlusButtonWithAnimation() {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 4,
            options: []
        ) { [weak self] in
            guard let self = self else {
                return
            }
            self.plusButtonBottomAnchor?.isActive = false
            self.plusButton.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor,
                constant: -60
            ).isActive = true
            self.view.layoutSubviews()
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
