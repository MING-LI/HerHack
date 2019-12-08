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
    
    var source: CLLocationCoordinate2D
    var destination: CLLocationCoordinate2D
    
    let hk = CLLocationCoordinate2D(latitude: 22.3193, longitude:114.1694)
    
    let camera: GMSCameraPosition
    
    var searchRouteTextField: HHTextField
    
    var markers = [GMSMarker]()
    var bounds = GMSCoordinateBounds()
    
    lazy var mapView = {
        return GMSMapView.map(withFrame: CGRect.zero, camera: self.camera)
    }()
    
    lazy var searchRouteView: SearchRouteView = {
        return SearchRouteView(delegate: self)
    }()
    
    init() {
        self.camera = GMSCameraPosition.camera(withLatitude: hk.latitude, longitude: hk.longitude, zoom: 13.0)
        self.searchRouteTextField = HHTextField()
        self.source = CLLocationCoordinate2D()
        self.destination = CLLocationCoordinate2D()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.MapViewScreenName
        self.view = mapView
        
        setupViews()
    }
    
    func setupViews() {
        let safeArea = view.layoutMarginsGuide
        
        view.addSubview(searchRouteView)
        
        searchRouteView.translatesAutoresizingMaskIntoConstraints = false
        searchRouteView.backgroundColor = .white
        searchRouteView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            searchRouteView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchRouteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchRouteView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func addMarker(coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = coordinate
        marker.map = mapView
        self.markers.append(marker)
    }
    
    func fitBound() {
        for marker in self.markers {
            bounds = bounds.includingCoordinate(marker.position)
        }
        self.mapView.animate(with: GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 50.0, left: 50.0, bottom: 50.0, right: 50.0)))
    }
    
    func fetchRoute() {
        guard let url = Constants.googleDirectionsAPI(src: self.source, dest: self.destination) else {
            print("Failed to parse URL.")
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard let `data` = data,
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary,
                let routes = jsonData["routes"] as? [Any],
                let route = routes[0] as? [String: Any],
                let overview_polyline = route["overview_polyline"] as? [String: Any],
                let polyLineString = overview_polyline["points"] as? String
                else {
                    let alert = UIAlertController(title: "Error", message: "An error occured.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    return
            }
            self.drawPath(from: polyLineString)
        }).resume()
    }
    
    func drawPath(from polyStr: String) {
        DispatchQueue.main.async(execute: {
            let path = GMSPath(fromEncodedPath: polyStr)
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 4.0
            polyline.strokeColor = Constants.Colors.Blue
            polyline.map = self.mapView // Google MapView
        })
    }
}

extension MapViewController: SearchRouteViewProtocol {
    func didClickedTextField(textField: HHTextField) {
        self.searchRouteTextField = textField
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    func didClickedSearch() {
        markers = []
        addMarker(coordinate: source)
        addMarker(coordinate: destination)
        fitBound()
        fetchRoute()
    }
}

extension MapViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        self.searchRouteTextField.text = place.name
        if(self.searchRouteTextField.tag == 0) {
            self.source = place.coordinate
        }else if(self.searchRouteTextField.tag == 1) {
            self.destination = place.coordinate
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



