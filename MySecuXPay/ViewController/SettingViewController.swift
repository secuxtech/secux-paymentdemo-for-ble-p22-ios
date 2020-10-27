//
//  SettingViewController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/11.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import secux_paymentkit_v2

class SettingViewController: BaseViewController{
    
    lazy var titleView: AccountSettingTitleView = {
       
        let theView = AccountSettingTitleView()
        theView.translatesAutoresizingMaskIntoConstraints = false
        theView.theDelegate = self
        self.view.addSubview(theView)
        
        NSLayoutConstraint.activate([
        
            theView.topAnchor.constraint(equalTo: self.view.topAnchor),
            theView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            theView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            theView.heightAnchor.constraint(equalToConstant: 200)
        
        ])
        
        
        return theView
        
    }()
    
    lazy var theTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x:0, y:0, width: 0, height: 0), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.estimatedRowHeight = 60
        tableView.rowHeight = 60 //UITableView.automaticDimension
        //tableView.separatorStyle = .none
        tableView.backgroundColor = .white
 
        tableView.allowsSelection = true
        //tableView.isScrollEnabled = true
        
        
        tableView.backgroundColor = UISetting.shared.vcBKColor

        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50)
            
        ])
        
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.cellIdentifier())
        
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UISetting.shared.vcBKColor
      
        //DispatchQueue.global(qos: .default).async{
        //    self.getAccountInfo()
        //}
        
        let _ = self.titleView
        self.theTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.title = ""
        
        if MyAccount.shared.passwordChanged{
            self.showMessage(title: "Password changed", message: "")
            MyAccount.shared.passwordChanged = false
        }
    }
    
}


extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell
        
        //if indexPath.section < 2 && indexPath.row == 0{
        
        cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.cellIdentifier(), for:indexPath)
        cell.selectionStyle = .none
        cell.tintColor = .gray
        if let commonCell = cell as? SettingTableViewCell{
            
            /*
            if indexPath.section == 0 && indexPath.row == 0{
                
                commonCell.setup(title:"Update user information", value: "")
                
            }else
            */
            if indexPath.section == 0 && indexPath.row == 0{
                
                commonCell.setup(title: "Change password", value: "")
                commonCell.accessoryType = .disclosureIndicator
                
            }else if indexPath.section == 0 && indexPath.row == 1{
                
                commonCell.setup(title: "Logout", value: "")
                commonCell.accessoryType = .disclosureIndicator
                
            }else if indexPath.section == 1 && indexPath.row == 0{
                
                if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String{
                    commonCell.setup(title: "Version", value: appVersion)
                }else{
                    commonCell.setup(title: "Version", value: "")
                }
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            return "Account"
        }else{
            return "About"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0{
            
            let vc = ChangePasswordViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if indexPath.section == 0 && indexPath.row == 1{
            Setting.shared.logoutFlag = true
            self.logout()
            
        }else if indexPath.section == 0 && indexPath.row == 2{
            
        }
    }
}

extension SettingViewController : AccountSettingTitleViewDelegate{
    func enableTestMode() {
        
        
        let accMgr = SecuXAccountManager()
        
        let alert = UIAlertController(title: "Set Server URL", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = accMgr.getBaseServer()
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            if let textField = alert?.textFields![0], let newUrl = textField.text, newUrl.count > 0{
                //print("Text field: \(textField.text)")
                accMgr.setBaseServer(url: newUrl)
                self.logout()
            }
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)

    }
    
}
