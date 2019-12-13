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
        db.collection(collection).addSnapshotListener { (querySnapshot, err) in
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
            db.collection("users").document(UserSettings.uid).setData(newUser)
        } catch {
                print("Success: \(false); Error")
        }
    }
    
    func retrieveUserBy(_ id:String, completion: @escaping (User)->() ) {
        let user = db.collection("users").document(id)
        user.getDocument { (document, error) in
            if error != nil {
                 print("Document does not exist")
            } else {
                guard let doc = document else { return }
                let data = doc.data() as! [String:String]
                let user = User(name: data["name"]!, email: data["email"]!)
                return completion(user)
            }
        }
    }
    
    func joinCarpool(_ id:String) {
        let carpoolUser = CarpoolUser(user_id: UserSettings.uid, user_name: UserSettings.name, is_accepted: false).dictionary
        db.collection("carpools").document(id).updateData([
            "users_request_ride": FieldValue.arrayUnion([carpoolUser as Any])
        ]) { err in
            if let err = err {
                print("Error joining carpool: \(err)")
            } else { return }
        }
    }
    
    func quitCarpool(_ id:String, completion: @escaping ()->()) {
        let carpoolUser = CarpoolUser(user_id: UserSettings.uid, user_name: UserSettings.name, is_accepted: nil).dictionary
        db.collection("carpools").document(id).updateData([
            "users_request_ride": FieldValue.arrayRemove([carpoolUser as Any])
        ]) { err in
            if let err = err {
                print("Error quitting carpool: \(err)")
            } else { completion() }
        }
    }
    
    func createCarpool(_ data:Carpool, completion:@escaping ()->()) {
        var ref: DocumentReference? = nil
        let data:[String:Any] = [
            "source": data.source,
            "source_coordinates": GeoPoint(latitude: data.source_coordinates.latitude, longitude: data.source_coordinates.longitude),
            "destination": data.destination,
            "destination_coordinates": GeoPoint(latitude: data.destination_coordinates.latitude, longitude: data.destination_coordinates.longitude),
            "offered_seats": data.offered_seats,
            "created_at": Timestamp(date:data.created_at),
            "start_at": Timestamp(date:data.start_at),
            "end_at": Timestamp(date:data.end_at),
            "user_offer_ride": data.user_offer_ride.dictionary,
            "users_request_ride": [],
            "status": "OPEN"
        ]
        ref = db.collection("carpools").addDocument(data:data){ err in
            if let err = err {
                print("Error creating carpool (\(ref!.documentID)): \(err)")
            } else { completion() }
        }
    }
}
