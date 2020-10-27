//
//  CoinTokenSelectionTableViewCell.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/25.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

class CoinTokenSelectionTableViewCell: UITableViewCell{
    
    
    
    lazy var itemImg: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(named: "dct")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
        ])
        
        return imageView
    }()
       
    lazy var coinLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "DCT," //"\(row+1)"

        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 17)
        label.textColor = .white
        label.textAlignment = NSTextAlignment.left

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leftAnchor.constraint(equalTo: self.itemImg.rightAnchor, constant: 16),
            
        ])
        
        
        return label
    }()
    
    lazy var tokenLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "DCT" //"\(row+1)"

        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 17)
        label.textColor = .white
        label.textAlignment = NSTextAlignment.left

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()

        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leftAnchor.constraint(equalTo: self.coinLabel.rightAnchor, constant: 5),
            
        ])
        
        
        return label
    }()
    
    
    
    func setup(coin:String, token:String){
        if let img = CoinTokenAccount.getCoinLogo(type: coin){
            self.itemImg.image = img
        }
        self.coinLabel.text = "" //coin + ", "
        self.tokenLabel.text = token
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UISetting.shared.titleBKColor
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UISetting.shared.titleBKColor
    }
}
