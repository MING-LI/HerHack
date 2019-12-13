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
    
    var label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Comment"
        lbl.font = Constants.Fonts.LargeBoldFont
        return lbl
    }()
    
    var commentlabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Comment"
        lbl.font = Constants.Fonts.RegularFont
        return lbl
    }()
    
    var numPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    lazy var rateTextField: HHTextField = {
        let txtfld = HHTextField()
        txtfld.placeholder = "Rating"
        txtfld.setIcon(UIImage.init(named: "star")!)
        txtfld.inputView = numPicker
        txtfld.inputAccessoryView = HHPickerToolbar(delegate: self, textfield: txtfld)
        return txtfld
    }()
    
    var commentTextView: UITextView = {
        let txtfld = UITextView()
//        txtfld.placeholder = "Give your feedback"
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
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(rateTextField)
        stackView.addArrangedSubview(commentlabel)
        stackView.addArrangedSubview(commentTextView)
        stackView.addArrangedSubview(button)
        stackView.distribution = .equalCentering
        self.addSubview(popUpBgView)
        popUpBgView.addSubview(stackView)
        
        popUpBgView.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.height.equalTo(600)
            make.center.equalTo(self)
        }
    
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.popUpBgView).offset(20)
            make.leading.equalTo(self.popUpBgView).offset(20)
            make.trailing.equalTo(self.popUpBgView).offset(-20)
            make.bottom.equalTo(self.popUpBgView).inset(20)
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
    
    
    @objc func onTextFieldTap(textField: HHTextField) {
        delegate.didClickedTextField(textField)
    }
    
    @objc func afterTextFieldEdit(textField: HHTextField){
        textField.textFieldShouldReturn(textField)
    }
    
    @objc func onTapButton(button: UIButton) {
        let commentTextViewValue:String? = commentTextView.text
        guard let comment = commentTextViewValue else { return print("Alert: Please enter the comment") }
//        delegate.didClickedButton(rating: rateTextField.text comment: comment)
    }
}

extension PollFormView: HHPickerToolbarDelegate {
    func didTapDone(_ textField: HHTextField) {
        textField.resignFirstResponder()
        textField.text = String(numPicker.selectedRow(inComponent: 0)+1)
    }

    func didTapCancel(_ textField: HHTextField) {
        textField.resignFirstResponder()
        textField.text = ""
    }
}

extension PollFormView: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        if textView.text == nil {
//            textView.text = textView.placeholder
            textView.textColor = .lightGray
        }
    }
}

//extension UITextView {
//    var placeholder: String! {
//        get {
//            return self.placeholder
//        }
//        set{
//            if let value = newValue {
//                self.placeholder = value
//            }
//        }
//    }
//}
