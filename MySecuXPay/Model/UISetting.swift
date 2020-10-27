//
//  UISetting.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/26.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import Foundation
import UIKit

class UISetting: NSObject {
    
    let vcBKColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
    let titleBKColor = UIColor(red: 0x1F/255, green: 0x20/255, blue: 0x20/255, alpha: 1)
    let buttonColor = UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1)
    let receiptInfoColor = UIColor(red: 0x1F/255, green: 0x20/255, blue: 0x20/255, alpha: 1)
    let itemSelectColor = UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 0.5)
    let purpleColor = UIColor(red: 91/255, green: 51/255, blue: 101/255, alpha: 1)
    
    let fontName = "Helvetica"
    let boldFontName = "Helvetica-Bold"
    
    let maxUIControlLen: CGFloat = 400
    
    static let shared: UISetting = {
        let shared = UISetting()
        
        return shared
    }()

    private override init(){
        super.init()
        print("UISetting init")
    }
    
    deinit {
        print("UISetting deinit")
    }
    
}
