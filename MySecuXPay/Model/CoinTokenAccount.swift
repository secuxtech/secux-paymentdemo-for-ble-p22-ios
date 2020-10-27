//
//  CoinTokenAccount.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/10.
//  Copyright © 2020 SecuX. All rights reserved.
//

import Foundation
import secux_paymentkit_v2


class CoinTokenAccount: NSObject{
    
    var accountName = ""
    var coinType = ""
    var token = ""
    var accountBalance: SecuXCoinTokenBalance?
    
    static var serverSupportedCoinAndTokenArray = [(coin:String, token:String)]()
    
    init(account:SecuXCoinAccount, token:String){
        self.accountName = account.accountName
        self.coinType = account.coinType
        self.token = token
        self.accountBalance = account.getTokenBalance(token: token)
        
    }
    
    public func getCoinLogo() -> UIImage?{
        return CoinTokenAccount.getCoinLogo(type: coinType)
    }
    
    static func getCoinLogo(type: String) -> UIImage?{
        switch type {
        case "BTC":
            return UIImage(named: "btc")
            
        case "BCH":
            return UIImage(named: "bch")
            
        case "BNB":
            return UIImage(named: "bnb")
                        
        case "DCT":
            return UIImage(named: "dct")
            
        case "DGB":
            return UIImage(named: "dgb")
                        
        case "DSH":
            return UIImage(named: "dsh")
                        
        case "ETH":
            return UIImage(named: "eth")
                        
        case "GRS":
            return UIImage(named: "grs")
            
        case "LBR":
            return UIImage(named: "lbr")
                        
        case "LTC":
            return UIImage(named: "ltc")
                        
        case "XRP":
            return UIImage(named: "xrp")
            
        case "DASH":
            return UIImage(named: "dash")
            
        case "CELO":
            return UIImage(named: "celo")
            
        default:
            return nil
        }
    }
    
    static func getCoinTokenAccounts(userAccount: SecuXUserAccount) -> [CoinTokenAccount]{
        var tokenAccountArr = [CoinTokenAccount]()
        
        guard userAccount.coinAccountArray.count > 0 else{
            return tokenAccountArr
        }
        
        for coinAccount in userAccount.coinAccountArray{
            let tokenArr = coinAccount.tokenBalanceDict.keys
            
            for token in tokenArr{
                let tokenAccount = CoinTokenAccount(account: coinAccount, token: token)
                
                tokenAccountArr.append(tokenAccount)
            }
        }
        
        return tokenAccountArr
        
    }
    
}
