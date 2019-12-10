//
//  HHTabbar.swift
//  HerHack
//
//  Created by JohnC on 9/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit

class HHTabbar: UITabBarController {
    
    required init() {
        super.init(nibName: nil, bundle: Bundle.main)
        setContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var contentView: UIView?
    
    func setContentView() {
        let carpoolListScreen = UINavigationController(rootViewController: CarpoolListViewController())
        carpoolListScreen.tabBarItem.title = Constants.CarpoolScreenName
        carpoolListScreen.tabBarItem.image = #imageLiteral(resourceName: "car")
        
        let offerFormScreen = UINavigationController(rootViewController: OfferFormViewController())
        offerFormScreen.tabBarItem.title = "Make an Offer"
        offerFormScreen.tabBarItem.image = #imageLiteral(resourceName: "map")
        
        let controllers = [carpoolListScreen, offerFormScreen]
        viewControllers = controllers
    }
}
