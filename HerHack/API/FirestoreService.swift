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
    
    private var db: Firestore
    
    init () {
        FirebaseApp.configure()
        self.db = Firestore.firestore()
    }
    
    func retrieveData(from collection: String) {
        
        db.collection(collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func retrieveData (from collection:String, document: String) {
        db.collection(collection).document(document).getDocument { (returnedDoc, error) in
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
