//
//  PaymentHistoryTableViewCell.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/12/1.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit
import secux_paymentkit_v2

class PaymentHistoryTableViewCell: BaseTableViewCell {
    
    
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
    
    lazy var storeNameLabel : UILabel = {
        let label = UILabel()
       
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""

        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 20)
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
    
    lazy var itemImg: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(named: "btc")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)
        
        return imageView
    }()
       
    lazy var itemNameLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10" //"\(row+1)"

        //label.font = UIFont.preferredFont(forTextStyle: .headline)
        //label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.init(name: "Helvetica-Bold", size: 14)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
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

        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 17)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.contentView.addSubview(label)

        return label
    }()
    
    lazy var itemBalanceLabel : UILabel = {
        let label = UILabel()
       
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""

        label.font = UIFont.init(name: "Arial", size: 19)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.contentView.addSubview(label)

        return label
    }()
    
    lazy var itemSNLabel : UILabel = {
        let label = UILabel()
       
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""

        label.font = UIFont.init(name: "Arial", size: 14)
        label.textColor = UIColor(red: 0x21/255, green: 0x96/255, blue: 0xF3/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.contentView.addSubview(label)

        return label
    }()
    
    func setup(historyInfo: SecuXPaymentHistory){
        
        self.contentView.backgroundColor = UISetting.shared.vcBKColor
        self.backgroundColor = UISetting.shared.vcBKColor
        var _ = self.bkView
        
        
        self.itemImg.image = CoinTokenAccount.getCoinLogo(type: historyInfo.coinType)
        
        NSLayoutConstraint.activate([
            
            self.storeNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            self.storeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            
            //self.itemImg.topAnchor.constraint(equalTo: self.storeNameLabel.bottomAnchor, constant: 5),
            
            //self.itemImg.widthAnchor.constraint(equalToConstant: 22),
            //self.itemImg.heightAnchor.constraint(equalToConstant: 22),
            
            self.itemImg.leftAnchor.constraint(equalTo: self.storeNameLabel.leftAnchor, constant: 0),
            self.itemImg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            
            self.itemNameLabel.leftAnchor.constraint(equalTo: itemImg.rightAnchor, constant: 10),
            self.itemNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            //self.itemNameLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 3/2, constant: -35),
            self.itemNameLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -50),
            
            
            self.timestampLabel.leftAnchor.constraint(equalTo: self.storeNameLabel.leftAnchor, constant: 0),
            self.timestampLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            self.itemSNLabel.leftAnchor.constraint(equalTo: self.storeNameLabel.leftAnchor, constant: 0),
            self.itemSNLabel.bottomAnchor.constraint(equalTo: self.timestampLabel.topAnchor, constant: -8),
            
            //self.itemBalanceLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -13.1),
            //self.itemBalanceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            
            self.itemValLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -13),
            self.itemValLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20)

        ])
        
        self.storeNameLabel.text = historyInfo.storeName
        //self.timestampLabel.text = historyInfo.transactionTime + " UTC"
        self.timestampLabel.text = Common.UTCToLocal(date: historyInfo.transactionTime) ?? ""
        
        if historyInfo.transactionStatus.caseInsensitiveCompare("established") == .orderedSame{
            self.itemSNLabel.text = "\(historyInfo.transactionCode)"
            self.itemSNLabel.textColor = UIColor(red: 0x21/255, green: 0x96/255, blue: 0xF3/255, alpha: 1)
        }else{
            self.itemSNLabel.text = "\(historyInfo.transactionCode) (\(historyInfo.transactionStatus))"
            self.itemSNLabel.textColor = .red
        }
        
        
        self.itemNameLabel.text = MyAccount.shared.getCoinTokenAccount(coinType: historyInfo.coinType)?.accountName ?? ""
        self.itemValLabel.text = historyInfo.amount + " " + historyInfo.token
        if historyInfo.transactionType == "Refill"{
            self.itemValLabel.text! += "\nRefill"
            self.itemValLabel.textColor = UIColor(red: 0x57/255, green: 0xa7/255, blue: 0x94/255, alpha: 1)
        }else if historyInfo.transactionType == "RefundPoint"{
            self.itemValLabel.text! += "\nRefound"
            self.itemValLabel.textColor = UIColor(red: 0xE5/255, green: 0xa8/255, blue: 0x55/255, alpha: 1)
        }else{
            self.itemValLabel.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        }
        
    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.isUserInteractionEnabled || self.isHidden || self.alpha == 0 {
          return nil
        }
        
        return self
    }
   
    

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
}
