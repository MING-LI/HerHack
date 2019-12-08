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
        FirebaseApp.configure()
        self.db = Firestore.firestore()
    }
    
    func retrieveData(from collection: String, completion: @escaping ([QueryDocumentSnapshot]) -> ()) {
        self.db.collection(collection).addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let snapshot = querySnapshot else { return }
                completion(snapshot.documents)
            }
        }
    }
    
    func retrieveData(from collection:String, document: String) {
        self.db.collection(collection).document(document).getDocument { (returnedDoc, error) in
            guard let `returnedDoc` = returnedDoc else { return }
            if returnedDoc.exists {
                let dataDescription = returnedDoc.data()
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
}
