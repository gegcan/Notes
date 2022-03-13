//
//  NoteModel.swift
//  Notes
//
//  Created by Александр on 12.03.2022.
//

import RealmSwift

class NoteModel: Object {
    
    @objc dynamic var noteTitle = ""
    @objc dynamic var noteBody = ""
    @objc dynamic var date = Date()
}
