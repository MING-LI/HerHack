//
//  OfferFormViewController.swift
//  HerHack
//
//  Created by Mimosa Poon on 8/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit
import GooglePlaces

class OfferFormViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var searchRouteTextField = HHTextField()
    var source = CLLocationCoordinate2D()
    var destination = CLLocationCoordinate2D()
    let mapViewController = MapViewController()
    lazy var offerFormView: OfferFormView = {
        return OfferFormView(delegate: self)
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Make an Offer"
        setupViews()
    }
    
    func setupViews() {
        let safeArea = view.layoutMarginsGuide
        
        self.view.backgroundColor = .white
        
        scrollView.delaysContentTouches = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        offerFormView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(offerFormView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            offerFormView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            offerFormView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            offerFormView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension OfferFormViewController: OfferFormViewDelegate {
    func didClickedTextField(textField: HHTextField) {
        searchRouteTextField = textField
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    func didClickedContinue(departure: String) {
        
        navigationController?.pushViewController(mapViewController, animated: true)
        mapViewController.updateRoute(source: source, destination: destination)
    }
}


extension OfferFormViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        self.searchRouteTextField.text = place.name
        
        if(self.searchRouteTextField.tag == 0) {
            self.source = place.coordinate
        }else if(self.searchRouteTextField.tag == 1) {
            self.destination = place.coordinate
        }
        
        dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        
        dismiss(animated: true, completion: nil)
    }
}
