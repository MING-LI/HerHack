//
//  OfferFormView.swift
//  HerHack
//
//  Created by Mimosa Poon on 8/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit
import GooglePlaces

class OfferFormView: UIView {

    var delegate: OfferFormViewDelegate
    var wayPointStackId = 2
    
    
    var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.timeZone = NSTimeZone.local
        picker.datePickerMode = .dateAndTime
        return picker
    }()
    
    var numPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(frame: CGRect.zero)
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var addWayPointBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Add way point", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel!.font = Constants.Fonts.RegularFont
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        button.addTarget(self, action: #selector(onAddWayPointTap), for: .touchDown)
        if let image = UIImage(named: "add.png") {
            
            button.setImage(image, for: .normal)
        }
        return button
    }()
    
    
    lazy var sourceTextField: HHTextField = {
        let txtfld = HHTextField()
        txtfld.text = "Source"
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
    
    lazy var seatTextField: HHTextField = {
        let txtfld = HHTextField()
        txtfld.text = "Seats Available"
        txtfld.setIcon(UIImage.init(named: "user")!)
        txtfld.inputView = numPicker
        txtfld.inputAccessoryView = HHPickerToolbar(delegate: self, textfield: txtfld)
        return txtfld
    }()
    

    lazy var departureTextField: HHTextField = {
        let txtfld = HHTextField()
        txtfld.text = "Departure Time"
        txtfld.setIcon(UIImage.init(named: "clock")!)
        txtfld.inputView = timePicker
        txtfld.inputAccessoryView = HHPickerToolbar(delegate: self, textfield: txtfld)
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
    
    init(delegate: OfferFormViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        numPicker.delegate = delegate as? UIPickerViewDelegate
        numPicker.dataSource = delegate as? UIPickerViewDataSource
        setupViews()
    }
    
    func setupViews() {
        self.backgroundColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(onTapContinue), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(sourceTextField)
        stackView.addArrangedSubview(addWayPointBtn)
        stackView.addArrangedSubview(destTextField)
        stackView.addArrangedSubview(seatTextField)
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
    
    func addWayPointField() {
        let wayPointTextField: HHTextField = {
            let txtfld = HHTextField()
            txtfld.text = "Way Point"
            txtfld.setIcon(UIImage.init(named: "current")!)
            txtfld.tag = 2
            txtfld.addTarget(self, action: #selector(onTextFieldTap), for: .touchDown)
            return txtfld
        }()
        stackView.insertArrangedSubview(wayPointTextField, at: wayPointStackId)
    }
    
    @objc func onTextFieldTap(textField: HHTextField) {
        textField.resignFirstResponder()
        if textField != seatTextField {
            delegate.didClickedTextField(textField: textField)
        } else { return }
    }
    
    @objc func onTapContinue(button: UIButton) {
        delegate.didClickedContinue(departure: timePicker.date)
    }
    
    @objc func onAddWayPointTap(button: UIButton) {
        self.addWayPointField()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension OfferFormView: HHPickerToolbarDelegate {
    func didTapDone(_ textField: HHTextField) {
        textField.resignFirstResponder()
        switch textField {
            case departureTextField:
                departureTextField.text = timePicker.date.toString(format: "yyyy-MM-dd HH:mm")
            case seatTextField:
                textField.text = String(numPicker.selectedRow(inComponent: 0)+1)
                delegate.didSelectedSeat(textFieldText: textField.text ?? "0")
            default: return
        }
    }

    func didTapCancel(_ textField: HHTextField) {
        textField.resignFirstResponder()
        textField.text = ""
    }
}
