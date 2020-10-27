//
//  TransHistoryTableViewCell.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/26.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit
import secux_paymentkit_v2

class TransHistoryTableViewCell: UITableViewCell {
    
    lazy var bkView: UIView = {
        let bkview = UIView()
        bkview.translatesAutoresizingMaskIntoConstraints = false
        bkview.backgroundColor = .white
        
        bkview.layer.cornerRadius = 10
        /*
        bkview.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        bkview.layer.shadowOffset = CGSize(width: 1, height: 1)
        bkview.layer.shadowOpacity = 0.2
        bkview.layer.shadowRadius = 15
        */
        bkview.layer.shadowColor = UIColor.darkGray.cgColor
        //bkview.layer.shadowPath = UIBezierPath(roundedRect: bkview.bounds, cornerRadius: 10).cgPath
        bkview.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        bkview.layer.shadowOpacity = 0.4
        bkview.layer.shadowRadius = 3.0
        
        //bkview.layer.borderColor = UIColor(red: 0.62, green: 0.62, blue: 0.62,alpha:1).cgColor
        //bkview.layer.borderWidth = 0.2
        
        self.contentView.addSubview(bkview)
        
        NSLayoutConstraint.activate([
            
            bkview.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 3),
            bkview.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -3),
            bkview.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            bkview.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6)
            
        ])
        
        return bkview
    }()
    
    lazy var typeImg: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(named: "btc")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)
        
        return imageView
    }()
       
    lazy var typeLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sent" //"\(row+1)"

        //label.font = UIFont.preferredFont(forTextStyle: .headline)
        //label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 16)
        label.textColor = UIColor(red: 0x55/255, green: 0x54/255, blue: 0x54/255, alpha: 1)
        label.textAlignment = NSTextAlignment.left

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()


        self.contentView.addSubview(label)
        return label
    }()

    lazy var itemValLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""

        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 16)
        label.textColor = UISetting.shared.purpleColor//UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.left

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.contentView.addSubview(label)

        return label
    }()
    
    lazy var itemUsdValLabel : UILabel = {
        let label = UILabel()
       
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""

        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 16)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.contentView.addSubview(label)

        return label
    }()
    
    lazy var timestampLabel : UILabel = {
        let label = UILabel()
       
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""

        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 12)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.contentView.addSubview(label)

        return label
    }()
    
    
    func setup(history: SecuXTransferHistory){
        
        self.contentView.backgroundColor = UISetting.shared.vcBKColor
        self.backgroundColor = UISetting.shared.vcBKColor
        var _ = self.bkView
        
        
        if history.txType == "Receive" || history.txType == "receive"{
            self.typeLabel.text = "Received"
            
            self.typeLabel.textColor = UIColor(red: 0.92, green: 0.8, blue: 0.34,alpha:1)
            self.typeImg.image = UIImage(named: "icon_receive")
            self.itemUsdValLabel.text = "+$\(history.usdAmount) USD"
            self.itemValLabel.text = "+\(history.formattedAmount) \(history.token)"
        }else{
            self.typeLabel.text = "Sent"
            self.typeLabel.textColor = UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1)
            self.typeImg.image = UIImage(named: "icon_send")
            self.itemUsdValLabel.text = "-$\(history.usdAmount) USD"
            self.itemValLabel.text = "-\(history.formattedAmount) \(history.token)"
        }
        
        self.timestampLabel.text = history.timestamp

        self.itemUsdValLabel.isHidden = true
        NSLayoutConstraint.activate([
            
            self.typeImg.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 17),
            self.typeImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            
            self.typeLabel.leftAnchor.constraint(equalTo: typeImg.rightAnchor, constant: 10),
            self.typeLabel.centerYAnchor.constraint(equalTo: typeImg.centerYAnchor),
            
            //self.itemUsdValLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            //self.itemUsdValLabel.centerYAnchor.constraint(equalTo: typeImg.centerYAnchor),
            //self.itemUsdValLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 19),
            
            
            self.timestampLabel.leftAnchor.constraint(equalTo: typeImg.leftAnchor, constant: 0),
            self.timestampLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            
            self.itemValLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            self.itemValLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            //self.itemValLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -11.33)

        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
}


