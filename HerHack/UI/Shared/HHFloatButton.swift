//
//  HHFloatButton.swift
//  HerHack
//
//  Created by JohnC on 12/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit

class HHFloatButton: UIButton {
    var buttonPressed: ()->()
    
    required init(_ name: String, buttonPressed:@escaping ()->()) {
        self.buttonPressed = buttonPressed
        super.init(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        setView(name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView(_ name:String) {
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
        self.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.setImage(UIImage(named: name), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 50,left: 50,bottom: 50,right: 50)
        self.addTarget(self, action: #selector(didButtonPressed), for: .touchUpInside)
    }
    
    @objc func didButtonPressed() {
        self.buttonPressed()
    }
}
