//
//  LoginFormViewDelegate.swift
//  HerHack
//
//  Created by JohnC on 9/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

protocol LoginFormViewDelegate {
    func didClickedTextField(_ textField: HHTextField)
    func didClickedButton(name:String, email: String)
    func returnFromTextField(_ textField: HHTextField) -> Bool
}
