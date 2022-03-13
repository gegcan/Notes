//
//  AddNoteController.swift
//  Notes
//
//  Created by Александр on 12.03.2022.
//

import UIKit

class AddNoteController: UIViewController {
    
    let noteTextField = UITextField(placeholder: "Add title note")
    let noteTextView = UITextView(backgroundColor: .textViewBackground())
    let saveButton = UIButton(title: "Save note")
    let closeButton = UIButton(title: "Close note")
    
    var note: NoteModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9198423028, green: 0.9198423028, blue: 0.9198423028, alpha: 1)
        
        saveButton.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(exitViewController), for: .touchUpInside)
        
        addDataToForms()
        setConstraint()
    }

    private func addDataToForms() {
        
        guard let note = note else { return }
        
        noteTextField.text = note.noteTitle
        noteTextView.text = note.noteBody
        saveButton.setTitle("Edit note", for: .normal)
    }
    
    @objc private func saveNote() {
        
        guard let noteTitle = noteTextField.text, let noteBody = noteTextView.text, noteTitle != "", noteBody != "" else { return }
        
        if let note = note {
            StorageManager.editNote(note, noteTitle: noteTitle, noteBody: noteBody)
        } else {
            let noteModel = NoteModel()
            noteModel.noteTitle = noteTitle
            noteModel.noteBody = noteBody
            
            DispatchQueue.main.async {
                StorageManager.saveNote(noteModel)
            }
        }

        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func exitViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Скрытие клавиатуры по тапу за пределами Text View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
    }
}

// MARK: - Configure constraints
extension AddNoteController {
    
    private func setConstraint() {
        
        noteTextField.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(noteTextField)
        view.addSubview(noteTextView)
        
        NSLayoutConstraint.activate([
            noteTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            noteTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            noteTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            noteTextField.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            noteTextView.topAnchor.constraint(equalTo: noteTextField.bottomAnchor, constant: 5),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            noteTextView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        let stackViewButtons = UIStackView(arrangedSubviews: [saveButton, closeButton])
        stackViewButtons.axis = .horizontal
        stackViewButtons.spacing = 8
        stackViewButtons.distribution = .fillEqually
        
        stackViewButtons.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewButtons)
    
        NSLayoutConstraint.activate([
            stackViewButtons.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 5),
            stackViewButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackViewButtons.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
