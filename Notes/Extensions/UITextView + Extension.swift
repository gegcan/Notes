//
//  UITextView + Extension.swift
//  Notes
//
//  Created by Александр on 12.03.2022.
//

import UIKit

extension UITextView {
    
    convenience init(font: UIFont? = .avenirNext(), backgroundColor: UIColor) {
        self.init()
        
        self.font = font
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
    }
}
