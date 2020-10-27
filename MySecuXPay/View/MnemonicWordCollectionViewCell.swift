//
//  MnemonicWordCollectionViewCell.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/4/7.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

class MnemonicWordCollectionViewCell: UICollectionViewCell {
    
    lazy var numLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.fontName, size: 16)
        label.text = ""
        label.textColor = UISetting.shared.titleBKColor
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        ])
        
        return label
    }()
    
    lazy var wordLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 18)
        label.text = ""
        label.textColor = .blue //UISetting.shared.titleBKColor
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        ])
        
        return label
    }()
    
    
    func setup(num:Int, word:String){
        self.numLabel.text = "\(num)."
        self.wordLabel.text = word
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

       
       
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
