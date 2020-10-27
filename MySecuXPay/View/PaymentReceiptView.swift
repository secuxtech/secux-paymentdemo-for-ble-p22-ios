//
//  PaymentReceiptView.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/13.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import secux_paymentkit_v2

class PaymentReceiptView: UIView{
    
    let leftPadding: CGFloat = 10
    
    lazy var secuxLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 20)
        label.text = "SecuX"
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.leftPadding)
        
        ])
        
        return label
    }()
    
    lazy var receiptLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.fontName, size: 20)
        label.text = "receipt"
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: self.secuxLabel.rightAnchor, constant: 3)
        
        ])
        
        return label
    }()
    
    
    lazy var transCodeLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.fontName, size: 15)
        label.text = ""
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.secuxLabel.bottomAnchor, constant: 5),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.leftPadding)
        
        ])
        
        return label
    }()
    
    lazy var storeLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 18)
        label.text = ""
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.transCodeLabel.bottomAnchor, constant: 30),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.leftPadding)
        
        ])
        
        return label
    }()
    
    lazy var storeTelLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.fontName, size: 17)
        label.text = ""
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.storeLabel.bottomAnchor, constant: 5),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.leftPadding)
        
        ])
        
        return label
    }()
    
    lazy var storeAddrLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.fontName, size: 17)
        label.text = ""
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.storeTelLabel.bottomAnchor, constant: 5),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.leftPadding),
            label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4)
        ])
        
        return label
    }()
    
    lazy var payDetailsLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 17)
        label.text = "Payment Details:"
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.right
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 30),
            label.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -5)
        
        ])
        
        return label
    }()
    
    lazy var userAccLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.fontName, size: 16)
        label.text = ""
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.payDetailsLabel.topAnchor),
            label.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 5),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        
        ])
        
        return label
    }()
    
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.fontName, size: 16)
        label.text = ""
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.userAccLabel.bottomAnchor, constant: 5),
            label.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 5)
        
        ])
        
        return label
    }()
    
    lazy var timeLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.fontName, size: 16)
        label.text = ""
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 5),
            label.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 5)
        
        ])
        
        return label
    }()
    
    
    lazy var amountLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 17)
        label.text = "Amount:"
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.right
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -5)
        
        ])
        
        return label
    }()
    
    lazy var amountValLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.fontName, size: 18)
        label.text = ""
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.amountLabel.topAnchor, constant: 0),
            label.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 5)
        
        ])
        
        return label
    }()
    
    lazy var tokenLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.fontName, size: 16)
        label.text = ""
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.amountValLabel.bottomAnchor, constant: 5),
            label.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 5)
        
        ])
        
        return label
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.backgroundColor = UISetting.shared.titleBKColor
        self.backgroundColor = UISetting.shared.vcBKColor
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
        layer.shadowColor = UIColor.black.cgColor
        //layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 0).cgPath
        layer.shadowOffset = .zero //CGSize(width: 2.0, height: 2.0)
        layer.shadowOpacity = 0.3
    }
    
    
    func Setup(payHis: SecuXPaymentHistory){
        
        let _ = self.receiptLabel
        
        self.transCodeLabel.text = payHis.transactionCode
        self.storeLabel.text = payHis.storeName
        self.storeTelLabel.text = payHis.storeTel
        self.storeAddrLabel.text = payHis.storeAddress
        
        let _ = self.payDetailsLabel
        self.userAccLabel.text = payHis.userAccountName
        
        let datetime = Common.UTCToLocal(date: payHis.transactionTime) ?? ""
        
        if let pos = datetime.firstIndex(of: " "){
            let paydate = String(datetime[..<pos])
            let paytime = String(datetime[pos...])
        
            self.dateLabel.text = paydate
            self.timeLabel.text = paytime.trimmingCharacters(in: [" "])
        }
    
        
        let _ = self.amountLabel
        self.amountValLabel.text = payHis.amount
        self.tokenLabel.text = payHis.token
        
    
        
    }
}
