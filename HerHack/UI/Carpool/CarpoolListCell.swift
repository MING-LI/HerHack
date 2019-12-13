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
    
    var delegate: CarpooListCellDelegate?
    
    private let statusView: UIView
    private let infoArea: UIView
    private let ownerLabel: UILabel
    private let ownerImageView: UIImageView
    private let startTimeLabel: UILabel
    private let endTimeLabel: UILabel
    private let sourceImageView: UIImageView
    private let sourceLocLabel: UILabel
    private let destImageView: UIImageView
    private let destLocLabel: UILabel
    private let dotlineView: UIView
    
    private let btnArea: UIView
    private let carpoolCountLabel: UILabel
    private let joinBtn: UIButton
    private let commentBtn: UIButton
//    private let statusLabel: UILabel
    
    private let infoAreaRatio: CGFloat = (2/3)
    private let cellPadding: CGFloat = Constants.MinimumSpacing
    private let topPadding: CGFloat = Constants.MinimumSpacing + 12
    private let padding: CGFloat = Constants.MinimumSpacing + 5
    private let infoAreaBgColor: UIColor = .white
    private var id: String?
    
    fileprivate func addingSubViews() {
        self.addSubview(self.infoArea)
        self.infoArea.addSubview(self.statusView)
        self.infoArea.addSubview(self.ownerLabel)
        self.infoArea.addSubview(self.ownerImageView)
        self.infoArea.addSubview(self.startTimeLabel)
        self.infoArea.addSubview(self.endTimeLabel)
        self.infoArea.addSubview(self.sourceImageView)
        self.infoArea.addSubview(self.sourceLocLabel)
        self.infoArea.addSubview(self.destImageView)
        self.infoArea.addSubview(self.destLocLabel)
        self.infoArea.addSubview(self.dotlineView)
        
        self.addSubview(self.btnArea)
        self.btnArea.addSubview(self.carpoolCountLabel)
        self.btnArea.addSubview(self.joinBtn)
//        self.btnArea.addSubview(self.statusLabel)
        self.btnArea.addSubview(self.commentBtn)
    }
    
    fileprivate func infoAreaStyling() {
        self.infoArea.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(self.cellPadding)
            make.left.equalToSuperview().offset(self.padding)
            make.bottom.equalToSuperview().offset(-self.cellPadding)
            make.width.equalToSuperview().multipliedBy(self.infoAreaRatio)
        })
        
        self.infoArea.backgroundColor = self.infoAreaBgColor
        
        DispatchQueue.main.async {
            self.infoArea.layer.cornerRadius = self.infoArea.frame.height / 12
        }
    }
    
    func statusViewStyling() {
        self.statusView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(self.topPadding + 5)
            make.width.equalTo(10)
            make.height.equalTo(10)
            make.left.equalTo(self.infoArea.snp.left).offset(self.padding)
//            make.bottom.equalToSuperview().offset(-self.padding)
//            make.right.equalToSuperview().offset(-self.padding)
        })
        
        self.statusView.backgroundColor = UIColor.init(red: 119/255, green: 191/255, blue: 163/255, alpha: 1)
        
        DispatchQueue.main.async {
            self.statusView.layer.cornerRadius = self.statusView.frame.size.width / 2
        }
    }
    
    fileprivate func btnAreaStyling() {
        
        self.btnArea.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(self.cellPadding)
            make.left.equalTo(self.infoArea.snp.right).offset(self.padding - 5)
            make.bottom.equalToSuperview().offset(-self.cellPadding)
            make.right.equalToSuperview().offset(-self.padding)
        })
        
        self.btnArea.backgroundColor = self.infoAreaBgColor
        
        DispatchQueue.main.async {
            self.btnArea.layer.cornerRadius = self.btnArea.frame.height / 12
        }
        
    }
    
    fileprivate func ownerLabelStyling() {
        self.ownerLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(self.topPadding)
            make.left.equalTo(statusView.snp.right).offset(self.padding)
            make.height.equalTo(20)
        })
        
        self.ownerLabel.numberOfLines = 0
        self.ownerLabel.font = Constants.Fonts.BoldFont
        self.ownerLabel.sizeToFit()

    }
    
    fileprivate func ownerImageViewStyling() {
          
        self.ownerImageView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(self.padding - 2)
            make.right.equalTo(infoArea.snp.right).offset(-self.padding)
            make.width.equalTo(40)
            make.height.equalTo(40)
        })
    }
    
    
    fileprivate func sourceImageViewStyling() {
        let image = UIImage(named: "current")
        sourceImageView.image = image
        
        self.sourceImageView.snp.makeConstraints({ make in
            make.top.equalTo(self.ownerLabel.snp.bottom).offset(self.topPadding + 5)
            make.left.equalToSuperview().offset(self.padding)
            make.width.equalTo(10)
            make.height.equalTo(10)
        })
    }
    
    fileprivate func sourceLabelStyling() {
        self.sourceLocLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.ownerLabel.snp.bottom).offset(self.topPadding)
            make.left.equalToSuperview().offset(self.padding + 20)
            make.right.equalToSuperview().offset(-self.padding)
        })
    
        self.sourceLocLabel.font = Constants.Fonts.SemiBold
        self.sourceLocLabel.numberOfLines = 0
    }
    
    fileprivate func startTimeLabelStyling() {
            self.startTimeLabel.snp.makeConstraints({ make in
                make.top.equalTo(self.sourceLocLabel.snp.bottom)
                make.left.equalTo(sourceLocLabel.snp.left)
            })
            self.startTimeLabel.font = UIFont.systemFont(ofSize: 13)
    }
    
    fileprivate func destImageViewStyling() {
        let image = UIImage(named: "location")
        destImageView.image = image
        self.destImageView.snp.makeConstraints({ make in
            make.top.equalTo(startTimeLabel.snp.bottom).offset(self.topPadding + 4)
            make.left.equalToSuperview().offset(self.padding)
            make.width.equalTo(10)
            make.height.equalTo(10)
            
        })
    }
    
    fileprivate func destLocLabelStyling() {
        self.destLocLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.startTimeLabel.snp.bottom).offset(self.topPadding)
            make.left.equalTo(sourceLocLabel.snp.left)
            make.right.equalToSuperview().offset(-self.padding)
        })
        
        self.destLocLabel.font = Constants.Fonts.SemiBold
        self.destLocLabel.numberOfLines = 0
    }
    
    fileprivate func endTimeLabelStyling() {
            self.endTimeLabel.snp.makeConstraints({ make in
                make.top.equalTo(self.destLocLabel.snp.bottom)
                make.left.equalTo(destLocLabel.snp.left)
            })
            
            self.endTimeLabel.font = UIFont.systemFont(ofSize: 14)
    //        self.endTimeLabel.font = Constants.Fonts.SemiBold
        }
    
    
    
    
    
    fileprivate func carpoolCountLabelStyling() {
        self.carpoolCountLabel.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(self.padding * 2)
        })
        
        self.carpoolCountLabel.font = Constants.Fonts.LargeBoldFont
    }
    
    fileprivate func joinBtnStyling() {
        self.joinBtn.snp.makeConstraints({ make in
            make.top.equalTo(self.carpoolCountLabel.snp.bottom).offset(self.padding)
            make.left.equalToSuperview().offset(self.padding)
            make.right.equalToSuperview().offset(-self.padding)
        })
        
        self.joinBtn.titleLabel?.font = Constants.Fonts.SmallFont
        self.joinBtn.setTitle("Join", for: .normal)
        self.joinBtn.backgroundColor = Constants.Colors.Green
        
        DispatchQueue.main.async {
            self.joinBtn.layer.cornerRadius = self.joinBtn.frame.height / 12
        }
    }
    
    fileprivate func commentBtnStyling() {
        self.commentBtn.snp.makeConstraints({ make in
            make.top.equalTo(self.joinBtn.snp.bottom).offset(self.padding)
            make.left.equalToSuperview().offset(self.padding)
            make.right.bottom.equalToSuperview().offset(-self.padding)
        })
        
        self.commentBtn.titleLabel?.font = Constants.Fonts.SmallFont
        self.commentBtn.setTitle("Comment", for: .normal)
        self.commentBtn.backgroundColor = Constants.Colors.Blue
        
        DispatchQueue.main.async {
            self.commentBtn.layer.cornerRadius = self.joinBtn.frame.height / 12
        }
    }
    
//    fileprivate func statusLabelStyling() {
//        self.statusLabel.snp.makeConstraints({ make in
//            make.top.equalToSuperview().offset(self.padding)
//            make.left.equalToSuperview().offset(self.padding)
//            make.right.equalToSuperview().offset(-self.padding)
//            make.bottom.equalTo(self.carpoolCountLabel.snp.top).offset(-self.padding)
//        })
//
//        self.carpoolCountLabel.font = Constants.Fonts.LargeBoldFont
//    }
    
    fileprivate func dotlineViewStyling() {
//        dotlineView.frame = CGRect(x: 15 , y: 100, width: 20, height: 400)
        drawDottedLine(start: CGPoint(x: 16, y: 70), end: CGPoint(x: 16, y: 113), view: dotlineView)

    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.statusView = UIView()
        self.infoArea = UIView()
        self.ownerLabel = UILabel()
        self.ownerImageView = UIImageView()
        self.startTimeLabel = UILabel()
        self.endTimeLabel = UILabel()
        self.sourceLocLabel = UILabel()
        self.sourceImageView = UIImageView()
        self.destImageView = UIImageView()
        self.destLocLabel = UILabel()
//        self.statusLabel = UILabel()
        self.dotlineView = UIView()
        
        self.btnArea = UIView()
        self.carpoolCountLabel = UILabel()
        self.joinBtn = UIButton()
        self.commentBtn = UIButton()
        
        self.id = nil
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = Constants.Colors.PaleGreyColor
        
        self.addingSubViews()
        
        self.statusViewStyling()
        self.infoAreaStyling()
        self.btnAreaStyling()
        
        self.ownerLabelStyling()
        self.ownerImageViewStyling()
        
        self.startTimeLabelStyling()
        self.sourceLabelStyling()
        
        self.endTimeLabelStyling()
        self.destLocLabelStyling()
        
        self.sourceImageViewStyling()
        self.destImageViewStyling()
        
        self.carpoolCountLabelStyling()
        self.joinBtnStyling()
        self.commentBtnStyling()
//        self.statusLabelStyling()
        
        self.dotlineViewStyling()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func plugData(data: Carpool) {
        self.id = data.id
        self.ownerLabel.text = data.user_offer_ride.user_name
        
        print(data.user_offer_ride.user_name.lowercased())
        
        let image = UIImage(named: data.user_offer_ride.user_name.lowercased())
        self.ownerImageView.image = image
        
        self.startTimeLabel.text = data.start_at.toString(format: "HH:mm a")
        self.endTimeLabel.text = data.end_at.toString(format: "HH:mm a")
        self.sourceLocLabel.text = data.source
        self.destLocLabel.text = data.destination
        self.carpoolCountLabel.text = "👤\(data.users_request_ride.count)/\(data.offered_seats)"
        self.joinBtn.isEnabled = data.status == .OPEN
        self.joinBtn.alpha = data.status == .OPEN ? 1 : (1/3)
        self.joinBtn.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
        self.statusView.backgroundColor = {
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
    }
    
    @objc func onTapButton(){
        guard let id = self.id else { return }
        FirestoreService.shared.joinCarpool(id)
    }
    
    @objc func onTapComment(){
        delegate?.didClickedComment()
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
}
