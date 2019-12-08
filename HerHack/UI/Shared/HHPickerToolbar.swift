//
//  HHPickerToolbar.swift
//  HerHack
//
//  Created by Mimosa Poon on 8/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit

class HHPickerToolbar: UIToolbar {
    let toolbarDelegate: HHPickerToolbarDelegate
    
    init(delegate: HHPickerToolbarDelegate) {
        self.toolbarDelegate = delegate
        
        super.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
        self.barStyle = UIBarStyle.default
        self.isTranslucent = true
        self.tintColor = .black
        self.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        
        self.setItems([ cancelButton, spaceButton, doneButton], animated: false)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doneTapped() {
        print("doneTapped")
        toolbarDelegate.didTapDone()
    }
    
    @objc func cancelTapped() {
        toolbarDelegate.didTapCancel()
    }
}
