//
//  MapViewController.swift
//  HerHack
//
//  Created by Mimosa Poon on 7/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {
    
    let hk = CLLocationCoordinate2D(latitude: 22.3193, longitude:114.1694)
    
    lazy var  camera = {
        return GMSCameraPosition.camera(withLatitude: hk.latitude, longitude: hk.longitude, zoom: 13.0)
    }()
    
    lazy var mapView = {
        return GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    }()
    
    var searchRouteView = {
        return SearchRouteView()
    }()
    
    var searchRouteTextField: HHTextField?
      
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        view = mapView
        
        setupViews()
    }
    
    func setupViews() {
        let safeArea = view.layoutMarginsGuide
        
        view.addSubview(searchRouteView)
        
        searchRouteView.delegate = self
        searchRouteView.translatesAutoresizingMaskIntoConstraints = false
        searchRouteView.backgroundColor = .white
        searchRouteView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            searchRouteView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            searchRouteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchRouteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
}

extension MapViewController: HHTextFieldProtocol {
    func didClickedTextField(textField: HHTextField) {
        self.searchRouteTextField = textField
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
}


extension MapViewController: GMSAutocompleteViewControllerDelegate {
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    
    if let textField = self.searchRouteTextField {
        textField.text = place.name
    }
    
// Dismiss the GMSAutocompleteViewController when something is selected
    dismiss(animated: true, completion: nil)
  }
func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // Handle the error
    print("Error: ", error.localizedDescription)
  }
func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    // Dismiss when the user canceled the action
    dismiss(animated: true, completion: nil)
  }
}



