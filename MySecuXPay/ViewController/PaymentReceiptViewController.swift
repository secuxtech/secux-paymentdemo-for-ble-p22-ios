//
//  PaymentReceiptViewController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/13.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import secux_paymentkit_v2

class PaymentReceiptViewController: BaseViewController{
    
    var transHistory: SecuXPaymentHistory?
    
    /*
    lazy var receiptLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.fontName, size: 20)
        label.text = ""
        label.textColor = UISetting.shared.receiptInfoColor
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15),
            label.leftAnchor.constraint(equalTo: self.view.rightAnchor, constant: 20)
        
        ])
        
        return label
    }()
    */
    lazy var receiptView: PaymentReceiptView = {
        let recView = PaymentReceiptView()
        recView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(recView)
        
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                recView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
                recView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 160),
                recView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -160),
                recView.heightAnchor.constraint(equalToConstant: 400)
            ])
        }else{
            NSLayoutConstraint.activate([
            
                recView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
                recView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
                recView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
                recView.heightAnchor.constraint(equalToConstant: 400)
            
            ])
        }
        
        
        return recView
        
    }()
    
    
    lazy var detailsButton: UIButton = {
       
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false

        
        let btnAttributes: [NSAttributedString.Key: Any] = [
                            .font: UIFont(name: "Arial", size: 17)!,
                            .foregroundColor: UIColor.black,
                            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "Transaction Details",
                                                        attributes: btnAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
        
        //btn.titleLabel?.font = UIFont(name: "Arial", size: 17)
        //btn.setTitle("Payment History", for: .normal)
        //btn.setTitleColor(.black, for: .normal)
        
        btn.addTarget(self, action: #selector(detailsAction), for: .touchUpInside)
        

        self.view.addSubview(btn)

        NSLayoutConstraint.activate([
           
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -18)
           
        ])

        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UISetting.shared.vcBKColor
        
        //let _ = self.receiptLabel
        let _ = self.detailsButton
        
        
        guard let navigationController = self.navigationController else { return }
        let navigationArray = navigationController.viewControllers
        //navigationArray.remove(at: navigationArray.count - 2)
        var idx = 0
        for vc in navigationArray{
            if vc.isKind(of: PaymentResultViewController.self){
            
                //navigationArray.remove(at: idx)
                let navBase = self.navigationController as? BaseUINavigationController
                navBase?.popToRootFlag = true
                break
                
            }else{
                idx = idx + 1
            }
        }
        //self.navigationController?.viewControllers = navigationArray
        
       

    }
    

    override func viewWillAppear(_ animated: Bool) {
        logw("Payment Result page")
        
        super.viewWillAppear(animated)
        
        //self.navigationController?.navigationBar.isHidden = false
        //self.navigationController?.navigationBar.backItem?.title = "Back"
        
        self.receiptView.Setup(payHis: self.transHistory!)
    }
    
    @objc func detailsAction(){
        let vc = TransactionDetailsViewController()
        vc.detailURL = self.transHistory?.detailsUrl
    
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
