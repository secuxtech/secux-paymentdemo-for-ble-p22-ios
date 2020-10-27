//
//  CoinTokenSelectionView.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/25.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

class CoinTokenSelectionView: UIView{
    
    lazy var itemImg: UIImageView = {

        let imageView = UIImageView()
        //imageView.image = UIImage(named: "dct")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
        ])
        
        return imageView
    }()
       
    lazy var itemNameLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "" //"\(row+1)"

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
    
    lazy var dropdownImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dropdown_btn")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalToConstant: 18),
            imageView.heightAnchor.constraint(equalToConstant: 18)
            
        ])
        
        
        return imageView
    }()
    
    var coin = ""
    var token = ""
    
    var dropdownMenuShows = false
    func dropdownToggle(){
        self.dropdownMenuShows = !self.dropdownMenuShows
        
        if !self.dropdownMenuShows{
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 8, options: [], animations: {
                self.dropdownImg.transform = self.dropdownImg.transform.rotated(by: -(CGFloat.pi * 0.999))
                
            })
        }else{
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 8, options: [], animations: {
                self.dropdownImg.transform = self.dropdownImg.transform.rotated(by: CGFloat.pi * 0.999)
            })
        }
    
    }
    
    func setup(coin:String, token:String){
        self.coin = coin
        self.token = token
        self.itemImg.image = CoinTokenAccount.getCoinLogo(type: coin)
        self.itemNameLabel.text = "\(token)" //"\(coin), \(token)"
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        
        let _ = self.itemImg
        let _ = self.itemNameLabel
        let _ = self.dropdownImg
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
        let _ = self.itemImg
        let _ = self.itemNameLabel
        let _ = self.dropdownImg
    }
    
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let xScale : CGFloat = 1.025
        let yScale : CGFloat = 1.05
        
        UIView.animate(withDuration: 0.1) {
            let transformation = CGAffineTransform(scaleX: xScale, y: yScale)
            self.transform = transformation
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let xScale : CGFloat = 1.0
        let yScale : CGFloat = 1.0
        
        UIView.animate(withDuration: 0.1) {
            let transformation = CGAffineTransform(scaleX: xScale, y: yScale)
            self.transform = transformation
        }
    }
    */

}
