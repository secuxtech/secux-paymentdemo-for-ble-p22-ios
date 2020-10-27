//
//  ReigsterView.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/11.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import secux_paymentkit_v2

public protocol RegisterViewDelegate{
    func showRegisterMessage(message:String)
    func registerStart()
    func registerDone(ret:Bool, errorMsg:String)
    func showPopupSelection(vc:UIViewController)
}

class RegisterView: UIView{
    
    let maxInputFieldLen: CGFloat = 400
    
    var inputBoxOffset = 30.0
    var registerDelegate : RegisterViewDelegate?
    
    
    lazy var coinTokenSelView: CoinTokenSelectionView = {
        let theView = CoinTokenSelectionView()
        theView.translatesAutoresizingMaskIntoConstraints = false
        theView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(coinTokenSelViewTappedAction(_:)))

        theView.isUserInteractionEnabled = true
        theView.addGestureRecognizer(tap)
        
        self.addSubview(theView)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                theView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
                theView.widthAnchor.constraint(equalToConstant: maxInputFieldLen),
                theView.heightAnchor.constraint(equalToConstant: 50),
                theView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        }else{
            NSLayoutConstraint.activate([
                
                theView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
                theView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: CGFloat(inputBoxOffset)),
                theView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                theView.heightAnchor.constraint(equalToConstant: 50),
                theView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                
            ])
        }
        
        return theView
    }()
    
    lazy var emailInput: IconUITextField = {
     
        let input = IconUITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        //input.borderStyle = .roundRect
        input.keyboardType = UIKeyboardType.emailAddress
        
        input.returnKeyType = .done
        
        input.attributedPlaceholder = NSAttributedString(string: "Email",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                         NSAttributedString.Key.font: UIFont(name: "Arial", size: 17.0)!])
        
        
        //input.layer.masksToBounds = true
        //input.layer.cornerRadius = 5.0
        
        //input.backgroundColor = .white //#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        //input.textColor = UIColor.darkGray
        //input.leftImage = UIImage(named: "accountIcon")
        
        input.backgroundColor = .clear
        input.textColor = .white
        input.layer.borderColor = UIColor.white.cgColor
        input.layer.borderWidth = 1
        input.tintColor = .white
        
        input.leftPadding = 10
        input.font = UIFont(name: "Arial", size: 19.0)
        
        
        self.addSubview(input)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.coinTokenSelView.bottomAnchor, constant: 30),
                input.widthAnchor.constraint(equalToConstant: maxInputFieldLen),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        }else{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.coinTokenSelView.bottomAnchor, constant: 30),
                input.leftAnchor.constraint(equalTo: self.leftAnchor, constant: CGFloat(inputBoxOffset)),
                input.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                
            ])
        }
        
        
        return input
    }()
    
    lazy var phoneInput: IconUITextField = {
     
        let input = IconUITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        //input.borderStyle = .roundRect
        input.keyboardType = UIKeyboardType.phonePad
        input.attributedPlaceholder = NSAttributedString(string: "Phone number",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                         NSAttributedString.Key.font: UIFont(name: "Arial", size: 17.0)!])
        
        input.returnKeyType = .done
        
        //input.layer.masksToBounds = true
        //input.layer.cornerRadius = 5.0
        
        //input.backgroundColor = .white //#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        //input.textColor = UIColor.darkGray
        //input.leftImage = UIImage(named: "accountIcon")
        
        input.backgroundColor = .clear
        input.textColor = .white
        input.layer.borderColor = UIColor.white.cgColor
        input.layer.borderWidth = 1
        input.tintColor = .white
        
        input.leftPadding = 10
        input.font = UIFont(name: "Arial", size: 19.0)
        
        input.isHidden = true
        
        
        self.addSubview(input)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.coinTokenSelView.bottomAnchor, constant: 30),
                input.widthAnchor.constraint(equalToConstant: maxInputFieldLen),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        }else{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.coinTokenSelView.bottomAnchor, constant: 30),
                input.leftAnchor.constraint(equalTo: self.leftAnchor, constant: CGFloat(inputBoxOffset)),
                input.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                
            ])
        }
        
        
        return input
    }()
    
    lazy var pwdInput: IconUITextField = {
       
        let input = IconUITextField()
        
        //let input = IconUITextField(frame: rect)
        input.translatesAutoresizingMaskIntoConstraints = false
        
        //input.borderStyle = .roundRect
        input.keyboardType = UIKeyboardType.alphabet
        input.returnKeyType = .done
        input.attributedPlaceholder = NSAttributedString(string: "Password (8~10 char)",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                         NSAttributedString.Key.font: UIFont(name: "Arial", size: 17.0)!])
        
        
        //input.cornerRadius = 60
        //input.layer.masksToBounds = true
        //input.layer.cornerRadius = 5.0
        
        //input.backgroundColor = .white //#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        //input.textColor = UIColor.darkGray
        
        input.backgroundColor = .clear
        input.textColor = .white
        input.layer.borderColor = UIColor.white.cgColor
        input.layer.borderWidth = 1
        input.tintColor = .white
        
        input.isSecureTextEntry = true
        //input.leftImage = UIImage(named: "pwdIcon")
        input.leftPadding = 10
        input.font = UIFont(name: "Arial", size: 19.0)
        
        self.addSubview(input)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.phoneInput.bottomAnchor, constant: 30),
                input.widthAnchor.constraint(equalToConstant: maxInputFieldLen),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        }else{
            NSLayoutConstraint.activate([
                
               
                input.topAnchor.constraint(equalTo: self.phoneInput.bottomAnchor, constant: 30),
                input.leftAnchor.constraint(equalTo: self.leftAnchor, constant: CGFloat(inputBoxOffset)),
                input.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                
                
            ])
        }
        
        
        return input
    }()
    
    
    lazy var pwdConfirmInput: IconUITextField = {
       
        let input = IconUITextField()
        
        //let input = IconUITextField(frame: rect)
        input.translatesAutoresizingMaskIntoConstraints = false
        
        //input.borderStyle = .roundRect
        input.keyboardType = UIKeyboardType.alphabet
        input.returnKeyType = .done
        input.attributedPlaceholder = NSAttributedString(string: "Confirm password",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                         NSAttributedString.Key.font: UIFont(name: "Arial", size: 17.0)!])
        
        
        //input.cornerRadius = 60
        //input.layer.masksToBounds = true
        //input.layer.cornerRadius = 5.0
        
        //input.backgroundColor = .white //#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        //input.textColor = UIColor.darkGray
        input.isSecureTextEntry = true
        //input.leftImage = UIImage(named: "pwdIcon")
        
        input.backgroundColor = .clear
        input.textColor = .white
        input.layer.borderColor = UIColor.white.cgColor
        input.layer.borderWidth = 1
        input.tintColor = .white
        
        input.leftPadding = 10
        input.font = UIFont(name: "Arial", size: 19.0)
        
        self.addSubview(input)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.pwdInput.bottomAnchor, constant: 30),
                input.widthAnchor.constraint(equalToConstant: maxInputFieldLen),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        }else{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.pwdInput.bottomAnchor, constant: 30),
                input.leftAnchor.constraint(equalTo: self.leftAnchor, constant: CGFloat(inputBoxOffset)),
                input.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                
            ])
        }
        
        return input
    }()
    
    lazy var registerButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [UISetting.shared.buttonColor, UISetting.shared.buttonColor])
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: UISetting.shared.boldFontName, size: 17)
        btn.setTitle(NSLocalizedString("REGISTER", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        
        self.addSubview(btn)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                btn.topAnchor.constraint(equalTo: self.pwdConfirmInput.bottomAnchor, constant: 30),
                btn.widthAnchor.constraint(equalToConstant: self.maxInputFieldLen),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        }else{
            NSLayoutConstraint.activate([
                
                btn.topAnchor.constraint(equalTo: self.pwdConfirmInput.bottomAnchor, constant: 30),
                btn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: CGFloat(inputBoxOffset)),
                btn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                
            ])
        }
       
        return btn
    }()
    
    func setFocus(){
        self.emailInput.becomeFirstResponder()
    }
    
    
    @objc func coinTokenSelViewTappedAction(_ sender: UITapGestureRecognizer){
        
        if CoinTokenAccount.serverSupportedCoinAndTokenArray.count == 0{
            return
        }
        
        self.coinTokenSelView.dropdownToggle()
        
        
        let vc = CoinTokenSelectionViewController()
        var vcHeight = 50 * CoinTokenAccount.serverSupportedCoinAndTokenArray.count + 10
        if vcHeight > 300{
            vcHeight = 300
        }
        
        let vcWidth = 320 //self.coinTokenSelView.frame.width
        vc.preferredContentSize = CGSize(width: vcWidth, height: vcHeight)
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        
        let popoverPresentationController = vc.popoverPresentationController
        popoverPresentationController?.sourceView = self //self.coinTokenSelView
        popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popoverPresentationController?.sourceRect = CGRect(x: self.coinTokenSelView.frame.origin.x + self.coinTokenSelView.frame.width / 2 , y: self.coinTokenSelView.frame.origin.y + 45, width: 0, height: 0)
        popoverPresentationController?.delegate = self
        popoverPresentationController?.backgroundColor = .lightGray
    
        
        self.registerDelegate?.showPopupSelection(vc: vc)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.backgroundColor = UISetting.shared.titleBKColor
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        
        emailInput.delegate = self
        phoneInput.delegate = self
        pwdInput.delegate = self
        pwdConfirmInput.delegate = self
        let _ = registerButton
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func registerButtonTapped(){
        
        if !Setting.shared.hasInternet.value{
            self.registerDelegate?.showRegisterMessage(message: "No network! Please check your phone's network setting.")
            return
        }
        
        guard let email = self.emailInput.text, email.isValidEmail() else{
            self.registerDelegate?.showRegisterMessage(message: "Invalid email address!")
            return
        }
        
        //guard let phone = self.phoneInput.text, phone.count > 0 else{
        //    self.registerDelegate?.showRegisterMessage(message: "Invalid phone number!")
        //    return
        //}
        
        guard let pwd = self.pwdInput.text, pwd.count >= 6 else{
            self.registerDelegate?.showRegisterMessage(message: "Invalid password!")
            return
        }
        
        guard let pwdConfirm = self.pwdConfirmInput.text, pwdConfirm.count >= 6 else{
            self.registerDelegate?.showRegisterMessage(message: "Invalid password confirmation!")
            return
        }
        
        guard pwd == pwdConfirm else {
            self.registerDelegate?.showRegisterMessage(message: "Passwords NOT match!")
            return
        }
        
        self.registerDelegate?.registerStart()
        
        DispatchQueue.global(qos: .default).async {
            let accManager = SecuXAccountManager()
            let usrAcc = SecuXUserAccount(email: email.lowercased(), password: String(pwd))
            
            //var (ret, data) = accManager.registerUserAccount(userAccount: usrAcc, coinType: self.coinTokenSelView.coin, token: self.coinTokenSelView.token)
            
            var (ret, data) = accManager.registerUserAccount(userAccount: usrAcc,
                                                             coinType: self.coinTokenSelView.coin,
                                                             token: self.coinTokenSelView.token)
            
            if ret == SecuXRequestResult.SecuXRequestOK{
                (ret, data) = accManager.loginUserAccount(userAccount: usrAcc)
                if ret == SecuXRequestResult.SecuXRequestOK{
                    
                    (ret, data) = accManager.getAccountBalance(userAccount: usrAcc)
                    if ret == SecuXRequestResult.SecuXRequestOK{
                        self.registerDelegate?.registerDone(ret: true, errorMsg: "")
                        MyAccount.shared.setUserAccount(userAccount: usrAcc)
                    }else{
                        self.registerDelegate?.registerDone(ret: false, errorMsg: "Get account balance failed!")
                    }
                    
                }else{
                    var errorMsg = "Invalid email/password!"
                    if let data = data, let error = String(data: data, encoding: String.Encoding.utf8){
                        errorMsg = error
                    }
                    self.registerDelegate?.registerDone(ret: false, errorMsg: "Login failed! \(errorMsg)")
                }
            }else{
                var errorMsg = ""
                if let data = data, let error = String(data: data, encoding: String.Encoding.utf8){
                    errorMsg = error
                }
                self.registerDelegate?.registerDone(ret: false, errorMsg: "Register failed! \(errorMsg)")
            }
            
            
        }
    }
}

extension RegisterView: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //self.view.endEditing(true)
        
        if textField == self.emailInput{
            self.phoneInput.becomeFirstResponder()
        }else if textField == self.phoneInput{
            self.pwdInput.becomeFirstResponder()
        }else if textField == self.pwdInput{
            self.pwdConfirmInput.becomeFirstResponder()
        }else if textField == self.pwdConfirmInput{
            self.registerButtonTapped()
        }

        return true
    }
    
}


extension RegisterView: UIPopoverPresentationControllerDelegate{
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController){
        
        print("popup menu dismissed")
        
        DispatchQueue.main.async {
            self.coinTokenSelView.dropdownToggle()
        }
        
        if let vc = popoverPresentationController.presentedViewController as? CoinTokenSelectionViewController,
            let item = vc.selCoinToken {
            
            DispatchQueue.main.async {
                self.coinTokenSelView.setup(coin: item.coin, token: item.token)
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
