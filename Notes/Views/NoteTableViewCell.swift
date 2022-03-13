//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Александр on 12.03.2022.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    static let reuseId = "notesCell"
    
    let titleLabel = UILabel(text: "Title note", font: .avenirNextBold())
    let bodyNoteLabel = UILabel(text: "Note")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureConstraint()
    }
    
    func configureCell(note: NoteModel) {
        self.titleLabel.text = note.noteTitle
        self.bodyNoteLabel.text = note.noteBody
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure constraints
extension NoteTableViewCell {
    
    private func configureConstraint() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyNoteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(bodyNoteLabel)
        
        bodyNoteLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            bodyNoteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            bodyNoteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            bodyNoteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            bodyNoteLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}

