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
            searchRouteView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            searchRouteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchRouteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
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
        mapView.animate(with: GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 50.0 , left: 50.0 ,bottom: 50.0 ,right: 50.0)))
    }
    
    func fetchRoute() {
        let session = URLSession.shared
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=" + Constants.Key)!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if response != nil {
                var jsonData : Any?
                do {
                    jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                } catch let error1 as NSError {
                    _ = error1
                    jsonData = nil
                } catch {
                    fatalError()
                }
                
                if jsonData != nil {
                    if let _jsonData = jsonData as? NSDictionary {
                        guard let routes = _jsonData["routes"] as? [Any] else {
                            return
                        }
                        
                        guard let route = routes[0] as? [String: Any] else {
                            return
                        }

                        guard let overview_polyline = route["overview_polyline"] as? [String: Any] else {
                            return
                        }

                        guard let polyLineString = overview_polyline["points"] as? String else {
                            return
                        }
                        
                        self.drawPath(from: polyLineString)
                    }
                }else {
                    print("json data is nil")
                }
            }else {
                print("response is nil")
            }
        })
        task.resume()
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



