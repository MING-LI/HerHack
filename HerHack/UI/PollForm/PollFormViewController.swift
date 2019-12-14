//
//  PollFormView.swift
//  HerHack
//
//  Created by JohnC on 13/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit
import SnapKit

class PollFormViewController: UIViewController {
    
    let carpool: Carpool
    
    lazy var pollFormView: PollFormView = {
        return PollFormView(delegate: self)
    }()
    
    let numPicker = Array(1...5)
    
    init(carpool: Carpool) {
        self.carpool = carpool
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    var commentFormData = CommentFormData()
    
    func setupViews() {
        view.backgroundColor = .none
        view.addSubview(pollFormView)
        
        pollFormView.translatesAutoresizingMaskIntoConstraints = false
        pollFormView.snp.makeConstraints { (make) in
            make.edges.trailing.equalTo(view)
        }
    }
}

extension PollFormViewController: PollFormViewDelegate {
     
    func didClickedCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    func didClickedButton(rating:Int,comment:String) {
        let newComment = CommentFormData(rating: rating, comment: comment)
        let data = PipelineData(
            StartTime: carpool.start_at.toPipelineFormat(),
            EndTime: carpool.end_at.toPipelineFormat(),
            Dest: carpool.destination_coordinates.toString(),
            Source: carpool.source_coordinates.toString(),
            PassengerId: UserSettings.name ?? "",
            DriverId: carpool.user_offer_ride.user_name,
            Rating: newComment.rating,
            Comment: newComment.comment
        )
//        GoogleService.shared.postToPipeline(data:data, completion:{
//            let alert = UIAlertController(title: "Success", message: "Thanks for your Feedback", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
//                self.dismiss(animated: true, completion: nil)
//            }))
//            self.present(alert, animated: true, completion: nil)
//        })
    }
}

extension PollFormViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        if (textView.text == nil || textView.text == "") {
            textView.text = "Give your feedback"
            textView.textColor = .lightGray
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
