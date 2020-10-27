//
//  ChangePasswordTitleView.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/18.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

class ChangePasswordTitleView: UIView {
    
    lazy var changePwdImg: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(named: "changepwd_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
    
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)

        ])
        
        return imageView
    }()
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Change Password"
        
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
    
            label.topAnchor.constraint(equalTo: self.changePwdImg.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: self.changePwdImg.centerXAnchor)
        
        ])
        
        
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UISetting.shared.titleBKColor
        
        let _ = self.changePwdImg
        let _ = self.nameLabel
        
        
        
    }
}
