//
//  HHTextField.swift
//  HerHack
//
//  Created by Mimosa Poon on 7/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit

class HHTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.text = "Your location"
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.MinimumSpacing, height: Constants.MinimumSpacing))
        self.leftViewMode = UITextField.ViewMode.always
        self.font = Constants.Fonts.RegularFont
        self.textColor = .black
        self.backgroundColor = .white
        self.textAlignment = .left
        self.isUserInteractionEnabled = true
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = Constants.Colors.GreyColor.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UITextField {
    func setIcon(_ image: UIImage) {
       let iconView = UIImageView(frame:
                      CGRect(x: 10, y: 5, width: 20, height: 20))
       iconView.image = image
       let iconContainerView: UIView = UIView(frame:
                      CGRect(x: 20, y: 0, width: 38, height: 30))
       iconContainerView.addSubview(iconView)
       leftView = iconContainerView
       leftViewMode = .always
    }
}

