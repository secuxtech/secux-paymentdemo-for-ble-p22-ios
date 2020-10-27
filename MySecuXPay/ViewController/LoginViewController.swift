//
//  LoginViewController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/11.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: BaseViewController {
    
    lazy var titleView: UIView = {
        let titleImgView = UIImageView(image: UIImage(named: "SecuX_Logo"))
        titleImgView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleImgView)
        
        NSLayoutConstraint.activate([
            
            titleImgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleImgView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
        ])
        
        return titleImgView
    }()
    
    lazy var theLoginView: LoginView = {
        
        let loginView = LoginView()
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            
            loginView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            loginView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            loginView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 30),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            
        ])
        
        return loginView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white

        self.theLoginView.loginDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.title = ""
        
        /*
        let localAuthContext = LAContext()
        if localAuthContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil){
            
            let biometricType = localAuthContext.biometryType == LABiometryType.faceID ? "Face ID" : "Touch ID"
            logw("Supported Biometric type is: \( biometricType )")
            
            localAuthContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Auto login the account") { success, evaluateError in
                
                if success{
                    self.theLoginView.autoLogin()
                }
            }
        }
        */
        
        self.theLoginView.biometricLoginAction()
    }
    
    override func viewDidLayoutSubviews() {
        //self.theLoginView.setBackgrounImg()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "login_bk_img")?.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let image = image{
            self.view.backgroundColor = UIColor.init(patternImage: image)
        }
    }
}

extension LoginViewController: LoginViewDelegate{
    func showLoginMessage(message: String) {
        self.showMessageInMainThread(title: message, message: "")
    }
    
    func loginStart() {
        self.showProgress(info: "Login...")
    }
    
    func loginDone(ret: Bool, errorMsg: String) {
        self.hideProgress()
        
        DispatchQueue.main.async {
            if ret{
                let vc = MainTabBarController()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }else{
                self.showMessage(title: errorMsg, message: "")
            }
        }
    }
}
