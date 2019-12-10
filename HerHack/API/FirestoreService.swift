//
//  FirestoreService.swift
//  HerHack
//
//  Created by JohnC on 8/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation
import Firebase

class FirestoreService {
    
    public static let shared = FirestoreService()
    private var db: Firestore
    
    private init () {
        self.db = Firestore.firestore()
    }
    
    func retrieveData(from collection: String, completion: @escaping ([QueryDocumentSnapshot]) -> ()) {
        self.db.collection(collection).addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Success: \(false); Error: \(err)")
            } else {
                guard let snapshot = querySnapshot else { return }
                completion(snapshot.documents)
            }
        }
    }
    
    func createUser(_ user:User) {
        do {
            let data =  try JSONEncoder().encode(user)
            let newUser = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
            self.db.collection("users").document(UserSettings.uid).setData(newUser)
        } catch {
                print("Success: \(false); Error")
        }
    }
    
    func createCarpool(_ data:Carpool) {
        self.db.collection("carpools").document(data.id!).setData([
            "source": data.source,
            "source_coordinates": GeoPoint(latitude: data.source_coordinates.latitude, longitude: data.source_coordinates.longitude),
            "destination": data.destination,
            "destination_coordinates": GeoPoint(latitude: data.destination_coordinates.latitude, longitude: data.destination_coordinates.longitude),
            "offered_seats": data.offered_seats,
            "created_at": Timestamp(date:data.created_at),
            "start_at": Timestamp(date:data.start_at),
            "end_at": Timestamp(date:data.end_at),
            "user_offer_ride": data.user_offer_ride,
            "users_request_ride": data.users_request_ride,
            "status": data.status,
            "vehicle_id": data.vehicle_id
        ]){ err in
            if let err = err {
                print("Success: \(false); Error: \(err)")
            } else { return }
        }

    }
}
