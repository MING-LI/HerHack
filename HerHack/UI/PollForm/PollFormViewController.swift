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
    lazy var pollFormView: PollFormView = {
        return PollFormView(delegate: self)
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    let numPicker = Array(1...5)
    var commentFormData = CommentFormData()
    
    func setupViews() {
        view.backgroundColor = .none
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "background")
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        view.addSubview(imageViewBackground)
        view.sendSubviewToBack(imageViewBackground)
        
        view.addSubview(pollFormView)
        
        pollFormView.translatesAutoresizingMaskIntoConstraints = false
        pollFormView.snp.makeConstraints { (make) in
            make.edges.trailing.equalTo(view)
        }
    }
}

extension PollFormViewController: PollFormViewDelegate {
    func didClickedTextField(_ textField: HHTextField) {
        textField.becomeFirstResponder()
    }
    
    func didClickedButton(rating:Int,comment:String) {
        let newComment = CommentFormData(rating: rating, comment: comment)
//        FirestoreService.shared.createUser(newUser)
    }
}

extension PollFormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numPicker.count
    }
    
    func pickerView(_pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        commentFormData.rating = numPicker[row]
        return
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(numPicker[row])
    }
}

