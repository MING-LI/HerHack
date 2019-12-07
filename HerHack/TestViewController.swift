//
//  DataPipeline.swift
//  HerHack
//
//  Created by JohnC on 7/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

class TestViewController: UIViewController {

    var testTextView: UITextView!
    
    func postToPipeLine(result: [String:Any] ){
        let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]

        AF.request("https://us-central1-agile-device-260201.cloudfunctions.net/finish-ride-func",
           method: .post,
           parameters: result,
           encoding: JSONEncoding.default,
           headers: headers).responseJSON { response in
            print(response)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let data : [String:Any] = [
            "StartTime":20191202000000,
            "EndTime":20191202010000,
            "Dest":"114.132033,22.3707236",
            "Source":"114.157396,22.3175447",
            "PassengerId":"Karen",
            "DriverId":"Jean",
            "Rating":11,
            "Comment":"Excellent Service"
        ]
        postToPipeLine(result:data)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
