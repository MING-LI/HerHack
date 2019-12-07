//
//  CarpoolListCell.swift
//  HerHack
//
//  Created by LabLamb on 6/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit
import SnapKit

class CarpoolListCell: UITableViewCell {
    
    let infoArea: UIView
    let ownerLabel: UILabel
    let startTimeLabel: UILabel
    let endTimeLabel: UILabel
    let sourceLocLabel: UILabel
    let destLocLabel: UILabel
    
    let btnArea: UIView
    let carpoolCountLabel: UILabel
    let joinBtn: UIButton
    
    private let infoAreaRatio: CGFloat = 0.75
    private let padding: CGFloat = 2.5
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.infoArea = UIView()
        self.ownerLabel = UILabel()
        self.startTimeLabel = UILabel()
        self.endTimeLabel = UILabel()
        self.sourceLocLabel = UILabel()
        self.destLocLabel = UILabel()
        
        self.btnArea = UIView()
        self.carpoolCountLabel = UILabel()
        self.joinBtn = UIButton()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.infoArea)
        self.infoArea.addSubview(self.ownerLabel)
        self.infoArea.addSubview(self.startTimeLabel)
        self.infoArea.addSubview(self.endTimeLabel)
        self.infoArea.addSubview(self.sourceLocLabel)
        self.infoArea.addSubview(self.destLocLabel)
        
        self.addSubview(self.btnArea)
        self.btnArea.addSubview(self.carpoolCountLabel)
        self.btnArea.addSubview(self.joinBtn)
        
        self.infoArea.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(self.padding)
            make.left.equalToSuperview().offset(self.padding)
            make.bottom.equalToSuperview().offset(-self.padding)
            make.width.equalToSuperview().multipliedBy(self.infoAreaRatio)
        })
        
        self.btnArea.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(self.padding)
            make.left.equalTo(self.infoArea).offset(self.padding)
            make.bottom.equalToSuperview().offset(-self.padding)
            make.right.equalToSuperview().offset(-self.padding)
        })
        
        self.ownerLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(self.padding)
            make.left.equalToSuperview().offset(self.padding)
            make.right.equalToSuperview().offset(-self.padding)
        })
        
        self.startTimeLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.ownerLabel).offset(self.padding * 2)
            make.left.equalToSuperview().offset(self.padding)
        })
        
        self.sourceLocLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.startTimeLabel).offset(self.padding)
            make.left.equalToSuperview().offset(self.padding)
            make.bottom.equalToSuperview().offset(-self.padding)
        })
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func plugData(data: Carpool) {
        self.ownerLabel.text = data.owner
        self.startTimeLabel.text = String(data.startTime)
        self.endTimeLabel.text = String(data.endTime)
        self.sourceLocLabel.text = data.source
        self.destLocLabel.text = data.dest
        self.carpoolCountLabel.text = String(data.passengers.count)
    }
    
    override func prepareForReuse() {
        self.ownerLabel.text = nil
        self.startTimeLabel.text = nil
        self.endTimeLabel.text = nil
        self.sourceLocLabel.text = nil
        self.destLocLabel.text = nil
        self.carpoolCountLabel.text = nil
    }
    
}
