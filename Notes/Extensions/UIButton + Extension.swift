//
//  UIButton + Extension.swift
//  Notes
//
//  Created by Александр on 12.03.2022.
//

import UIKit

extension UIButton {
    
    convenience init(title: String, font: UIFont? = .avenirNextBold()) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = .buttonBackground()
        self.titleLabel?.font = font
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
    }
}

