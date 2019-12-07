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
        Carpool(owner: "Ken", source: "TKO", dest: "YL", startTime: 1800, endTime: 1930, passengers: ["John"]),
        Carpool(owner: "Mimosa", source: "TKO", dest: "YL", startTime: 1800, endTime: 1930, passengers: ["Aakash"]),
        Carpool(owner: "Angus", source: "TKO", dest: "YL", startTime: 1800, endTime: 1930, passengers: ["Raymond"]),
    ]
    
    init() {
//        self.searchController = UISearchController()
        super.init(nibName: nil, bundle: nil)
        self.tableView.register(CarpoolListCell.self, forCellReuseIdentifier: "CarpoolCell")
//        self.searchController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .green
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CarpoolCell", for: indexPath) as! CarpoolListCell
//        let data = self.carPools[indexPath.row]
//        cell.plugData(data: data)
//        return cell
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.carPools.count
//    }

}
