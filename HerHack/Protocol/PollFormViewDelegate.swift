//
//  PollFormViewDelegate.swift
//  HerHack
//
//  Created by JohnC on 13/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

protocol PollFormViewDelegate {
    func didClickedButton(rating:Int, comment: String)
    func didClickedCancel()
}
