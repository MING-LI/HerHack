//
//  SearchRouteView.swift
//  HerHack
//
//  Created by Mimosa Poon on 7/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit


protocol HHTextFieldProtocol :class{
    func didClickedTextField(textField: HHTextField)
}

class SearchRouteView: UIView {
    
    var delegate: HHTextFieldProtocol?
    
    var stackView: UIStackView = {
        let stack = UIStackView(frame: CGRect.zero)
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    var sourceTextField: HHTextField = {
        let txtfld = HHTextField()
        txtfld.setIcon(UIImage.init(named: "current")!)
        txtfld.addTarget(self, action: #selector(onTextFieldTap), for: .touchDown)
        return txtfld
    }()

    var destTextField: HHTextField = {
        let txtfld = HHTextField()
        txtfld.text = "Destination"
        txtfld.setIcon(UIImage.init(named: "location")!)
        txtfld.addTarget(self, action: #selector(onTextFieldTap), for: .touchDown)
        return txtfld
    }()
    
    var button: UIButton = {
        let button = UIButton()
        
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = .blue
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(onTapSearch), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(sourceTextField)
        stackView.addArrangedSubview(destTextField)
        stackView.addArrangedSubview(button)
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.appMargin),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.appMargin),
            self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func onTextFieldTap(textField: HHTextField) {
        textField.resignFirstResponder()
        delegate?.didClickedTextField(textField: textField)
    }
    
    @objc func onTapSearch(button: UIButton) {
        print("search")
//        fetchRoute()
    }
}

