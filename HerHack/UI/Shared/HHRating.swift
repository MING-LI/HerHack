//
//  HHRating.swift
//  HerHack
//
//  Created by JohnC on 14/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit
import SnapKit

class HHRating: UIStackView {
    var lbl = UILabel()
    var rateStack = UIStackView()
    var rates: [UIButton] = []
    var value: Int?
    
    init(_ frame: CGRect, label: String, rateImage: String, max:Int) {
        super.init(frame:frame)
        self.lbl.text = label
        _ = Array(1...max).map{ Int in
            let rate: UIButton = { rateImage in
                let btn = UIButton()
                let image = UIImage(named: rateImage)
                let unselectedImage = image?.withTintColor(Constants.Colors.PaleYellow)
                btn.setImage(unselectedImage, for: .normal)
                btn.setImage(UIImage(named: "\(rateImage)Selected"), for: .selected)
                btn.imageEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
                btn.addTarget(self, action: #selector(onClick(sender:)), for: .touchUpInside)
                btn.tag = Int
                return btn
            }(rateImage)
            self.rates.append(rate)
        }
        setContentView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rateStyling(_ rate:UIButton) {
        rate.snp.makeConstraints { (make) in
            make.width.height.equalTo(25)
        }
    }
    
    func setContentView() {
        self.axis = .horizontal
        self.addArrangedSubview(lbl)
        self.addArrangedSubview(rateStack)
       
        rateStack.axis = .horizontal
        rateStack.spacing = 10
        rateStack.distribution = .fillEqually
        _ = rates.map { rate in
            rateStack.addArrangedSubview(rate)
            rateStyling(rate)
        }
        
        lbl.snp.makeConstraints { (make) in
            make.height.equalTo(self.snp.height)
            make.leading.equalTo(self.snp.leading)
        }
    }
    
    func setSelected(_ newValue:Int) {
        _ = rates.forEach { btn in
            btn.isSelected = false
        }
        _ = rates.filter({ btn -> Bool in
            btn.tag <= newValue
       }).map { btn in
        btn.isSelected = true
        self.value = btn.tag
       }
    }
    
    @objc func onClick(sender:UIButton){
        setSelected(sender.tag)
    }
}
