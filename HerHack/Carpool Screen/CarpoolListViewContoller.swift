//
//  ViewController.swift
//  HerHack
//
//  Created by Ken Li on 22/11/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit

class CarpoolListViewContoller: UITableViewController {
    
    let carPools = [
        Carrpool(source: "TKO", dest: "YL", startTime: 1800, endTime: 1930, passengers: ["45079601"]),
        Carrpool(source: "TKO", dest: "YL", startTime: 1800, endTime: 1930, passengers: ["45079601"]),
        Carrpool(source: "TKO", dest: "YL", startTime: 1800, endTime: 1930, passengers: ["45079601"]),
    ]
    
    init() {
//        self.searchController = UISearchController()
        super.init(nibName: nil, bundle: nil)
//        self.searchController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
//
//extension CarpoolListViewContoller: UISearchControllerDelegate {
//    
//}
