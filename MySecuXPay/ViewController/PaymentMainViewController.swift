//
//  ViewController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/1/16.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import swiftScan
import secux_paymentkit_v2

import CoreNFC

class PaymentMainViewController: BaseViewController {
    
    /*
    lazy var detectNFCButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1), UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1)])
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: "Arial", size: 22)
        btn.setTitle(NSLocalizedString("Detect NFC", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(detectNFCAction), for: .touchUpInside)
        
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        
        self.view.addSubview(btn)
        
        
        NSLayoutConstraint.activate([
            
            btn.bottomAnchor.constraint(equalTo: self.scanQRCodeButton.topAnchor, constant: -30),
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            btn.heightAnchor.constraint(equalToConstant: 48.63),
            btn.widthAnchor.constraint(equalToConstant: 199.54)
            
        ])
       
        return btn
    }()
    
    lazy var scanQRCodeButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1), UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1)])
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: "Arial", size: 22)
        btn.setTitle(NSLocalizedString("Scan QR code", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(scanQRCodeAction), for: .touchUpInside)
        
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        
        self.view.addSubview(btn)
        
        
        NSLayoutConstraint.activate([
            
            btn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10),
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            btn.heightAnchor.constraint(equalToConstant: 48.63),
            btn.widthAnchor.constraint(equalToConstant: 199.54)
            
        ])
       
        return btn
    }()
    
    */
    
    lazy var titleView: UIView = {
     
        let theView = UIView()
        theView.backgroundColor = UISetting.shared.titleBKColor
        theView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(theView)
        
        NSLayoutConstraint.activate([
            theView.topAnchor.constraint(equalTo: self.view.topAnchor),
            theView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            theView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            theView.heightAnchor.constraint(equalToConstant: 100)
        ])
       
        return theView
    }()
    
    lazy var detectNFCButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "payment_nfc_btn"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(detectNFCAction), for: .touchUpInside)
        
         
        self.view.addSubview(btn)

        NSLayoutConstraint.activate([
         
            btn.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 80),
            //btn.bottomAnchor.constraint(equalTo: self.historyButton.topAnchor, constant: -130),
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -86)
         
        ])

        return btn
    }()
    
    lazy var detectNFCLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.fontName, size: 16)
        label.text = "Pay by NFC"
        label.textColor = .gray
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.view.addSubview(label)
        NSLayoutConstraint.activate([
         
            label.topAnchor.constraint(equalTo: self.detectNFCButton.bottomAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: self.detectNFCButton.centerXAnchor)
         
        ])
        
        return label
    }()
    
    lazy var scanQRCodeButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "payment_qrcode_btn"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(scanQRCodeAction), for: .touchUpInside)
        
        self.view.addSubview(btn)

        NSLayoutConstraint.activate([

            btn.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 80),
            //btn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -230),
            //btn.bottomAnchor.constraint(equalTo: self.historyButton.topAnchor, constant: -130),
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 86)

        ])

        return btn
    }()
    
    lazy var scanQRCodeLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.fontName, size: 16)
        label.text = "Pay by QRCode"
        label.textColor = .gray
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.view.addSubview(label)
        NSLayoutConstraint.activate([
         
            label.topAnchor.constraint(equalTo: self.scanQRCodeButton.bottomAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: self.scanQRCodeButton.centerXAnchor)
         
        ])
        
        return label
    }()
    
    lazy var itemImg: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_payment_history")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
           
            imageView.centerYAnchor.constraint(equalTo: self.historyButton.centerYAnchor),
            imageView.rightAnchor.constraint(equalTo: self.historyButton.leftAnchor, constant: -5)
           
        ])
        
        return imageView
    }()

    lazy var historyButton: UIButton = {
       
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false

        
        let btnAttributes: [NSAttributedString.Key: Any] = [
                            .font: UIFont(name: "Arial", size: 17)!,
                            .foregroundColor: UIColor.black,
                            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "Payment History",
                                                        attributes: btnAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        
        //btn.titleLabel?.font = UIFont(name: "Arial", size: 17)
        //btn.setTitle("Payment History", for: .normal)
        //btn.setTitleColor(.black, for: .normal)
        
        btn.addTarget(self, action: #selector(historyAction), for: .touchUpInside)
        

        self.view.addSubview(btn)

        NSLayoutConstraint.activate([
           
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -18)
           
        ])

        return btn
    }()
    
    var session: NFCNDEFReaderSession?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      
        
        var _ = self.titleView
        var _ = self.historyButton
        var _ = self.scanQRCodeButton
        var _ = self.detectNFCButton
        var _ = self.itemImg
        var _ = self.detectNFCLabel
        var _ = self.scanQRCodeLabel
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.title = ""
        //self.navigationController?.
    }
    
    /*
    func getAccountInfo(){
        let accountManager = SecuXAccountManager()
        let theUserAccount = SecuXUserAccount(email: "maochuntest7@secuxtech.com", phone: "0975123456", password: "12345678")
        

        //Login test
        var (ret, data) = accountManager.loginUserAccount(userAccount: theUserAccount)
        guard ret == SecuXRequestResult.SecuXRequestOK else{
            print("login failed!")
            if let data = data{
                print("Error: \(String(data: data, encoding: String.Encoding.utf8) ?? "")")
            }
            return
        }
        print("login done")
        
        //Get account balance
        (ret, data) = accountManager.getAccountBalance(userAccount: theUserAccount)
        guard ret == SecuXRequestResult.SecuXRequestOK else{
            print("get balance failed!")
            if let data = data{
                print("Error: \(String(data: data, encoding: String.Encoding.utf8) ?? "")")
            }
            return
        }
        print("get account balance done")
        
        MyAccount.shared.setUserAccount(userAccount: theUserAccount)
    }
    */
    
    

    @objc func historyAction(){
        
        let vc = PaymentHistoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func scanQRCodeAction(){
        
        self.hasCameraPermission()
        
        if Setting.shared.testFlag{
            
            let paymentInfo = "{\"refund\":\"6\", \"coinType\":\"DCT:SPC\",\"deviceIDhash\":\"592e41d67ee326f82fd6be518fd488d752f5a1b9\"}"
            self.handlePaymentInfo(payinfo: paymentInfo)
            
            return
        }
        
        var style = LBXScanViewStyle()
        style.centerUpOffset = 44
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.On
        style.photoframeLineW = 6
        style.photoframeAngleW = 24
        style.photoframeAngleH = 24
        style.colorAngle = UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1)
        style.isNeedShowRetangle = true
        
        style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid

        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_part_net")
        
        let vc = LBXScanViewController()
        vc.scanStyle = style
        vc.scanResultDelegate = self
        
        //vc.modalPresentationStyle = .overCurrentContext
        //self.present(vc, animated: true, completion: nil)
        
        //self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func detectNFCAction(){
        
        if NFCNDEFReaderSession.readingAvailable {
            session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
            session?.begin()
        }else{
            self.showMessage(title: "Your phone DOES NOT support NFC!", message: "")
        }
        
        
    }

    func handlePaymentInfo(payinfo:String){
        DispatchQueue.global(qos: .default).async {
            
            guard let theCoinAccountArr = MyAccount.shared.theCoinTokenAccountArray, theCoinAccountArr.count > 0 else{
                self.showMessageInMainThread(title: "No valid payment account available!", message: "")
                return
            }
            
            var amount = "0"
            var refundAmount = "0"
            var refillAmount = "0"
            var nonce = ""
            
            
            if let payData = payinfo.data(using: .utf8),
                let payJson = try? JSONSerialization.jsonObject(with: payData, options : []) as? [String:Any]{
                
                if let amountinfo = payJson["amount"] as? String{
                   amount = amountinfo
                }else if let refundinfo = payJson["refund"] as? String{
                   refundAmount = refundinfo
                }else if let refillinfo = payJson["refill"] as? String{
                   refillAmount = refillinfo
                }
                
                if let nonceStr = payJson["nonce"] as? String{
                    nonce = nonceStr
                }
                
            } else {
                self.showMessageInMainThread(title: "Invalid QRCode!", message: "")
                return
            }
            
            self.showProgress(info: "Processing...")
            let paymentManager = SecuXPaymentManager()
            let (ret, data) = paymentManager.getPaymentInfo(paymentInfo: payinfo)
            guard ret == SecuXRequestResult.SecuXRequestOK, let payInfoData = data else{
                self.hideProgress()
                
                if ret == SecuXRequestResult.SecuXRequestUnauthorized || ret == SecuXRequestResult.SecuXRequestNoToken{
                    self.handleUnauthorizedError()
                }else{
                    self.showMessageInMainThread(title: "Invalid payment information!", message: "Please try again.")
                }
                return
            }
            
            
            print("get payment info. done")
            
            guard let payInfo = String(data: payInfoData, encoding: String.Encoding.utf8) else{
                self.hideProgress()
                self.showMessageInMainThread(title: "Invalid payment info. from server!", message: "Please try again.")
                return
            }
            
            guard let payinfoJson = try? JSONSerialization.jsonObject(with: payInfoData, options: []) as? [String:Any] else{
                print("Invalid json response from server")
                self.hideProgress()
                self.showMessageInMainThread(title: "Invalid json response from server!", message: "Please try again.")
                return
            }
            
            guard let devIDHash = payinfoJson["deviceIDhash"] as? String,
                  let devID = payinfoJson["deviceID"] as? String else{
                print("Response has no hashed devID")
                self.hideProgress()
                self.showMessageInMainThread(title: "Server response has no hashed devID!", message: "Please try again.")
                return
            }
                
            
            var cointype = ""
            var token = ""
            
            if let type = payinfoJson["coinType"] as? String, type != "null"{
                
                
                if let pos = type.firstIndex(of: ":"){
                    cointype = String(type[..<pos])
                    token = String(type[type.index(after: pos)...])
                }else{
                    cointype = type
                }
                
            }
            
            if let theToken = payinfoJson["token"] as? String{
                token = theToken
            }
                
            let (reqRet, error, info) = paymentManager.getStoreInfo(devID: devIDHash)
            
            guard reqRet == SecuXRequestResult.SecuXRequestOK, let storeInfo = info, let imgStore = storeInfo.logo,
                storeInfo.coinTokenArray.count > 0, storeInfo.name.count > 0 else {
                    self.hideProgress()
                    self.showMessageInMainThread(title: "Get store information from server failed!", message: error)
                    return
            }
                
                
            var theAccountArray = [CoinTokenAccount]()
            if cointype.count > 0, token.count > 0{
                let accountArray = MyAccount.shared.getCoinTokenAccountArray(coin: cointype, token: token)
                if accountArray.count > 0{
                    theAccountArray.append(contentsOf: accountArray)
                }
            }else{
                for item in storeInfo.coinTokenArray{
                    let accountArray = MyAccount.shared.getCoinTokenAccountArray(coin: item.coin, token: item.token)
                    if accountArray.count > 0{
                        theAccountArray.append(contentsOf: accountArray)
                    }
                }
            }
            
            if theAccountArray.count == 0{
                
                self.hideProgress()
                self.showMessageInMainThread(title: "No valid payment account available!", message: "")
                return
                
            }
            
            let accountManager = SecuXAccountManager()
            for account in theAccountArray{
            
                let (_, _) = accountManager.getAccountBalance(userAccount: MyAccount.shared.theUserAccount!,
                                                              coinType: account.coinType,
                                                              token: account.token)
            }
            self.hideProgress()
                
            DispatchQueue.main.async {
                
                if let nRefundAmount = Int(refundAmount), nRefundAmount > 0{
                    
                    if !Setting.shared.enableRefundFlag || Setting.shared.forItriTestFlag{
                        self.showMessageInMainThread(title: "Invalid QRCode!", message: "")
                        return
                    }
                    
                    let vc = RefundViewController()
                    
                    vc.paymentInfo = payInfo
                    vc.amount = refundAmount
                    
                    vc.storeImg = imgStore
                    vc.storeName = storeInfo.name
                    vc.storeInfo = storeInfo.info
                    vc.coinType = cointype
                    vc.token = token
                    vc.nonce = nonce

                    vc.deviceID = devID
                    vc.deviceIDhash = devIDHash

                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }else if let nRefillAmount = Int(refillAmount), nRefillAmount > 0{
                    
                    if !Setting.shared.enableRefillFlag || Setting.shared.forItriTestFlag{
                        self.showMessageInMainThread(title: "Invalid QRCode!", message: "")
                        return
                    }
                    
                    let vc = RefillViewController()
                    
                    vc.paymentInfo = payInfo
                    vc.amount = refillAmount

                    vc.storeImg = imgStore
                    vc.storeName = storeInfo.name
                    vc.storeInfo = storeInfo.info
                    vc.coinType = cointype
                    vc.token = token
                    vc.nonce = nonce

                    vc.deviceID = devID
                    vc.deviceIDhash = devIDHash

                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }else{
                
                    let vc = PaymentDetailsViewController()
                    
                    vc.paymentInfo = payInfo
                    vc.amount = amount
                    
                    vc.storeImage = imgStore
                    vc.storeName = storeInfo.name
                    vc.storeInfo = storeInfo.info
                    vc.nonce = nonce
           
                    vc.deviceID = devID
                    vc.deviceIDhash = devIDHash
                    
                    vc.theAccountArray = theAccountArray
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

extension PaymentMainViewController: LBXScanViewControllerDelegate{
    func scanFinished(scanResult: LBXScanResult, error: String?) {
        
        print("scan ret = \(scanResult.strScanned ?? "")")
        
        /*
         {"amount":"100", "coinType":"DCT", "deviceID": "4ab10000726b"}
        */
        
        if let payInfoStr = scanResult.strScanned{
            
            self.handlePaymentInfo(payinfo: payInfoStr)
            return
        }
        
        self.showMessage(title: "Invalid QRCode!", message: "Please try again.")
    }
    
    
}

extension PaymentMainViewController:NFCNDEFReaderSessionDelegate{
  
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
        
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            
            for record in message.records {
                if let string = String(data: record.payload, encoding: .ascii) {
                    print(string)
                    
                    if let startPos = string.firstIndex(of: "{"), let endPos = string.lastIndex(of: "}"){
                        let payInfoJson = String(string[startPos...endPos])
                        print(payInfoJson)
                        
                        self.handlePaymentInfo(payinfo: payInfoJson)
                        session.invalidate()
                    }
                    
                }
                
                //print("Type name format: \(record.typeNameFormat)")
                //print("Payload: \(record.payload)")
                //print("Type: \(record.type)")
                //print("Identifier: \(record.identifier)")
            }

        }
    }
    
    /*
    @available(iOS 13.0, *)
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]){
        print("readSession didDetect nfcTag")
        
    }
    */
    
    @available(iOS 13.0, *)
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession){
        print("readerSessionDidBecomeActive")
    }
}
