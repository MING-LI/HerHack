//
//  SearchRouteView.swift
//  HerHack
//
//  Created by Mimosa Poon on 7/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit

protocol SearchRouteViewProtocol {
    func didClickedTextField(textField: HHTextField)
    func didClickedSearch()
}

class SearchRouteView: UIView {
    
    var delegate: SearchRouteViewProtocol
    
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
    
    lazy var button: UIButton = {
        let button = UIButton()
        
        button.setTitle("Search", for: .normal)
        button.backgroundColor = Constants.Colors.Red
        return button
    }()
    
<<<<<<< HEAD:HerHack/MapScreen/views/SearchRouteView.swift
    init(delegate: SearchRouteViewProtocol) {
=======
    init(delegate: HHTextFieldDelegate) {
>>>>>>> 6876c8efb9eed66c749db2792fa86cfc95b195e2:HerHack/UI/MapScreen/SearchRouteView.swift
        self.delegate = delegate
        super.init(frame: .zero)
        setupViews()
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
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.AppMargin),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.AppMargin),
            self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func onTextFieldTap(textField: HHTextField) {
        textField.resignFirstResponder()
        delegate.didClickedTextField(textField: textField)
    }
    
    @objc func onTapSearch(button: UIButton) {
        delegate.didClickedSearch()
    }
}

