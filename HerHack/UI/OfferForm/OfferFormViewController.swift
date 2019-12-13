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
    
    let mapViewController = MapViewController()
    
    lazy var offerFormView: OfferFormView = {
        return OfferFormView(delegate: self)
    }()
    
    let seatPicker = Array(1...7)
    var offerFormData = OfferFormData()
    
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
    
    func didSelectedSeat(textFieldText: String) {
        let textFieldInt = Int(textFieldText)
        offerFormData.offered_seats = textFieldInt ?? 0
    }
    
    func didClickedContinue(departure: Date) {
        offerFormData.start_at = departure
        navigationController?.pushViewController(mapViewController, animated: true)
        mapViewController.didReceiveData(offerFormData)
        print( "----------------Way Pointss-----------------")
        print( offerFormData.wayPoints)
        mapViewController.updateRoute(source: offerFormData.source_coordinates, destination: offerFormData.destination_coordinates, wayPoints: offerFormData.wayPoints)
    }
}


extension OfferFormViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        searchRouteTextField.text = place.name
        if(searchRouteTextField.tag == 0) {
            print("Add source!!!!!!!")
            offerFormData.source = place.name ?? ""
            offerFormData.source_coordinates = place.coordinate
        }else if(searchRouteTextField.tag == 1) {
            print("Add dest!!!!!!!")
            offerFormData.destination = place.name ?? ""
            offerFormData.destination_coordinates = place.coordinate
        }else if(searchRouteTextField.tag == 2) {
            print("Add way pointssss!!!!!!!")
            offerFormData.destination = place.name ?? ""
            offerFormData.wayPoints.append(place.coordinate)
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

extension OfferFormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return seatPicker.count
    }
    
    func pickerView(_pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        offerFormData.offered_seats = seatPicker[row]
        return
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(seatPicker[row])
    }
}

