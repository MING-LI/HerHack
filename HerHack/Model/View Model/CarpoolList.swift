//
//  CarpoolList.swift
//  HerHack
//
//  Created by LabLamb on 8/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

class CarpoolList {
    
    var carpools: [Carpool] = []
    
    public func retrieveCarpool(refreshable: DataRefreashable) {
        FirestoreService.shared.retrieveData(from: "carpools", completion: { carpoolDocs in
            for carpoolDoc in carpoolDocs {
                var carpool = Carpool(dict: carpoolDoc.data())
                carpool.id = carpoolDoc.documentID
                print(carpool)
                self.carpools.append(carpool)
            }
            refreshable.refresh()
        })
    }
    
}
