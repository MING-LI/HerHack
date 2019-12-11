//
//  OfferFormViewDelegate.swift
//  HerHack
//
//  Created by LabLamb on 8/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation

protocol OfferFormViewDelegate {
    func didClickedTextField(textField: HHTextField)
    func didClickedContinue(departure: Date)
}
