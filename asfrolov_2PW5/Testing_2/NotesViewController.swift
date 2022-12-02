//
//  NotesViewController.swift
//  Testing_2
//
//  Created by admin on 20.11.2022.
//

import Foundation
import UIKit

final class NotesViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var dataSource = [ShortNote] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func setupView() {
        setupTableView()
        setupNavBar()
    }
    
    @objc
    private func dismissViewController() {
        self.dismiss(animated: true)
    }
    
    private func setupNavBar() {
        self.title = "Notes"
        
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        closeButton.isHidden = false
        closeButton.backgroundColor = .systemGray5
        
        closeButton.layer.cornerRadius = 12
        self.view.addSubview(closeButton)
        closeButton.pin(to: view, [.top: 14, .right: 14])
    }
    private func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)
    
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        tableView.backgroundColor = .systemGray5
        tableView.keyboardDismissMode = .onDrag
        tableView.isHidden = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.pin(to: self.view, [.bottom: 24, .top: 24, .left: 24, .right: 24])
        tableView.layer.cornerRadius = 12
        view.addSubview(tableView)
    }
    
    private func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    
}
    
    extension NotesViewController: UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier: AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            let note = dataSource[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
                noteCell.configure(note)
                return noteCell
            }
        }
        return UITableViewCell()
    }
        
}
extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: .none) {
            [weak self] (action, view, completion) in self?.handleDelete(indexPath: indexPath); completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill",
                                     withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
        )?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}



extension NotesViewController: AddNoteDelegate {
    func newNoteAdded(_ note: ShortNote) {
        dataSource.insert(note, at: 0)
        tableView.reloadData()
    }
}

