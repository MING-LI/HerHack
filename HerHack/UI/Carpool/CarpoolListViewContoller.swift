//
//  ViewController.swift
//  HerHack
//
//  Created by Ken Li on 22/11/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit

class CarpoolListViewController: UIViewController {
    
    let greetingLabel: UILabel
    let searchBar: UISearchBar
    let tableView: UITableView
    
    let carPoolList: CarpoolList
    var filteredCarpools: [Carpool] = []
    
    init() {
        self.greetingLabel = UILabel()
        self.searchBar = UISearchBar()
        self.tableView = UITableView()
        self.carPoolList = CarpoolList()
        
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = .white
        
        let safeArea = self.view.layoutMarginsGuide
        
        self.view.addSubview(self.greetingLabel)
        self.greetingLabel.text = "Hi, \(UserSettings.name ?? "User")"
        self.greetingLabel.font = UIFont.boldSystemFont(ofSize: 40)
        self.greetingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeArea.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        self.view.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints({ make in
            make.top.equalTo(greetingLabel.snp.bottom)
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
        
        self.tableView.backgroundColor = Constants.Colors.PaleGreyColor
        self.tableView.register(CarpoolListCell.self, forCellReuseIdentifier: "CarpoolCell")
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.filteredCarpools = self.carPoolList.carpools
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.carPoolList.retrieveCarpool(refreshable: self)
    }
    
}

extension CarpoolListViewController: UITableViewDataSource, UITableViewDelegate {
    
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

extension CarpoolListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            self.filteredCarpools = self.carPoolList.carpools
        } else {
            self.filteredCarpools = self.carPoolList.carpools.filter({ carpool in
                return carpool.source.contains(searchText) || carpool.destination.contains(searchText)
            })
        }
        
        self.tableView.reloadData()
    }
    
}

extension CarpoolListViewController: DataRefreashable {
    
    func refresh() {
        self.filteredCarpools = self.carPoolList.carpools
        self.tableView.reloadData()
    }
}
