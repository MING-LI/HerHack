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
import SnapKit

class MapViewController: UIViewController {
    
    open var source: CLLocationCoordinate2D
    open var destination: CLLocationCoordinate2D
    open var wayPoints: [CLLocationCoordinate2D]
    var distanceAndDuration: DistanceAndDuration?
    var carpool: Carpool?
    var estimatedArrivalTime: Date?
    
    let hk = CLLocationCoordinate2D(latitude: 22.3193, longitude:114.1694)
    let camera: GMSCameraPosition

    var markers = [GMSMarker]()
    var bounds = GMSCoordinateBounds()
    
    var isUpdateRoute = false
    
    lazy var mapView = {
        return GMSMapView.map(withFrame: CGRect.zero, camera: self.camera)
    }()
    
    
    init() {
        self.camera = GMSCameraPosition.camera(withLatitude: hk.latitude, longitude: hk.longitude, zoom: 13.0)
        self.source = CLLocationCoordinate2D()
        self.destination = CLLocationCoordinate2D()
        self.wayPoints = [CLLocationCoordinate2D]()
        self.carpool = nil
        self.distanceAndDuration = nil
        self.estimatedArrivalTime = nil

        super.init(nibName: nil, bundle: nil)
        
        let createCarpoolHandler = { () in
            if let carpool = self.carpool {
                FirestoreService.shared.createCarpool(carpool, completion: {
                    self.navigationController?.pushViewController(CarpoolListViewController(), animated: true)
                })
            } else { return }
        }
        let button = HHFloatButton("okay", buttonPressed: createCarpoolHandler)
        self.view.addSubview(button)
        let safeArea = view.layoutMarginsGuide
        button.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.centerX.equalTo(view)
            make.bottom.equalTo(safeArea.snp.bottom).offset(-30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.MapViewScreenName
        self.view = mapView
        mapView.delegate = self
    }
    
    open func didReceiveData(_ data: OfferFormData) {
        let user = CarpoolUser(user_id: UserSettings.uid, user_name: UserSettings.name, is_accepted: nil)
        GoogleService.shared.getDistanceAndDuration(source: data.source_coordinates, destination: data.destination_coordinates, completion: { distanceAndDuration in
            self.distanceAndDuration = distanceAndDuration
            self.estimatedArrivalTime = data.start_at.addingTimeInterval(TimeInterval(distanceAndDuration.duration))
            self.carpool = Carpool(
                id: nil,
                source: data.source,
                source_coordinates: self.source,
                destination: data.destination,
                destination_coordinates: self.destination,
                offered_seats: data.offered_seats,
                created_at: Date(),
                start_at: data.start_at,
                end_at: self.estimatedArrivalTime!,
                user_offer_ride: user,
                users_request_ride: [],
                status: CarpoolStatus.OPEN
            )
            self.setPromptView()
        })
    }
    
    open func updateRoute(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, wayPoints: [CLLocationCoordinate2D]) {
        self.isUpdateRoute = true
        self.source = source
        self.wayPoints = wayPoints
        self.destination = destination
        mapView.clear()
        markers = []
        addMarker(coordinate: source)
        addMarker(coordinate: destination)
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
        self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
    }
    
    func fetchRoute() {
        print("source L" ,  self.source)
        print("destination L" ,  self.destination)
        guard let url = Constants.googleDirectionsAPI(src: self.source, dest: self.destination, wayPoints: self.wayPoints) else {
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
    
    func setPromptView() {
        let lbl = UILabel()
            lbl.layer.cornerRadius = 0.5 * lbl.bounds.size.width
            lbl.clipsToBounds = true
            lbl.lineBreakMode = .byWordWrapping
            lbl.numberOfLines = 0
            lbl.font = Constants.Fonts.LargeBoldFont
            lbl.textColor = .black
            lbl.textAlignment = .center
            lbl.backgroundColor = UIColor(white: 1, alpha: 0.5)
        if let dnd = distanceAndDuration {
            lbl.text = """
                Distance: \(String(dnd.distance/1000))km
                Est. : ~\(String(dnd.duration/60))min
                Arrival: \(String(estimatedArrivalTime!.toString(format: "hh:mm")))
            """
            view.addSubview(lbl)
            lbl.snp.makeConstraints { (make) in
                make.width.height.equalTo(200)
                make.center.equalTo(view)
            }
        }
    }
}

extension MapViewController: GMSMapViewDelegate {
    func  mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        if(isUpdateRoute) {
            isUpdateRoute = false
            fitBound()
            fetchRoute()
        }
    }
}
