//
//  SendViewController.swift
//  SecuX EvPay
//
//  Created by Maochun Sun on 2020/6/29.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import secux_paymentkit_v2

class SendViewController: BaseViewController {
    
    let accountManager = SecuXAccountManager()
    var theAccount : CoinTokenAccount?
    var toAccountName : String = ""
    
    lazy var fromLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "From Account"
        
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(red: 0.44, green: 0.44, blue: 0.44,alpha:1)
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
        
            label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
         
        
        ])
        
        
        return label
    }()
    
    lazy var fromAccountInfoView : AccountInfoView = {
        let cell = AccountInfoView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(cell)
        
        
        NSLayoutConstraint.activate([
            
            cell.topAnchor.constraint(equalTo: self.fromLabel.bottomAnchor, constant: 8),
            cell.widthAnchor.constraint(equalToConstant: 350),
            cell.heightAnchor.constraint(equalToConstant: 90),
            cell.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
       
        
        return cell
        
    }()
    
    lazy var toLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "To Account"
        
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(red: 0.44, green: 0.44, blue: 0.44,alpha:1)
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
        
            label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            label.topAnchor.constraint(equalTo: self.fromAccountInfoView.bottomAnchor, constant: 16),
         
        
        ])
        
        
        return label
    }()
    
    
    lazy var toAccountInfoView : AccountInfoView = {
        let cell = AccountInfoView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(cell)
        
        
        NSLayoutConstraint.activate([
            
            cell.topAnchor.constraint(equalTo: self.toLabel.bottomAnchor, constant: 8),
            cell.widthAnchor.constraint(equalToConstant: 350),
            cell.heightAnchor.constraint(equalToConstant: 90),
            cell.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
       
        
        return cell
        
    }()
    
    lazy var amountLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Amount"
        
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(red: 0.44, green: 0.44, blue: 0.44,alpha:1)
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
        
            label.leftAnchor.constraint(equalTo: self.fromLabel.leftAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: self.toAccountInfoView.bottomAnchor, constant: 30),
         
        
        ])
        
        
        return label
    }()
    
    lazy var amountInputField: UnderlineIconTextField = {
        
        let input = UnderlineIconTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.setup(hasLeftIcon: false, hasRightTxt: true)
        
        if let type = self.theAccount?.token{
            input.rightTxt = type
        }
        
        input.editTextFont = UIFont(name: UISetting.shared.fontName, size: 19.0)
        //input.setTextFieldDelegate(delegate: self)
        
        self.view.addSubview(input)
        
        
        NSLayoutConstraint.activate([
            
            
            input.topAnchor.constraint(equalTo: self.amountLabel.bottomAnchor, constant: 20),
            
            input.leftAnchor.constraint(equalTo: self.fromLabel.leftAnchor, constant: 0),
            
            //input.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2, constant: -10),
            input.widthAnchor.constraint(equalToConstant: 350),
            
            input.heightAnchor.constraint(equalToConstant: 40)
            
            
        ])

        return input
    }()
    
    lazy var sendButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1), UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1)])
        
    
    
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 22)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.setTitleColor(UIColor.white, for: .disabled)
        btn.setTitle(NSLocalizedString("Send", comment: ""), for: .normal)
        //btn.setBackgroundColor(UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), for:.disabled)
        btn.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        self.view.addSubview(btn)
        
        NSLayoutConstraint.activate([
            
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -26),
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btn.widthAnchor.constraint(equalToConstant: 350),
            btn.heightAnchor.constraint(equalToConstant: 46)
            
        ])
       
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        if let navCtrl = self.navigationController as? BaseUINavigationController{
            navCtrl.showMenuIcon(show: false)
        }
        
        let _ = self.amountInputField
        let _ = self.sendButton
        
        if let account = self.theAccount{
            self.fromAccountInfoView.setup(account: account)
            self.toAccountInfoView.setup(account: account, accountName: toAccountName)
        }
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func sendAction(){
        if let account = self.theAccount, let amount = self.amountInputField.text{
            let (ret, data, tranRet) = self.accountManager.doTransfer(coinType: account.coinType,
                                                token: account.token,
                                            feeSymbol: "",
                                               amount: amount,
                                             receiver: toAccountName)
            
        }
    }
    
    
}
