//
//  CarpoolList.swift
//  HerHack
//
//  Created by LabLamb on 8/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import SwiftyJSON

class CarpoolList {
    
    var carpools: [Carpool] = []
    
    public func retrieveCarpool(refreshable: DataRefreashable) {
        FirestoreService.shared.retrieveData(from: "carpools", completion: { carpoolDocs in
            for carpoolDoc in carpoolDocs {
                var carpool = Carpool(id: carpoolDoc.documentID, dict: JSON(carpoolDoc.data()))
                self.carpools.append(carpool)
            }
            refreshable.refresh()
        })
    }
    
}
