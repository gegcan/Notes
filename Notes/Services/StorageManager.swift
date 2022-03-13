//
//  StorageManager.swift
//  Notes
//
//  Created by Александр on 12.03.2022.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveNote(_ note: NoteModel) {
        try! realm.write {
            realm.add(note)
        }
    }
    
    static func deleteNote(_ note: NoteModel) {
        try! realm.write {
            realm.delete(note)
        }
    }
    
    static func editNote(_ note: NoteModel, noteTitle: String, noteBody: String) {
        try! realm.write {
            note.noteTitle = noteTitle
            note.noteBody = noteBody
        }
    }
}
