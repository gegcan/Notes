//
//  UITextField + Extension.swift
//  Notes
//
//  Created by Александр on 12.03.2022.
//

import UIKit

extension UITextField {
    
    convenience init(font: UIFont? = .avenirNext(), placeholder: String) {
        self.init()
        
        self.font = font
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
    }
}
