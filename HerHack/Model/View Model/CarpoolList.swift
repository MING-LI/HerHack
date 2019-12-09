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
            self.carpools = []
            for carpoolDoc in carpoolDocs {
                let carpool = Carpool(id: carpoolDoc.documentID, dict: carpoolDoc.data())
                self.carpools.append(carpool)
            }
            refreshable.refresh()
        })
    }
}
