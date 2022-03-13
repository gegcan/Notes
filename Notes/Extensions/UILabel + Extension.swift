//
//  UILabel + Extension.swift
//  Notes
//
//  Created by Александр on 12.03.2022.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenirNext()) {
        self.init()
        self.text = text
        self.font = font
    }
}

