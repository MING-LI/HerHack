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
    
   var numPickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    lazy var rateTextField: HHTextField = {
        let txtfld = HHTextField()
        txtfld.placeholder = "Rating"
        txtfld.setIcon(UIImage.init(named: "star")!)
        txtfld.inputView = numPickerView
        txtfld.inputAccessoryView = HHPickerToolbar(delegate: self, textfield: txtfld)
        return txtfld
    }()
    
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
        numPickerView.delegate = delegate as? UIPickerViewDelegate
        commentTextView.delegate = delegate as? UITextViewDelegate
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(rateTextField)
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
        
        rateTextField.snp.remakeConstraints { (make) in
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
    
    @objc func onTextFieldTap(textField: HHTextField) {
        delegate.didClickedTextField(textField)
    }
    
    @objc func afterTextFieldEdit(textField: HHTextField){
        _ = textField.textFieldShouldReturn(textField)
    }
    
    @objc func onTapButton(button: UIButton) {
        let commentTextViewValue:String? = commentTextView.text
        
        guard let comment = commentTextViewValue,
            let ratingText = rateTextField.text,
            let ratingInt = Int(ratingText)
        else { return print("Alert: Please enter the comment") }
        
        
        delegate.didClickedButton(rating: ratingInt, comment: comment)
    }
}

extension PollFormView: HHPickerToolbarDelegate {
    func didTapDone(_ textField: HHTextField) {
        textField.resignFirstResponder()
        textField.text = String(numPickerView.selectedRow(inComponent: 0)+1)
    }
    
    func didTapCancel(_ textField: HHTextField) {
        textField.resignFirstResponder()
        textField.text = ""
    }
}


