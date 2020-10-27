//
//  RefillResultViewController.swift
//  SecuX EvPay
//
//  Created by maochun on 2020/7/16.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

class RefillResultViewController: BaseViewController {
    
    var result: Bool = true{
            didSet {
                if result{
                    self.itemImage.image = UIImage(named: "payment_success")
                    self.resultLabel.text = "Refill Successful"
                    self.resultLabel.textColor = UIColor(red: 0.32, green: 0.73, blue: 0.14,alpha:1)
                    self.amountLabel.textColor = UIColor(red: 0.32, green: 0.73, blue: 0.14,alpha:1)
                }else{
                    self.itemImage.image = UIImage(named: "payment_failed")
                    self.resultLabel.text = "Refill failed"
                    self.resultLabel.textColor = UIColor(red: 0.98, green: 0.48, blue: 0.48,alpha:1)
                    self.amountLabel.textColor = UIColor(red: 0.98, green: 0.48, blue: 0.48,alpha:1)
                }
                
            }
        }
        
        var amount: String = ""{
            didSet{
                self.amountLabel.text = amount
            }
        }
        
        var storeName: String = ""{
            didSet{
                //self.theTableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
            }
        }
        
        var token: String = ""
        
        var transCode: String = ""{
            didSet{
                self.failReasonLabel.text = transCode
            }
        }
        
        var timestamp: String = ""{
            didSet{
                self.timestampLabel.text = timestamp
            }
        }
        
        var failReason: String = ""{
            didSet{
                self.failReasonLabel.text = failReason
            }
        }
        
        lazy var theTableView: UITableView = {
            let tableView = UITableView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundColor = .white
           
            tableView.rowHeight = 60
            tableView.showsVerticalScrollIndicator = false

            tableView.layer.cornerRadius=5
     
            tableView.allowsSelection = true
            tableView.separatorStyle = .singleLine
            

            view.addSubview(tableView)

            if UIScreen.main.bounds.width > 460{
                NSLayoutConstraint.activate([
                    
                    tableView.topAnchor.constraint(equalTo: self.timestampLabel.bottomAnchor, constant: 30),
                    tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 116),
                    tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -116),
                    tableView.heightAnchor.constraint(equalToConstant: 115)
                ])
            }else{
                NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: self.timestampLabel.bottomAnchor, constant: 30),
                    tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
                    tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
                    tableView.heightAnchor.constraint(equalToConstant: 115)
                    
                ])
            }
            
            tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.cellIdentifier())
            
            return tableView
        }()
        
        lazy var resultLabel : UILabel = {
            let label = UILabel()
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 20)
            label.text = "Payment Successful"
            label.textColor = UIColor(red: 0.32, green: 0.73, blue: 0.14,alpha:1)
            label.textAlignment = NSTextAlignment.center
            
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.sizeToFit()
            
            self.view.addSubview(label)
            
            NSLayoutConstraint.activate([
                
                label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                label.topAnchor.constraint(equalTo: self.itemImage.bottomAnchor, constant: 18)
                
            ])
            
            return label
        }()
        
        lazy var amountLabel : UILabel = {
            let label = UILabel()
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.font = UIFont.init(name: UISetting.shared.fontName, size: 42)
            label.text = ""
            label.textColor = UIColor(red: 0.32, green: 0.73, blue: 0.14,alpha:1)
            label.textAlignment = NSTextAlignment.center
            
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.sizeToFit()
            
            self.view.addSubview(label)
            
            NSLayoutConstraint.activate([
                
                label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                label.topAnchor.constraint(equalTo: self.resultLabel.bottomAnchor, constant: 11),
                label.heightAnchor.constraint(equalToConstant: 50)
                
            ])
            
            return label
        }()
        
        
        lazy var timestampLabel : UILabel = {
            let label = UILabel()
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.font = UIFont.init(name: UISetting.shared.fontName, size: 16)
            label.text = "Payment Successful"
            label.textColor = UIColor(red: 0.75, green: 0.75, blue: 0.75,alpha:1)
            label.textAlignment = NSTextAlignment.center
            
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.sizeToFit()
            
            self.view.addSubview(label)
            
            NSLayoutConstraint.activate([
                
                label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                label.topAnchor.constraint(equalTo: self.amountLabel.bottomAnchor, constant: 18)
                
            ])
            
            return label
        }()
        
        lazy var itemImage: UIImageView = {
            let imageview = UIImageView()
            imageview.translatesAutoresizingMaskIntoConstraints = false
            imageview.image = UIImage(named: "payment_success")
            
            
            self.view.addSubview(imageview)
            
            NSLayoutConstraint.activate([
            
                imageview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 51),
                imageview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            ])
            
            return imageview
        }()
        
        
        lazy var failReasonLabel : UILabel = {
            let label = UILabel()
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.font = UIFont.init(name: UISetting.shared.fontName, size: 16)
            label.text = ""
            label.textColor = UIColor(red: 0.96, green: 0.47, blue: 0.05,alpha:1)
            label.textAlignment = NSTextAlignment.center
            
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.sizeToFit()
            
            self.view.addSubview(label)
            
            NSLayoutConstraint.activate([
                
                label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                label.topAnchor.constraint(equalTo: self.theTableView.bottomAnchor, constant: 30),
                label.leftAnchor.constraint(greaterThanOrEqualTo: self.view.leftAnchor, constant: 20),
                label.rightAnchor.constraint(greaterThanOrEqualTo: self.view.rightAnchor, constant: -20)
                
            ])
            
            return label
        }()

        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            
            self.view.backgroundColor = UISetting.shared.vcBKColor
            
            var _ = self.itemImage
            var _ = self.resultLabel
            var _ = self.amountLabel
            var _ = self.timestampLabel
            
            self.failReasonLabel.text = ""

        }
        

        override func viewWillAppear(_ animated: Bool) {
            logw("Payment Result page")
            
            super.viewWillAppear(animated)
            
            let navBase = self.navigationController as? BaseUINavigationController
            navBase?.popToRootFlag = true
            self.theTableView.reloadData()
        }

        
    }



extension RefillResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.cellIdentifier(), for:indexPath)
        cell.selectionStyle = .none
        if let commonCell = cell as? SettingTableViewCell{
            
            if indexPath.row == 0{
                commonCell.setup(title: "Store", value: self.storeName)
            }else{
                commonCell.setup(title: "Transactions", value: "")
                commonCell.accessoryType = .disclosureIndicator
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1{
            
            //if let account = MyAccount.shared.getCoinTokenAccount(token: self.token){
                //let vc = TransactionHistoryViewController()
                //vc.theAccount = account
                let vc = PaymentHistoryViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            //}
        }
    }
   
}
