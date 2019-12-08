//
//  OfferFormView.swift
//  HerHack
//
//  Created by Mimosa Poon on 8/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit
import GooglePlaces

protocol OfferFormViewProtocol {
    func didClickedTextField(textField: HHTextField)
    func didClickedContinue(departure: String)
}

class OfferFormView: UIView {
    
    var delegate: OfferFormViewProtocol
    
    var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.timeZone = NSTimeZone.local
        picker.datePickerMode = .dateAndTime
        return picker
    }()

    lazy var stackView: UIStackView = {
        let stack = UIStackView(frame: CGRect.zero)
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var sourceTextField: HHTextField = {
        let txtfld = HHTextField()
        txtfld.setIcon(UIImage.init(named: "current")!)
        txtfld.tag = 0
        txtfld.addTarget(self, action: #selector(onTextFieldTap), for: .touchDown)
        return txtfld
    }()

    lazy var destTextField: HHTextField = {
        let txtfld = HHTextField()
        txtfld.text = "Destination"
        txtfld.tag = 1
        txtfld.setIcon(UIImage.init(named: "location")!)
        txtfld.addTarget(self, action: #selector(onTextFieldTap), for: .touchDown)
        return txtfld
    }()
    
    lazy var pickerToolbar: HHPickerToolbar = {
        let toolbar = HHPickerToolbar()
        toolbar.toolbarDelegate = self
        return toolbar
    }()
    
    lazy var departureTextField: HHTextField = {
        let txtfld = HHTextField()
        txtfld.text = "Departure Time"
        txtfld.setIcon(UIImage.init(named: "clock")!)
        txtfld.inputView = timePicker
        txtfld.inputAccessoryView = pickerToolbar
        return txtfld
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = Constants.Colors.Red
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    init(delegate: OfferFormViewProtocol) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupViews()
    }
    
    func setupViews() {
        self.backgroundColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(onTapContinue), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(sourceTextField)
        stackView.addArrangedSubview(destTextField)
        stackView.addArrangedSubview(departureTextField)
        stackView.addArrangedSubview(button)
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.AppMargin),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.AppMargin),
            self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20)
        ])
    }
    
    func disableSearchBtn() {
        button.isEnabled = false
        button.alpha = 0.5;
    }
    
    @objc func onTextFieldTap(textField: HHTextField) {
        textField.resignFirstResponder()
        delegate.didClickedTextField(textField: textField)
        
    }
    
    @objc func onTapContinue(button: UIButton) {
        if let departure = departureTextField.text {
            delegate.didClickedContinue(departure: departure)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension OfferFormView: HHPickerToolbarProtocol {
    func didTapDone() {
        departureTextField.resignFirstResponder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        departureTextField.text = formatter.string(from: timePicker.date)
    }

    func didTapCancel() {
        departureTextField.resignFirstResponder()
        departureTextField.text = ""
    }
}




