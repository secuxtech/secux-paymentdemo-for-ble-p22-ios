//
//  AccountSettingTitleView.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/11.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

protocol AccountSettingTitleViewDelegate {
    func enableTestMode()
}

class AccountSettingTitleView: UIView{
    
    lazy var accountImg: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(named: "setting_account_logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(accImgTapDetected))
        tap.numberOfTapsRequired = 5
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)

        
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
    
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)

        ])
        
        return imageView
    }()
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Accounts"
        
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
    
            label.topAnchor.constraint(equalTo: self.accountImg.bottomAnchor, constant: 7.5),
            label.centerXAnchor.constraint(equalTo: self.accountImg.centerXAnchor)
        
        ])
        
        return label
    }()
    
    lazy var emailLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Accounts"
        
        label.font = UIFont(name: "Helvetica", size: 16)
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.addSubview(label)
        
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 6),
            label.centerXAnchor.constraint(equalTo: self.nameLabel.centerXAnchor)
        
        ])
        
        return label
    }()
    
    lazy var phoneLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont(name: "Helvetica", size: 16)
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.addSubview(label)
        
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 6),
            label.centerXAnchor.constraint(equalTo: self.emailLabel.centerXAnchor)
         
        ])
        
        
        return label
    }()
    
    var theDelegate : AccountSettingTitleViewDelegate?
    
    @objc func accImgTapDetected(){
        theDelegate?.enableTestMode()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UISetting.shared.titleBKColor
        
        let _ = self.accountImg
        
        if let account = MyAccount.shared.theUserAccount{
            self.nameLabel.text = account.alias
            self.emailLabel.text = account.email
            self.phoneLabel.text = account.phone
        }
        
    }
    
    
}
