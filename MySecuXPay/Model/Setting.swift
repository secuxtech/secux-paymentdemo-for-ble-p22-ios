//
//  Setting.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/8.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import Foundation
import secux_paymentkit_v2


class Setting: NSObject {
    
    var hasInternet = Observable<Bool>(value: true)

    let testFlag = false
    let forItriTestFlag = false
    let enableRefundFlag = true
    let enableRefillFlag = true
    
    var loginAccount = ""
    var loginPwd = ""
    
    var logoutFlag = false
    
    
    static let shared: Setting = {
        let shared = Setting()
        
        return shared
    }()

    private override init(){
        super.init()
        print("Setting init")
        
        self.loadSettings()
    }
    
    deinit {
        print("Setting deinit")
    }
    
    
    func loadSettings(){
        
        loginAccount = UserDefaults.standard.value(forKey: "Account") as? String ?? ""
        loginPwd = UserDefaults.standard.value(forKey: "Password") as? String ?? ""
        
    }
    
    func saveSetting(){
        
        UserDefaults.standard.set(loginAccount, forKey: "Account")
        UserDefaults.standard.set(loginPwd, forKey: "Password")
        
    }

}
