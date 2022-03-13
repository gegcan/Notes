//
//  ViewController.swift
//  Notes
//
//  Created by Александр on 12.03.2022.
//

import UIKit
import RealmSwift

class NotesViewController: UIViewController {
    
    let tableView = UITableView()
    var segmentedControl = UISegmentedControl()
    
    var notes: Results<NoteModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Notes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        
        notes = realm.objects(NoteModel.self).sorted(byKeyPath: "noteTitle")
        
        firstNote()
        configureSegmentedControl()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configureSegmentedControl() {
        let items = ["Name", "Date"]
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .black
        segmentedControl.addTarget(self, action: #selector(segmentedControlSelected), for: .valueChanged)
    }
    
    @objc private func segmentedControlSelected(_ target: UISegmentedControl) {
        if target.selectedSegmentIndex == 0 {
            notes = notes.sorted(byKeyPath: "noteTitle")
        } else {
            notes = notes.sorted(byKeyPath: "date")
        }
        tableView.reloadData()
    }
    
    @objc private func addNote() {
        let addNoteController = AddNoteController()
        addNoteController.modalPresentationStyle = .fullScreen
        present(addNoteController, animated: true, completion: nil)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.reuseId)
        tableView.rowHeight = 100
        setConstraint()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseId, for: indexPath) as! NoteTableViewCell
        
        let note = notes[indexPath.row]
        cell.configureCell(note: note)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: nil) { (_, _, _) in
            
            var note: NoteModel!
            
            note = self.notes[indexPath.row]
            StorageManager.deleteNote(note)
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        delete.image = UIImage(systemName: "trash")
        
        let edit = UIContextualAction(style: .normal, title: nil) { (_, _, _) in
            
            let note = self.notes[indexPath.row]
            
            let addNoteController = AddNoteController()
            addNoteController.note = note
            addNoteController.modalPresentationStyle = .fullScreen
            self.present(addNoteController, animated: true, completion: nil)
        }
        
        edit.image = UIImage(systemName: "rectangle.and.pencil.and.ellipsis")
        edit.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        
        let swipeAction = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipeAction
    }
}

// MARK: - Configure constraints
extension NotesViewController {
    private func setConstraint() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
