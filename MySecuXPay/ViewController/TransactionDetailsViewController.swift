//
//  TransactionDetailsViewController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/10.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import WebKit

class TransactionDetailsViewController: BaseViewController{
    
    var detailURL : String?
     
     lazy var webView: WKWebView = {
        
         let webview = WKWebView()
         webview.translatesAutoresizingMaskIntoConstraints = false
         webview.navigationDelegate = self
         self.view.addSubview(webview)
         NSLayoutConstraint.activate([
            
             webview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
             webview.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
             webview.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
             webview.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
            
         ])
         
         return webview
         
     }()
     
    
     
     override func viewDidLoad() {
         super.viewDidLoad()

         // Do any additional setup after loading the view.
         /*
         self.navigationController?.navigationBar.isTranslucent = false
         //self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1)
         self.navigationController?.navigationBar.barTintColor = UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1)
         
         self.navigationController?.navigationBar.tintColor = .white
         //self.navigationController?.navigationBar.topItem?.title = "Payment"
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 24)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor.white]
        
        */
        var backtoRoot = false
        guard let navigationController = self.navigationController else { return }
        let navigationArray = navigationController.viewControllers
        //navigationArray.remove(at: navigationArray.count - 2)
        var idx = 0
        for vc in navigationArray{
            if vc.isKind(of: PaymentResultViewController.self){
            
                //navigationArray.remove(at: idx)
                backtoRoot = true
                
                break
                
            }else{
                idx = idx + 1
            }
        }
        //self.navigationController?.viewControllers = navigationArray
        let navBase = self.navigationController as? BaseUINavigationController
        if backtoRoot{
            navBase?.popToRootFlag = true
        }else{
            navBase?.gobackCount = 2
        }
    }
     
     
     override func viewWillAppear(_ animated: Bool) {
         logw("Transaction details page")
         super.viewWillAppear(animated)
         
         //self.navigationController?.navigationBar.isHidden = false
         
         if let detailurl = self.detailURL, let theURL = URL(string:detailurl){
             
             logw("URL \(detailurl)")
             self.showProgress(info: "Loading...")
             
             let theRequest = URLRequest(url: theURL)
             webView.load(theRequest)
             
         }
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         //self.navigationController?.navigationBar.isHidden = true
     }
    
}

extension TransactionDetailsViewController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView,didFinish navigation: WKNavigation!) { print("loaded")
        self.hideProgress()
    }
}
