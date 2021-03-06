//
//  ViewController.swift
//  HerHack
//
//  Created by Ken Li on 22/11/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class CarpoolListViewController: UIViewController {
    
    let locationManager: CLLocationManager
    let greetingLabel: UILabel
    
    //    var avatar: UIImageView =  {
    //        let image = UIImage(named: "mimosa")
    //        let imageView = UIImageView(image: image)
    //        return imageView
    //    }()
    
    let searchBar: UISearchBar
    let tableView: UITableView
    
    let carPoolList: CarpoolList
    var filteredCarpools: [Carpool] = []
    
    init() {
        self.greetingLabel = UILabel()
        self.searchBar = UISearchBar()
        self.tableView = UITableView()
        self.carPoolList = CarpoolList()
        self.locationManager = CLLocationManager()
        
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = Constants.Colors.PaleGreyColor
        
        let safeArea = self.view.layoutMarginsGuide
        
        
        
        //        self.view.addSubview(self.avatar)
        //        self.avatar.snp.makeConstraints { (make) in
        //            make.top.equalTo(safeArea.snp.top).offset(10)
        //            make.right.equalTo(-15)
        //            make.height.equalTo(50)
        //            make.width.equalTo(50)
        //        }
        
        self.view.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints({ make in
            make.top.equalTo(safeArea.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        })
        
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Find a carpool"
        self.searchBar.showsBookmarkButton = true
        self.searchBar.setImage(#imageLiteral(resourceName: "location"), for: .bookmark, state: .normal)
        
        
        self.view.addSubview(self.greetingLabel)
        self.greetingLabel.text = "Welcome back, \(UserSettings.name ?? "User") 👋🏻"
        self.greetingLabel.font = Constants.Fonts.LargeBoldFont
        self.greetingLabel.textAlignment = .center
        self.greetingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchBar.snp.bottom).offset(Constants.MinimumSpacing * 2)
            make.left.equalToSuperview().offset(Constants.MinimumSpacing * 2)
            make.right.equalToSuperview().offset(-Constants.MinimumSpacing * 2)
        }
        self.greetingLabel.backgroundColor = Constants.Colors.PaleGreyColor
        
        
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints({ make in
            make.top.equalTo(self.greetingLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        })
        
        self.tableView.contentInset = UIEdgeInsets(top: Constants.MinimumSpacing, left: 0, bottom: 0, right: 0)
        self.tableView.backgroundColor = Constants.Colors.PaleGreyColor
        self.tableView.register(CarpoolListCell.self, forCellReuseIdentifier: "CarpoolCell")
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.rowHeight = 180
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
        cell.delegate = self
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
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
            guard let loc = self.locationManager.location else { return }
            GMSGeocoder().reverseGeocodeCoordinate(loc.coordinate, completionHandler: { [weak self] response, result in
                guard let `self` = self,
                    let firstResult = response?.firstResult() else { return }

                var addArr = [String]()

                addArr.append(firstResult.thoroughfare ?? "")
                addArr.append(firstResult.subLocality ?? "")
                addArr.append(firstResult.locality ?? "")
                addArr.append(firstResult.administrativeArea ?? "")
                addArr.append(firstResult.country ?? "")

                let locString = addArr.joined(separator: " ")

                self.searchBar.becomeFirstResponder()
                self.searchBar.text = locString
                self.searchBar(self.searchBar, textDidChange: locString)
            })
        }
    }
    
}

extension CarpoolListViewController: DataRefreashable {
    
    func refresh() {
        self.filteredCarpools = self.carPoolList.carpools
        self.tableView.reloadData()
    }
}

extension CarpoolListViewController: CarpooListCellDelegate {
    func didClickedComment(_ carpoolId:String) {
        let selectedCarpool:[Carpool] = carPoolList.carpools.filter { carpool in
            return carpool.id == carpoolId
        }
        let commentPopup = PollFormViewController(carpool:selectedCarpool[0])
        self.present(commentPopup, animated: true, completion: nil)
    }
    
}
