//
//  ViewController.swift
//  HerHack
//
//  Created by Ken Li on 22/11/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit

class CarpoolListViewContoller: UIViewController {
    
    let searchBar: UISearchBar
    let tableView: UITableView
    
    let carPools = [
        Carpool(source: "屯門", destination: "將軍澳", offered_seats: 3, created_at: ISO8601DateFormatter().date(from:"2019-12-09T07:00:00+0800")!, start_at: ISO8601DateFormatter().date(from:"2019-12-09T08:00:00+0800")!, end_at: ISO8601DateFormatter().date(from:"2019-12-09T09:30:00+0800")!, user_offer_ride: "Ken", users_request_ride: [CarpoolRequest(user_id:"John",is_accepted:false)], status: CarpoolStatus.OPEN),
        Carpool(source: "筲箕灣", destination: "將軍澳", offered_seats: 3, created_at: ISO8601DateFormatter().date(from:"2019-12-09T07:00:00+0800")!,start_at:ISO8601DateFormatter().date(from:"2019-12-09T08:00:00+0800")!, end_at: ISO8601DateFormatter().date(from:"2019-12-09T09:30:00+0800")!,user_offer_ride: "Mimosa", users_request_ride: [CarpoolRequest(user_id:"Aakash",is_accepted:false)], status: CarpoolStatus.OPEN),
        Carpool(source: "荃灣", destination: "奧運", offered_seats: 3, created_at: ISO8601DateFormatter().date(from:"2019-12-09T07:00:00+0800")!, start_at:ISO8601DateFormatter().date(from:"2019-12-09T08:00:00+0800")!, end_at: ISO8601DateFormatter().date(from:"2019-12-09T09:30:00+0800")!,user_offer_ride: "Angus", users_request_ride: [CarpoolRequest(user_id:"Raymond",is_accepted:false)], status: CarpoolStatus.OPEN),
    ]
    
    var filteredCarpools: [Carpool] = []
    
    init() {
        self.searchBar = UISearchBar()
        self.tableView = UITableView()
        
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        
        self.filteredCarpools = self.carPools
        
        let safeArea = self.view.layoutMarginsGuide
//        self.edgesForExtendedLayout = []
        
        self.view.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints({ make in
            make.top.equalTo(safeArea.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        })
        
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Find a carpool"
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints({ make in
            make.top.equalTo(self.searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        })
        
        self.tableView.register(CarpoolListCell.self, forCellReuseIdentifier: "CarpoolCell")
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.CarpoolScreenName
    }
    
}

extension CarpoolListViewContoller: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarpoolCell", for: indexPath) as! CarpoolListCell
        let data = self.filteredCarpools[indexPath.row]
        cell.plugData(data: data)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredCarpools.count
    }
}

extension CarpoolListViewContoller: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            self.filteredCarpools = self.carPools
        } else {
            self.filteredCarpools = self.carPools.filter({ carpool in
                return carpool.source.contains(searchText) || carpool.destination.contains(searchText)
            })
            
            
        }
        
        self.tableView.reloadData()
    }
    
}
