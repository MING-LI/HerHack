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
    
    private let arrowLabel: UILabel
    
    private let infoAreaRatio: CGFloat = (2/3)
    private let padding: CGFloat = Constants.MinimumSpacing
    private let infoAreaBgColor: UIColor = .white
    private var id: String?
    
    fileprivate func addingSubViews() {
        self.addSubview(self.infoArea)
        self.infoArea.addSubview(self.ownerLabel)
        self.infoArea.addSubview(self.startTimeLabel)
        self.infoArea.addSubview(self.endTimeLabel)
        self.infoArea.addSubview(self.sourceLocLabel)
        self.infoArea.addSubview(self.destLocLabel)
        self.infoArea.addSubview(self.arrowLabel)
        
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
            make.top.equalTo(self.ownerLabel.snp.bottom).offset(self.padding * 2)
            make.left.equalToSuperview().offset(self.padding)
        })
        
        self.startTimeLabel.font = Constants.Fonts.SemiBold
    }
    
    fileprivate func endTimeLabelStyling() {
        self.endTimeLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.ownerLabel.snp.bottom).offset(self.padding * 2)
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
    }
    
    fileprivate func destLocLabelStyling() {
        self.destLocLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.endTimeLabel.snp.bottom).offset(self.padding)
            make.right.equalToSuperview().offset(-self.padding)
            make.bottom.equalToSuperview().offset(-self.padding)
        })
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
        self.joinBtn.setTitle("Join", for: .normal)
        self.joinBtn.backgroundColor = Constants.Colors.Green
        
        DispatchQueue.main.async {
            self.joinBtn.layer.cornerRadius = self.joinBtn.frame.height / 12
        }
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
    
    fileprivate func arrowLabelStyling() {
        self.arrowLabel.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-self.padding)
            make.centerX.equalToSuperview()
        })
        
        self.arrowLabel.text = "⟶"
        self.arrowLabel.font = Constants.Fonts.LargeBoldFont
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
        
        self.arrowLabel = UILabel()
        self.id = nil
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = Constants.Colors.PaleGreyColor
        
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
        
        self.arrowLabelStyling()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func plugData(data: Carpool) {
        self.id = data.id
        self.ownerLabel.text = data.user_offer_ride.user_name
        self.startTimeLabel.text = data.start_at.toString(format: "HH:mm a")
        self.endTimeLabel.text = data.end_at.toString(format: "HH:mm a")
        self.sourceLocLabel.text = data.source
        self.destLocLabel.text = data.destination
        self.carpoolCountLabel.text = "\(data.users_request_ride.count)/\(data.offered_seats)"
        self.joinBtn.isEnabled = data.status == .OPEN
        self.joinBtn.alpha = data.status == .OPEN ? 1 : (1/3)
        self.joinBtn.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
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
        self.statusLabel.textColor = {
                   switch (data.status) {
                   case .OPEN:
                    return Constants.Colors.Green
                   case .FULL:
                    return Constants.Colors.Red
                   case .ENDED:
                    return Constants.Colors.GreyColor
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
        self.joinBtn.isEnabled = true
        self.joinBtn.alpha = 1
        self.statusLabel.text = nil
        self.statusLabel.textColor = .black
    }
    
    @objc func onTapButton(){
        guard let id = self.id else { return }
        FirestoreService.shared.joinCarpool(id)
    }
}
