//
//  ChangePasswordViewController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/18.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import secux_paymentkit_v2

class ChangePasswordViewController: BaseViewController{
    
    let maxInputFieldLen: CGFloat = 400
    
    var inputBoxOffset = 30.0
    
    lazy var titleView: ChangePasswordTitleView = {
       
        let theView = ChangePasswordTitleView()
        theView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(theView)
        
        NSLayoutConstraint.activate([
        
            theView.topAnchor.constraint(equalTo: self.view.topAnchor),
            theView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            theView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            theView.heightAnchor.constraint(equalToConstant: 200)
        
        ])
        
        
        return theView
        
    }()
    
    lazy var msgLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "*Password must be 6-18 characteristics"
        
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.textColor = UISetting.shared.titleBKColor
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
    
            label.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: self.titleView.centerXAnchor)
        
        ])
        
        return label
    }()
    
    lazy var oldPwdInput: IconUITextField = {
       
        let input = IconUITextField()
        
        //let input = IconUITextField(frame: rect)
        input.translatesAutoresizingMaskIntoConstraints = false
        
        //input.borderStyle = .roundRect
        input.keyboardType = UIKeyboardType.alphabet
        input.returnKeyType = .done
        input.attributedPlaceholder = NSAttributedString(string: "Old Password",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                         NSAttributedString.Key.font: UIFont(name: "Arial", size: 17.0)!])
        
        
        //input.cornerRadius = 60
        input.layer.masksToBounds = true
        input.layer.cornerRadius = 5.0
        
        input.backgroundColor = .white //#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        input.textColor = UIColor.darkGray
        input.isSecureTextEntry = true
        //input.leftImage = UIImage(named: "pwdIcon")
        input.leftPadding = 10
        input.font = UIFont(name: "Arial", size: 19.0)
        
        self.view.addSubview(input)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.msgLabel.bottomAnchor, constant: 20),
                input.widthAnchor.constraint(equalToConstant: maxInputFieldLen),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            ])
        }else{
            NSLayoutConstraint.activate([
                
               
                input.topAnchor.constraint(equalTo: self.msgLabel.bottomAnchor, constant: 20),
                input.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: CGFloat(inputBoxOffset)),
                input.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                
                
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
        input.attributedPlaceholder = NSAttributedString(string: "New Password",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                         NSAttributedString.Key.font: UIFont(name: "Arial", size: 17.0)!])
        
        
        //input.cornerRadius = 60
        input.layer.masksToBounds = true
        input.layer.cornerRadius = 5.0
        
        input.backgroundColor = .white //#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        input.textColor = UIColor.darkGray
        input.isSecureTextEntry = true
        //input.leftImage = UIImage(named: "pwdIcon")
        input.leftPadding = 10
        input.font = UIFont(name: "Arial", size: 19.0)
        
        self.view.addSubview(input)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.oldPwdInput.bottomAnchor, constant: 20),
                input.widthAnchor.constraint(equalToConstant: maxInputFieldLen),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            ])
        }else{
            NSLayoutConstraint.activate([
                
               
                input.topAnchor.constraint(equalTo: self.oldPwdInput.bottomAnchor, constant: 20),
                input.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: CGFloat(inputBoxOffset)),
                input.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                
                
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
        input.attributedPlaceholder = NSAttributedString(string: "Confirm New Password",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                         NSAttributedString.Key.font: UIFont(name: "Arial", size: 17.0)!])
        
        
        //input.cornerRadius = 60
        input.layer.masksToBounds = true
        input.layer.cornerRadius = 5.0
        
        input.backgroundColor = .white //#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        input.textColor = UIColor.darkGray
        input.isSecureTextEntry = true
        //input.leftImage = UIImage(named: "pwdIcon")
        input.leftPadding = 10
        input.font = UIFont(name: "Arial", size: 19.0)
        
        self.view.addSubview(input)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.pwdInput.bottomAnchor, constant: 20),
                input.widthAnchor.constraint(equalToConstant: maxInputFieldLen),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            ])
        }else{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.pwdInput.bottomAnchor, constant: 20),
                input.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: CGFloat(inputBoxOffset)),
                input.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                
            ])
        }
        
        return input
    }()
    
    lazy var submitButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [UISetting.shared.buttonColor, UISetting.shared.buttonColor])
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: UISetting.shared.boldFontName, size: 17)
        btn.setTitle(NSLocalizedString("SUBMIT", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        
        self.view.addSubview(btn)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                btn.widthAnchor.constraint(equalToConstant: self.maxInputFieldLen),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        }else{
            NSLayoutConstraint.activate([
                
                btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: CGFloat(inputBoxOffset)),
                btn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                
            ])
        }
       
        return btn
    }()
    
    var viewOriginY : CGFloat = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UISetting.shared.vcBKColor
      
        
        
        let _ = self.titleView
        let _ = self.oldPwdInput
        let _ = self.pwdInput
        let _ = self.pwdConfirmInput
        let _ = self.submitButton
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.title = ""
        
     
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if  self.view.frame.origin.y > viewOriginY && self.view.bounds.height < 800{
            self.viewOriginY = self.view.frame.origin.y
            self.view.frame.origin.y -= 50 //keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.viewOriginY != -1{
            self.view.frame.origin.y = self.viewOriginY
        }
        self.viewOriginY = -1
    }
    
    
    @objc func submitButtonTapped(){
        
        if !Setting.shared.hasInternet.value{
          
            showMessage(title: "No network! Please check your phone's network setting.", message: "")
            return
        
        }
        
        guard let oldpwd = self.oldPwdInput.text, oldpwd.count >= 6 else{
            self.showMessage(title: "Invalid old password", message: "")
            return
        }
        
        guard let pwd = self.pwdInput.text, pwd.count >= 6 else{
            self.showMessage(title: "Invalid new password", message: "")
            return
        }
        
        guard let confirmpwd = self.pwdConfirmInput.text, confirmpwd == pwd else{
            self.showMessage(title: "New passwords NOT match!", message: "")
            return
        }
        
        self.showProgress(info: "In progress...")
        
        DispatchQueue.global(qos: .default).async {
            let accMgr = SecuXAccountManager()
            let (ret, data) = accMgr.changePassword(oldPwd: oldpwd, newPwd: pwd)
            
            self.hideProgress()
            if ret == SecuXRequestResult.SecuXRequestOK{
                
                DispatchQueue.main.async {
                    MyAccount.shared.theUserAccount?.password = pwd
                    MyAccount.shared.passwordChanged = true
                    self.navigationController?.popViewController(animated: true)
                    
                }
                
            }else{
                var error = ""
                if let errData = data{
                    error = String(data: errData, encoding: String.Encoding.utf8) ?? ""
                }
                self.showMessageInMainThread(title: "Change password failed", message:error)
            }
            
        }

    }
    
}
