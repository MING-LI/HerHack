//
//  LoginFormViewController.swift
//  HerHack
//
//  Created by JohnC on 9/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//
import UIKit
import SnapKit
import Firebase

class LoginFormViewController: UIViewController {

    let hHTabbar: UITabBarController
    
    lazy var loginFormView: LoginFormView = {
        return LoginFormView(delegate: self)
    }()
    
    init() {
        self.hHTabbar = HHTabbar()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .none
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "background")
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        view.addSubview(imageViewBackground)
        view.sendSubviewToBack(imageViewBackground)
        
//        let label = UILabel()
//        label.text = "Free Rider"
//        label.font = UIFont.boldSystemFont(ofSize: 60)
//        label.textColor = Constants.Colors.GreyColor
        
//        view.addSubview(label)
        view.addSubview(loginFormView)
        
        /*label.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
        }*/
        
        loginFormView.translatesAutoresizingMaskIntoConstraints = false
        loginFormView.snp.makeConstraints { (make) in
            make.height.equalTo(300)
            make.bottom.equalToSuperview().offset(-230)
//            make.center.equalTo(view)
            make.leading.trailing.equalTo(view)
        }
    }
}

extension LoginFormViewController: LoginFormViewDelegate {
    func didClickedTextField(_ textField: HHTextField) {
        textField.becomeFirstResponder()
    }
    
    func didClickedButton(name:String, email: String) {
        UserSettings.name = name
        let newUser = User(name: name, email: email)
        Auth.auth().createUser(withEmail: email, password: "testing") { (result, error) in
            UserSettings.uid = result?.user.uid
            FirestoreService.shared.createUser(newUser)
        }
    }
}
