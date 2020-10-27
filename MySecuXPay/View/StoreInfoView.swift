//
//  StoreInfoView.swift
//  SecuX EvPay
//
//  Created by maochun on 2020/7/17.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

class StoreInfoView: UIView {
    
    
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
        
        /*
         "Helvetica-LightOblique",
         Helvetica,
         "Helvetica-Oblique",
         "Helvetica-BoldOblique",
         "Helvetica-Bold",
         "Helvetica-Light"
         */


        label.font = UIFont.init(name: "Arial-BoldMT", size: 18)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.left

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()


        self.addSubview(label)
        return label
    }()



    func setup(name:String, logo:UIImage){
        
        self.backgroundColor = .white
        var _ = self.bkView
        
 
        self.itemNameLabel.text = name
        self.itemImg.image = logo

        NSLayoutConstraint.activate([
            
            self.itemImg.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.itemImg.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.itemImg.widthAnchor.constraint(equalToConstant: 40),
            self.itemImg.heightAnchor.constraint(equalToConstant: 40),
            
            self.itemNameLabel.leftAnchor.constraint(equalTo: itemImg.rightAnchor, constant: 10),
            self.itemNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.itemNameLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, constant: -45),
            
            
        ])
      
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        

        
    }
    
}
