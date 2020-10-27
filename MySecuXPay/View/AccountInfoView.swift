//
//  AccountInfoView.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/27.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit
import secux_paymentkit_v2

class AccountInfoView: UIView {
    
    
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
        
        self.addSubview(bkview)
        
        NSLayoutConstraint.activate([
            
            bkview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3),
            bkview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3),
            bkview.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            bkview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
            
        ])
        
        return bkview
    }()
    
    lazy var itemImg: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(named: "btc")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        return imageView
    }()
       
    lazy var itemNameLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10" //"\(row+1)"

        //label.font = UIFont.preferredFont(forTextStyle: .headline)
        //label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.init(name: "Helvetica", size: 16)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.left

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()


        self.addSubview(label)
        return label
    }()

    lazy var itemValLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 USD"

        label.font = UIFont.init(name: "Arial-BoldMT", size: 16)
        label.textColor = UIColor(red: 0x50/255, green: 0x24/255, blue: 0x5a/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.addSubview(label)

        return label
    }()
    
    lazy var itemBalanceLabel : UILabel = {
        let label = UILabel()
       
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 USD"

        label.font = UIFont.init(name: "Arial", size: 19)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.right

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.addSubview(label)

        return label
    }()
    
    
    var theAccount : CoinTokenAccount?

    lazy var dropdownImage: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "angle-down")
        
        imageview.isHidden = true
        
        self.addSubview(imageview)
        
        NSLayoutConstraint.activate([
        
            imageview.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            imageview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),

        ])
        
        
        return imageview
    }()
    

    
    var dropdownMenuShows = false
    func dropdownToggle(){
        self.dropdownMenuShows = !self.dropdownMenuShows
        
        if !self.dropdownMenuShows{
            UIView.animate(withDuration: 0.5, animations: {
                self.dropdownImage.transform = self.dropdownImage.transform.rotated(by: -(CGFloat.pi * 0.999))
                
            })
        }else{
            UIView.animate(withDuration: 0.5, animations: {
                self.dropdownImage.transform = self.dropdownImage.transform.rotated(by: CGFloat.pi)
            })
        }
    }
    
    func setupWithDropdownBtn(account: CoinTokenAccount){
        self.backgroundColor = .white
       
        removeAccountBalanceObserver()
        self.theAccount = account
        var _ = self.bkView
        
        //self.theAccount?.formatedBalance.addObserver({ (value) in
            
        //    self.itemValLabel.text = "\(account.accountBalance?.theFormattedBalance ?? 0) \(account.coinType)"
        //    self.itemBalanceLabel.text = "$ \(account.accountBalance?.theUsdBalance ?? 0)"
        
        //})
        
        //let tt = account.getCoinImg()
        self.itemImg.image = account.getCoinLogo()
        self.dropdownImage.isHidden = false
        
     
        NSLayoutConstraint.activate([
            
            self.itemImg.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.itemImg.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.itemNameLabel.leftAnchor.constraint(equalTo: itemImg.rightAnchor, constant: 16),
            self.itemNameLabel.centerYAnchor.constraint(equalTo: itemImg.centerYAnchor, constant: -10),
            self.itemNameLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 1, constant: -100),
            
            self.itemValLabel.leftAnchor.constraint(equalTo: self.itemNameLabel.leftAnchor),
            self.itemValLabel.topAnchor.constraint(equalTo: self.itemNameLabel.bottomAnchor, constant: 8),

        ])
            
        
        
        
        self.itemNameLabel.text = account.accountName
        //self.itemValLabel.text = "\(account.accountBalance?.theFormattedBalance ?? 0) " + account.coinType
        
        if let balance = account.accountBalance{
            self.itemValLabel.text = "\(String(format: "%.2f", NSDecimalNumber(decimal: balance.theFormattedBalance).doubleValue)) \(account.token)"
        }else{
            self.itemValLabel.text = "0.0 \(account.token)"
        }
        
        if let balance = account.accountBalance{
            self.itemBalanceLabel.text = "$ \(String(format: "%.2f", NSDecimalNumber(decimal: balance.theUsdBalance).doubleValue))"
        }else{
            self.itemBalanceLabel.text = "$ 0.0"
        }
        
        self.itemBalanceLabel.isHidden = true
        
        //print("setup account \(self.itemValLabel.text)  \(self.itemBalanceLabel.text)")
    }
    
    func setup(account: CoinTokenAccount){
        
        self.backgroundColor = .white
        var _ = self.bkView
        
        removeAccountBalanceObserver()
        self.theAccount = account
        //self.theAccount?.formatedBalance.addObserver({ (value) in
            
        //    self.itemValLabel.text = "\(account.accountBalance?.theFormattedBalance ?? 0) " + account.coinType
        //    self.itemBalanceLabel.text = "$ \(account.accountBalance?.theUsdBalance ?? 0)"
        // })
        
        self.itemImg.image = account.getCoinLogo()

        NSLayoutConstraint.activate([
            
            self.itemImg.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.itemImg.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.itemNameLabel.leftAnchor.constraint(equalTo: itemImg.rightAnchor, constant: 16),
            self.itemNameLabel.centerYAnchor.constraint(equalTo: itemImg.centerYAnchor, constant: -10),
            self.itemNameLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 1, constant: -90),
            //self.itemNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            self.itemValLabel.leftAnchor.constraint(equalTo: self.itemNameLabel.leftAnchor),
            self.itemValLabel.topAnchor.constraint(equalTo: self.itemNameLabel.bottomAnchor, constant: 8),
        ])
    
        
        self.itemNameLabel.text = account.accountName
        //self.itemValLabel.text = "\(account.accountBalance?.theFormattedBalance ?? 0)" + account.token
        
        if let balance = account.accountBalance{
            self.itemValLabel.text = "\(String(format: "%.2f", NSDecimalNumber(decimal: balance.theFormattedBalance).doubleValue)) \(account.token)"
        }else{
            self.itemValLabel.text = "0.0 \(account.token)"
        }
        
        if let balance = account.accountBalance{
            self.itemBalanceLabel.text = "$ \(String(format: "%.2f", NSDecimalNumber(decimal: balance.theUsdBalance).doubleValue))"
        }else{
            self.itemBalanceLabel.text = "$ 0.0"
        }
        
        self.itemBalanceLabel.isHidden = true
      
        //print("setup account \(self.itemValLabel.text)  \(self.itemBalanceLabel.text)")
    }
    
    func setup(account: CoinTokenAccount, accountName: String){
        
        self.backgroundColor = .white
        var _ = self.bkView
        
        removeAccountBalanceObserver()
        self.theAccount = account
        //self.theAccount?.formatedBalance.addObserver({ (value) in
            
        //    self.itemValLabel.text = "\(account.accountBalance?.theFormattedBalance ?? 0) " + account.coinType
        //    self.itemBalanceLabel.text = "$ \(account.accountBalance?.theUsdBalance ?? 0)"
        // })
        
        self.itemImg.image = account.getCoinLogo()

        NSLayoutConstraint.activate([
            
            self.itemImg.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.itemImg.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
            self.itemNameLabel.leftAnchor.constraint(equalTo: itemImg.rightAnchor, constant: 10),
            self.itemNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.itemNameLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 1, constant: -65),
            
            
        ])
    
        
        self.itemNameLabel.text = accountName
        //self.itemValLabel.text = "\(account.accountBalance?.theFormattedBalance ?? 0)" + account.token
        
        self.itemValLabel.isHidden = true
        self.itemBalanceLabel.isHidden = true
      
        //print("setup account \(self.itemValLabel.text)  \(self.itemBalanceLabel.text)")
    }
    
    func removeAccountBalanceObserver(){
        
        //self.theAccount?.formatedBalance.removeObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        

        
    }
    
}
