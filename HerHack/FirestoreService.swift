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

    func retrieveData (from collection:String, document: String? = nil) {
        if let doc = document {
            db.collection(collection).document(doc).getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                } else {
                    print("Document does not exist")
                }
            }
        } else {
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
    }
}
