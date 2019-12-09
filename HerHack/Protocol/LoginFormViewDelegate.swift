//
//  LoginFormViewDelegate.swift
//  HerHack
//
//  Created by JohnC on 9/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

protocol LoginFormViewDelegate {
    func didClickedTextField(textField: HHTextField)
    func didClickedButton(email: String)
}
