//
//  ReceiveViewController.swift
//  SecuX EvPay
//
//  Created by Maochun Sun on 2020/6/29.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

class ReceiveViewController: BaseViewController {
    
    var theAccount : CoinTokenAccount?

    lazy var accountInfoView : AccountInfoView = {
        let cell = AccountInfoView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(cell)
        
        
        NSLayoutConstraint.activate([
            
            cell.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            cell.widthAnchor.constraint(equalToConstant: 350),
            cell.heightAnchor.constraint(equalToConstant: 90),
            cell.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
       
        
        return cell
        
    }()
    
    
    lazy var qrcodeImage: UIImageView = {
        let imageview = UIImageView()
        
        imageview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageview)
        
        NSLayoutConstraint.activate([
            
            imageview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            imageview.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10),
            
            //imageview.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2/3),
            //imageview.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2/3)
            
            imageview.widthAnchor.constraint(equalToConstant: 350),
            imageview.heightAnchor.constraint(equalToConstant: 350)
            
        ])
        
        
        return imageview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        if let navCtrl = self.navigationController as? BaseUINavigationController{
            navCtrl.showMenuIcon(show: false)
        }
        
        if let account = self.theAccount{
            self.accountInfoView.setup(account: account)
        }
        
        DispatchQueue.main.async {
        
            //{"receiver":"maochuntest1@secuxtech.com", "coin":"DCT", "token":"SPC", "account":""}
            if let account = self.theAccount{
                var image : UIImage?
                
                let infoJson = ["receiver":Setting.shared.loginAccount, "coin":account.coinType, "token":account.token, "account":account.accountName]
                if let theJSONData = try? JSONSerialization.data(
                    withJSONObject: infoJson,
                    options: .prettyPrinted
                  ),
                  let inforJsonTxt = String(data: theJSONData,
                                           encoding: String.Encoding.ascii) {
                        print("JSON string = \n\(inforJsonTxt)")
                    
                        /*
                        if let logo = account.getCoinLogo(){
                            image = QRCodeHandler.generationQRCodeWithLogo(from: inforJsonTxt, with:logo)
                        }else{
                            image = QRCodeHandler.generateQRCode(from:inforJsonTxt)
                        }
                        */
                        image = QRCodeHandler.generateQRCode(from:inforJsonTxt)
                        self.qrcodeImage.image = image
                    
                        return
                        
                }
                
            }
            
            self.showMessage(title: "Generate account QRCode failed!", message: "")
        }
        
    }
    
}
