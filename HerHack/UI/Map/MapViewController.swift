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
    
    open var source: CLLocationCoordinate2D
    open var destination: CLLocationCoordinate2D
    
    let hk = CLLocationCoordinate2D(latitude: 22.3193, longitude:114.1694)
    
    let camera: GMSCameraPosition
    
    var markers = [GMSMarker]()
    var bounds = GMSCoordinateBounds()
    
    lazy var mapView = {
        return GMSMapView.map(withFrame: CGRect.zero, camera: self.camera)
    }()
    
    
    init() {
        self.camera = GMSCameraPosition.camera(withLatitude: hk.latitude, longitude: hk.longitude, zoom: 13.0)
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
    
    func updateCamera() {
        markers = []
        addMarker(coordinate: source)
        addMarker(coordinate: destination)
        fitBound()
    }
    
    open func fetchRoute() {
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
