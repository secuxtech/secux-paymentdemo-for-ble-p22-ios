//
//  MyAccount.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/10.
//  Copyright © 2020 SecuX. All rights reserved.
//

import Foundation
import secux_paymentkit_v2

class MyAccount : NSObject{
    
    var theUserAccount : SecuXUserAccount?
    
    var theCoinTokenAccountArray : [CoinTokenAccount]?
    
    var theCoinAddressSeedDict = [String : String]()
    
    var passwordChanged = false
    
    static let shared: MyAccount = {
        let shared = MyAccount()
        
        return shared
    }()

    private override init(){
        super.init()
        print("MyAccount init")
        
        
    }
    
    deinit {
        print("MyAccount deinit")
    }
    
    public func setUserAccount(userAccount: SecuXUserAccount){
        self.theUserAccount = userAccount
        self.theCoinTokenAccountArray = CoinTokenAccount.getCoinTokenAccounts(userAccount: userAccount)
        print("setUserAccount done coinTokenArray count = \(self.theCoinTokenAccountArray?.count ?? 0)")
        
        //loadCoinAddressAndSeedDict()
    }
    
    public func getCoinTokenAccount(coinType:String, token:String) -> CoinTokenAccount?{
        
        guard let accountArray = self.theCoinTokenAccountArray else {
            return nil
        }
        
        for account in accountArray{
            if account.coinType == coinType, account.token == token{
                return account
            }
        }

        return nil
    }
    
    public func getCoinTokenAccount(coinType:String) -> CoinTokenAccount?{
        
        guard let accountArray = self.theCoinTokenAccountArray else {
            return nil
        }
        
        for account in accountArray{
            if account.coinType == coinType{
                return account
            }
        }
        
        return nil
    }
    
    public func getCoinTokenAccount(token:String) -> CoinTokenAccount?{
        
        guard let accountArray = self.theCoinTokenAccountArray else {
            return nil
        }
        
        for account in accountArray{
            if account.token == token{
                return account
            }
        }
        
        return nil
    }
    
    public func getCoinTokenAccountArray(coin:String, token:String) -> [CoinTokenAccount]{
        
        var accountArrRet = [CoinTokenAccount]()
        
        guard let accountArray = self.theCoinTokenAccountArray else {
            return accountArrRet
        }
        
        for account in accountArray{
            if account.coinType == coin, account.token == token{
                accountArrRet.append(account)
            }
        }
        
        return accountArrRet
    }
    
    public func updateCoinAddressAndSeedDict(address: String, seed: Data){
        self.theCoinAddressSeedDict[address] = seed.hexDescription
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: self.theCoinAddressSeedDict, options: .prettyPrinted)
            if let jsonDataString = String(data: jsonData, encoding: .utf8){
                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
                   let fileName = self.theUserAccount?.name{

                    let fileURL = dir.appendingPathComponent(fileName + ".json")

                    do {
                        try jsonDataString.write(to: fileURL, atomically: false, encoding: .utf8)
                    }catch {
                        logw("Write to file \(fileURL) failed. error: \(error.localizedDescription)")
                    }
                }
            }
        }catch{
            let errormsg = error.localizedDescription
            logw("MyAccount updateCoinAddressAndSeedDict generate json from dict \(errormsg)")
        }
    }
    
    public func loadCoinAddressAndSeedDict(){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
           let fileName = self.theUserAccount?.name{

            let fileURL = dir.appendingPathComponent(fileName + ".json")

            do {
                let jsonString = try String(contentsOf: fileURL, encoding: .utf8)
                if let jsonData = jsonString.data(using: .utf8),
                   let dict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:String]{
                    
                    self.theCoinAddressSeedDict = dict
                    
                }
            }catch {
                let errormsg = error.localizedDescription
                logw("MyAccount loadCoinAddressAndSeedDict generate dict from file failed!\(errormsg)")
            }
        }
    }
    
}
