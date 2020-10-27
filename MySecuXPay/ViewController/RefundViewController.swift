//
//  RefundViewController.swift
//  SecuX EvPay
//
//  Created by maochun on 2020/7/16.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import secux_paymentkit_v2

import AVFoundation

class RefundViewController: BaseViewController {
    
    var storeName : String = ""
    var storeImg : UIImage?
    var amount : String = "0"
    
    var coinType : String = ""
    var token : String = ""
    
    var deviceID : String = ""
    var deviceIDhash : String = ""

    var paymentMgr: SecuXPaymentManager?
    var paymentInfo: String = ""
    var storeInfo: String = ""
    var nonce: String = ""
    
    lazy var titleImg: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(named: "refund_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
    
        NSLayoutConstraint.activate([
           
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 90),
            imageView.heightAnchor.constraint(equalToConstant: 90)
           
        ])
        
        
        return imageView
    }()
    
    lazy var accountLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Refund Store"
        
        label.font = UIFont(name: UISetting.shared.boldFontName, size: 20)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1)
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.titleImg.bottomAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: self.refundButton.leftAnchor, constant: 0)
        
        ])
        
        
        return label
    }()
    
    
    lazy var storeInfoView : StoreInfoView = {
        let cell = StoreInfoView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(cell)
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(accountTappedAction(_:)))

        //cell.isUserInteractionEnabled = true
        //cell.addGestureRecognizer(tap)
        
        if let image = self.storeImg{
            cell.setup(name: storeName, logo: image)
        }else{
            cell.setup(name: storeName, logo: UIImage(named: "storeinfo_error")!)
        }
        
        NSLayoutConstraint.activate([
            
            
            cell.topAnchor.constraint(equalTo: self.accountLabel.bottomAnchor, constant: 8.67),
            
            cell.widthAnchor.constraint(equalToConstant: 320),
            cell.heightAnchor.constraint(equalToConstant: 90),
            cell.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            
        ])
       
        
        return cell
        
    }()
    
    lazy var amountLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Refund Amount"
        
        label.font = UIFont(name:UISetting.shared.boldFontName, size: 20)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1)
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.storeInfoView.bottomAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: self.refundButton.leftAnchor, constant: 0)
        
        ])
        
        
        return label
    }()
    
    
    
    lazy var amountInputField: UnderlineIconTextField = {
        
        
        let input = UnderlineIconTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        
        if let coinImg = CoinTokenAccount.getCoinLogo(type: self.coinType){
            input.leftImage = coinImg
        }
        input.rightTxt = self.token
        input.theTextField.text = self.amount
        input.setup(hasLeftIcon: true, hasRightTxt: true)
        //input.setTextFieldDelegate(delegate: self)
        //input.keyboardType = .decimalPad
        input.enableTextField = false
        
        self.view.addSubview(input)
        
        
        NSLayoutConstraint.activate([
            
            
            input.topAnchor.constraint(equalTo: self.amountLabel.bottomAnchor, constant: 8.67),
            
            input.widthAnchor.constraint(equalToConstant: 300),
            input.heightAnchor.constraint(equalToConstant: 40),
            input.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            
        ])

        return input
    }()
    
    lazy var refundButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1), UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1)])
        
    
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 22)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.setTitleColor(UIColor.white, for: .disabled)
        btn.setTitle(NSLocalizedString("Refund", comment: ""), for: .normal)
        //btn.setBackgroundColor(UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), for:.disabled)
        btn.addTarget(self, action: #selector(refundAction), for: .touchUpInside)
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        self.view.addSubview(btn)
        
        NSLayoutConstraint.activate([
            
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -26),
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btn.widthAnchor.constraint(equalToConstant: 308),
            btn.heightAnchor.constraint(equalToConstant: 46)
            
        ])
       
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //var _ = self.storeNameLabel
        var _ = self.titleImg
        var _ = self.accountLabel
        
        var _ = self.amountLabel
        var _ = self.amountInputField
        var _ = self.refundButton
        
        var _ = self.storeInfoView
        
        self.view.backgroundColor = .white
        
        self.paymentMgr = SecuXPaymentManager()
        
    }
    
    @objc func refundAction(){
        
        if !Setting.shared.hasInternet.value{
            showMessage(title: "No network! Please check your phone's network setting.", message: "")
            return
        }
        
        showProgress(info: "Processing...")
        
        
        DispatchQueue.global().async {
            
            var (ret, info) : (SecuXRequestResult, String)
            if self.nonce.count == 0{
                (ret, info) = self.paymentMgr!.doRefund(devID: self.deviceID, devIDHash: self.deviceIDhash)
            }else{
                (ret, info) = self.paymentMgr!.doRefund(nonce:self.nonce, devID: self.deviceID, devIDHash: self.deviceIDhash)
            }
            
            self.hideProgress()
            if ret == .SecuXRequestNoToken || ret == .SecuXRequestUnauthorized{
                self.handleUnauthorizedError()
            }else{
                
                DispatchQueue.main.async {
                    let now:Date = Date()
                    let dateFormat:DateFormatter = DateFormatter()
                    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let dateString:String = dateFormat.string(from: now)
                    
                    let vc = RefundResultViewController()
                    vc.amount = "\(self.amount) \(self.token)"
                    vc.storeName = self.storeName
                    vc.timestamp = dateString
                    vc.token = self.token
                    
                    if ret == .SecuXRequestOK{
                        vc.result = true
                        vc.transCode = info
                        
                        var soundID:SystemSoundID = 0
                        let path = Bundle.main.path(forResource: "paysuccess", ofType: "wav")
                        let baseURL = NSURL(fileURLWithPath: path!)
                        AudioServicesCreateSystemSoundID(baseURL, &soundID)
                        AudioServicesPlaySystemSound(soundID)
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                        
                    }else{
                        vc.result = false
                        vc.failReason = info
                        
                        let soundID: SystemSoundID = 1053
                        AudioServicesPlaySystemSound(soundID)
                        usleep(500000)
                        AudioServicesPlaySystemSound(soundID)
                    }
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
        }
        
    }
    
    
}
