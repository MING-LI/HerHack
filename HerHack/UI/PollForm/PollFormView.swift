//
//  PollFormView.swift
//  HerHack
//
//  Created by JohnC on 13/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit
import SnapKit

class PollFormView: UIView {
    
   var delegate: PollFormViewDelegate
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(frame: CGRect.zero)
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    var popUpBgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Comment"
        lbl.font = Constants.Fonts.LargeBoldFont
        return lbl
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"cancel"), for: .normal)
        button.addTarget(self, action: #selector(onClickCancel), for: .touchUpInside)
        return button
    }()
    
    let rating = HHRating(.zero, label: "Rating", rateImage: "star", max: 5)
    
    var commentTextView: UITextView = {
        let txtfld = UITextView()
        txtfld.text = "Give your feedback"
        txtfld.textColor = .lightGray
        txtfld.layer.borderWidth = 1.0
        txtfld.layer.cornerRadius = 5
        txtfld.layer.borderColor = UIColor.lightGray.cgColor
        return txtfld
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = Constants.Colors.Red
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    init(delegate: PollFormViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        commentTextView.delegate = delegate as? UITextViewDelegate
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(rating)
        stackView.addArrangedSubview(commentTextView)
        stackView.addArrangedSubview(button)
        stackView.distribution = .equalCentering
        self.addSubview(popUpBgView)
        popUpBgView.addSubview(cancelButton)
        popUpBgView.addSubview(stackView)
        
        popUpBgView.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.center.equalTo(self)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(popUpBgView.snp.top).offset(10)
            make.trailing.equalTo(popUpBgView.snp.trailing).inset(10)
            make.width.height.equalTo(25)
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(popUpBgView.snp.edges).inset(20)
        }
        
        rating.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.bottom.equalTo(commentTextView.snp.top).offset(-20)
        }
        
        commentTextView.snp.makeConstraints { (make) in
            make.width.equalTo(self.stackView)
            make.height.equalTo(200)
        }
        
        button.snp.makeConstraints { (make) in
            make.height.equalTo(44)
        }
        
        button.addTarget(self, action: #selector(onTapButton), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func onClickCancel(){
        delegate.didClickedCancel()
    }
    
    @objc func onTapButton(button: UIButton) {
        guard let ratingInt = rating.value else {
            return print("Alert: Please select rating")
        }
        guard let comment = commentTextView.text else {
            return print("Alert: Please enter the comment")
        }
        delegate.didClickedButton(rating: ratingInt, comment: comment)
    }
}
