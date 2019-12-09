//
//  LoginFormView.swift
//  HerHack
//
//  Created by JohnC on 9/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit
import SnapKit

class LoginFormView: UIView {
    
    var delegate: LoginFormViewDelegate

    lazy var stackView: UIStackView = {
        let stack = UIStackView(frame: CGRect.zero)
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var nameTextField: HHTextField = {
        let txtfld = HHTextField()
        txtfld.placeholder = "Name"
        txtfld.setIcon(UIImage.init(named: "user")!)
        txtfld.tag = 0
        txtfld.addTarget(self, action: #selector(onTextFieldTap), for: .touchDown)
        return txtfld
    }()

    lazy var emailTextField: HHTextField = {
        let txtfld = HHTextField()
        txtfld.placeholder = "Email"
        txtfld.tag = 1
        txtfld.setIcon(UIImage.init(named: "email")!)
        txtfld.addTarget(self, action: #selector(onTextFieldTap), for: .touchDown)
        return txtfld
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImage.init(named: "center")
        let imgView = UIImageView(image: image)
        return imgView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.backgroundColor = Constants.Colors.Red
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    init(delegate: LoginFormViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupViews()
    }
    
    func setupViews() {
        self.backgroundColor = .none
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(button)
        stackView.distribution = .fillProportionally
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints { (make) in
            make.width.equalTo(250)
            make.height.lessThanOrEqualToSuperview()
            make.center.equalTo(self.snp.center)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(imageView.snp.height)
            make.width.height.equalToSuperview().priority(.high)
        }
        
        button.addTarget(self, action: #selector(onTapButton), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    @objc func onTextFieldTap(textField: HHTextField) {
        delegate.didClickedTextField(textField: textField)
    }
    
    @objc func onTapButton(button: UIButton) {
        if let email = emailTextField.text {
            delegate.didClickedButton(email: email)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
