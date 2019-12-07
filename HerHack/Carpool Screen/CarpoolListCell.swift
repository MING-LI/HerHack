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
    
    private let infoArea: UIView
    private let ownerLabel: UILabel
    private let startTimeLabel: UILabel
    private let endTimeLabel: UILabel
    private let sourceLocLabel: UILabel
    private let destLocLabel: UILabel
    
    private let btnArea: UIView
    private let carpoolCountLabel: UILabel
    private let joinBtn: UIButton
    
    private let infoAreaRatio: CGFloat = (2/3)
    private let padding: CGFloat = Constants.MinimumSpacing
    private let infoAreaBgColor: UIColor = Constants.Colors.LightGreyColor
    
    fileprivate func addingSubViews() {
        self.addSubview(self.infoArea)
        self.infoArea.addSubview(self.ownerLabel)
        self.infoArea.addSubview(self.startTimeLabel)
        self.infoArea.addSubview(self.endTimeLabel)
        self.infoArea.addSubview(self.sourceLocLabel)
        self.infoArea.addSubview(self.destLocLabel)
        
        self.addSubview(self.btnArea)
        self.btnArea.addSubview(self.carpoolCountLabel)
        self.btnArea.addSubview(self.joinBtn)
    }
    
    fileprivate func infoAreaStyling() {
        self.infoArea.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(self.padding)
            make.left.equalToSuperview().offset(self.padding)
            make.bottom.equalToSuperview().offset(-self.padding)
            make.width.equalToSuperview().multipliedBy(self.infoAreaRatio)
        })
        
        self.infoArea.backgroundColor = self.infoAreaBgColor
        
        DispatchQueue.main.async {
            self.infoArea.layer.cornerRadius = self.infoArea.frame.height / 12
        }
    }
    
    fileprivate func btnAreaStyling() {
        
        self.btnArea.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(self.padding)
            make.left.equalTo(self.infoArea.snp.right).offset(self.padding)
            make.bottom.equalToSuperview().offset(-self.padding)
            make.right.equalToSuperview().offset(-self.padding)
        })
        
        self.btnArea.backgroundColor = self.infoAreaBgColor
        
        DispatchQueue.main.async {
            self.btnArea.layer.cornerRadius = self.btnArea.frame.height / 12
        }
        
    }
    
    fileprivate func ownerLabelStyling() {
        self.ownerLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(self.padding)
            make.left.equalToSuperview().offset(self.padding)
            make.right.equalToSuperview().offset(-self.padding)
        })
        
        self.ownerLabel.font = Constants.Fonts.BoldFont
    }
    
    fileprivate func startTimeLabelStyling() {
        self.startTimeLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.ownerLabel.snp.bottom).offset(self.padding)
            make.left.equalToSuperview().offset(self.padding)
        })
        
        self.startTimeLabel.font = Constants.Fonts.SemiBold
    }
    
    fileprivate func endTimeLabelStyling() {
        self.endTimeLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.ownerLabel.snp.bottom).offset(self.padding)
            make.right.equalToSuperview().offset(-self.padding)
        })
        
        self.endTimeLabel.font = Constants.Fonts.SemiBold
    }
    
    fileprivate func sourceLabelStyling() {
        self.sourceLocLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.startTimeLabel.snp.bottom).offset(self.padding)
            make.left.equalToSuperview().offset(self.padding)
            make.bottom.equalToSuperview().offset(-self.padding)
        })
        
        self.sourceLocLabel.textColor = Constants.Colors.GreyColor
    }
    
    fileprivate func destLocLabelStyling() {
        self.destLocLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.endTimeLabel.snp.bottom).offset(self.padding)
            make.right.equalToSuperview().offset(-self.padding)
            make.bottom.equalToSuperview().offset(-self.padding)
        })
        
        self.destLocLabel.textColor = Constants.Colors.GreyColor
    }
    
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
        
        self.backgroundColor = .clear
        
        self.addingSubViews()
        self.infoAreaStyling()
        self.btnAreaStyling()
        
        self.ownerLabelStyling()
        
        self.startTimeLabelStyling()
        self.sourceLabelStyling()
        
        self.endTimeLabelStyling()
        self.destLocLabelStyling()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func stringFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func plugData(data: Carpool) {
        self.ownerLabel.text = data.user_offer_ride
        self.startTimeLabel.text = stringFromDate(data.start_at)
        self.endTimeLabel.text = stringFromDate(data.end_at)
        self.sourceLocLabel.text = data.source
        self.destLocLabel.text = data.destination
        self.carpoolCountLabel.text = String(data.users_request_ride.count)
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
