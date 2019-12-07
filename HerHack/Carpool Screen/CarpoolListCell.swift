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
    private let statusLabel: UILabel
    
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
        self.btnArea.addSubview(self.statusLabel)
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
        
//        self.sourceLocLabel.textColor = Constants.Colors.GreyColor
    }
    
    fileprivate func destLocLabelStyling() {
        self.destLocLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.endTimeLabel.snp.bottom).offset(self.padding)
            make.right.equalToSuperview().offset(-self.padding)
            make.bottom.equalToSuperview().offset(-self.padding)
        })
        
//        self.destLocLabel.textColor = Constants.Colors.GreyColor
    }
    
    fileprivate func carpoolCountLabelStyling() {
        self.carpoolCountLabel.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        })
        
        self.carpoolCountLabel.font = Constants.Fonts.LargeBoldFont
    }
    
    fileprivate func joinBtnStyling() {
        self.joinBtn.snp.makeConstraints({ make in
            make.top.equalTo(self.carpoolCountLabel.snp.bottom).offset(self.padding)
            make.left.equalToSuperview().offset(self.padding)
            make.right.bottom.equalToSuperview().offset(-self.padding)
        })
        
        self.joinBtn.titleLabel?.font = Constants.Fonts.SmallFont
        self.joinBtn.setTitleColor(.black, for: .normal)
        self.joinBtn.setTitle("Join", for: .normal)
    }
    
    fileprivate func statusLabelStyling() {
        self.statusLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(self.padding)
            make.left.equalToSuperview().offset(self.padding)
            make.right.equalToSuperview().offset(-self.padding)
            make.bottom.equalTo(self.carpoolCountLabel.snp.top).offset(-self.padding)
        })
        
        self.carpoolCountLabel.font = Constants.Fonts.LargeBoldFont
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.infoArea = UIView()
        self.ownerLabel = UILabel()
        self.startTimeLabel = UILabel()
        self.endTimeLabel = UILabel()
        self.sourceLocLabel = UILabel()
        self.destLocLabel = UILabel()
        self.statusLabel = UILabel()
        
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
        
        self.carpoolCountLabelStyling()
        self.joinBtnStyling()
        self.statusLabelStyling()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func plugData(data: Carpool) {
        self.ownerLabel.text = data.user_offer_ride
        self.startTimeLabel.text = data.start_at.toString(format: "HH:mm")
        self.endTimeLabel.text = data.end_at.toString(format: "HH:mm")
        self.sourceLocLabel.text = data.source
        self.destLocLabel.text = data.destination
        self.carpoolCountLabel.text = "\(data.users_request_ride.count)/\(data.offered_seats)"
        self.joinBtn.isEnabled = data.status == .OPEN
        self.statusLabel.text = {
            switch (data.status) {
            case .OPEN:
                return "Open"
            case .FULL:
                return "Full"
            case .ENDED:
                return "Ended"
            }
        }()
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
