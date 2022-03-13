//
//  FirstNote.swift
//  Notes
//
//  Created by Александр on 12.03.2022.
//

import UIKit

extension NotesViewController {
    
    func firstNote() {
        if notes.count == 0 {
            
            let note = NoteModel()
            note.noteTitle = "Lorem Ipsum"
            note.noteBody = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
            
            DispatchQueue.main.async {
                StorageManager.saveNote(note)
                self.tableView.reloadData()
            }
        }
    }
}
