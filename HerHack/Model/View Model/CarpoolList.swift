//
//  CarpoolList.swift
//  HerHack
//
//  Created by LabLamb on 8/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import SwiftyJSON

struct CarpoolList {
    
    var carpools: [Carpool] = []
    
    public func retrieveCarpool(refreshable: DataRefreashable) {
        FirestoreService.shared.retrieveData(from: "carpools", completion: { allCarpools in
            for carpool in allCarpools {
                // TODO: John's show time
            }
            
            refreshable.refresh()
        })
    }
    
}
